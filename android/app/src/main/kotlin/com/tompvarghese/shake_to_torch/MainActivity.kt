package com.tompvarghese.shake_to_torch

import android.content.Context
import android.content.Intent
import android.hardware.camera2.CameraManager
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.tompvarghese.shake_to_torch/torch"
    private var isTorchOn = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as? CameraManager
        val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as? android.os.Vibrator
        
        try {
            cameraManager?.registerTorchCallback(object : CameraManager.TorchCallback() {
                override fun onTorchModeChanged(cameraId: String, enabled: Boolean) {
                    super.onTorchModeChanged(cameraId, enabled)
                    val firstCamera = cameraManager.cameraIdList.firstOrNull()
                    if (cameraId == firstCamera) {
                        isTorchOn = enabled
                        
                        // Small vibration trigger across all UI / Background interactions
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            vibrator?.vibrate(android.os.VibrationEffect.createOneShot(50, android.os.VibrationEffect.DEFAULT_AMPLITUDE))
                        } else {
                            @Suppress("DEPRECATION")
                            vibrator?.vibrate(50)
                        }
                    }
                }
            }, null)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getTorchState" -> {
                    result.success(isTorchOn)
                }
                "toggleTorch" -> {
                    val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
                    try {
                        val cameraId = cameraManager.cameraIdList.firstOrNull()
                        if (cameraId != null) {
                            cameraManager.setTorchMode(cameraId, !isTorchOn)
                            // State updates natively via our background onCreate listener
                            result.success(!isTorchOn)
                        } else {
                            result.error("UNAVAILABLE", "Camera ID not found", null)
                        }
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }
                }
                "startService" -> {
                    val serviceIntent = Intent(this, ShakeDetectionService::class.java)
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        startForegroundService(serviceIntent)
                    } else {
                        startService(serviceIntent)
                    }
                    result.success(null)
                }
                "stopService" -> {
                    val serviceIntent = Intent(this, ShakeDetectionService::class.java)
                    stopService(serviceIntent)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
