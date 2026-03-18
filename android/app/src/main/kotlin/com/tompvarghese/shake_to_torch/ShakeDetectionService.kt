package com.tompvarghese.shake_to_torch

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.hardware.camera2.CameraManager
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import kotlin.math.abs

class ShakeDetectionService : Service(), SensorEventListener {

    private lateinit var sensorManager: SensorManager
    private var accelerometer: Sensor? = null
    private lateinit var cameraManager: CameraManager
    private var isTorchOn = false

    // State bindings
    private var thresholdG = 15.0 
    private var lastTime = 0L
    private var waitForNegative = false
    private var waitForPositive = false
    private var activeAxis = -1

    override fun onCreate() {
        super.onCreate()
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager

        // Dynamically pull latest sensitivity from Flutter SharedPreferences
        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        val sensitivityStr = prefs.getString("flutter.sensitivity", "medium") ?: "medium"
        thresholdG = when(sensitivityStr) {
            "low" -> 4.5
            "high" -> 2.0
            else -> 3.0
        }

        cameraManager.registerTorchCallback(object : CameraManager.TorchCallback() {
            override fun onTorchModeChanged(cameraId: String, enabled: Boolean) {
                super.onTorchModeChanged(cameraId, enabled)
                val firstCamera = cameraManager.cameraIdList.firstOrNull()
                if (cameraId == firstCamera) {
                    isTorchOn = enabled
                }
            }
        }, null)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        createNotificationChannel()

        val notificationIntent = Intent(this, MainActivity::class.java)
        var pendingIntentFlags = PendingIntent.FLAG_UPDATE_CURRENT
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            pendingIntentFlags = pendingIntentFlags or PendingIntent.FLAG_IMMUTABLE
        }

        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            notificationIntent,
            pendingIntentFlags
        )

        val notification = NotificationCompat.Builder(this, "SHAKE_SERVICE_CHANNEL")
            .setContentTitle("Shake-to-Torch Active")
            .setContentText("Listening for shake events in background... (Locked/Unlocked)")
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setContentIntent(pendingIntent)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(1, notification, android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC)
        } else {
            startForeground(1, notification)
        }

        // Attach listener for screen-locked persistence
        accelerometer?.let {
            sensorManager.registerListener(this, it, SensorManager.SENSOR_DELAY_GAME)
        }

        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        sensorManager.unregisterListener(this)
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event == null) return
        val timestampMs = System.currentTimeMillis()

        val x = event.values[0]
        val y = event.values[1]
        val z = event.values[2]

        val gx = x / 9.80665f
        val gy = y / 9.80665f
        val gz = z / 9.80665f

        var maxG = 0f
        var dominantAxis = -1
        var isPositive = false

        if (abs(gx) > maxG) { maxG = abs(gx); dominantAxis = 0; isPositive = gx > 0 }
        if (abs(gy) > maxG) { maxG = abs(gy); dominantAxis = 1; isPositive = gy > 0 }
        if (abs(gz) > maxG) { maxG = abs(gz); dominantAxis = 2; isPositive = gz > 0 }

        if (activeAxis != -1 && timestampMs - lastTime > 500) {
            waitForNegative = false
            waitForPositive = false
            activeAxis = -1
        }

        if (maxG > thresholdG) {
            if (activeAxis == -1) {
                activeAxis = dominantAxis
                lastTime = timestampMs
                if (isPositive) waitForNegative = true else waitForPositive = true
            } else if (activeAxis == dominantAxis) {
                if ((isPositive && waitForPositive) || (!isPositive && waitForNegative)) {
                    // Deliberate back and forth sequence completed within threshold!
                    activeAxis = -1
                    waitForNegative = false
                    waitForPositive = false
                    lastTime = timestampMs
                    
                    // Directly toggle torch, MainActivity callback handles haptics and syncing
                    toggleTorchFromService()
                }
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    private fun toggleTorchFromService() {
        try {
            val cameraId = cameraManager.cameraIdList.firstOrNull()
            if (cameraId != null) {
                cameraManager.setTorchMode(cameraId, !isTorchOn)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val serviceChannel = NotificationChannel(
                "SHAKE_SERVICE_CHANNEL",
                "Shake Detection Service",
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(serviceChannel)
        }
    }
}
