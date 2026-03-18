import 'dart:async';
import 'package:flutter/services.dart';
import '../../domain/entities/shake_sensitivity.dart';
import '../../domain/repositories/sensor_repository.dart';
import '../datasources/shake_detector.dart';

class SensorRepositoryImpl implements SensorRepository {
  final ShakeDetector _detector;
  final _shakeEventController = StreamController<void>.broadcast();

  SensorRepositoryImpl({ShakeDetector? detector})
      : _detector = detector ?? ShakeDetector(ShakeSensitivity.medium);

  @override
  Stream<void> get shakeEvents => _shakeEventController.stream;

  static const _channel = MethodChannel('com.tompvarghese.shake_to_torch/torch');

  @override
  Future<void> startListening() async {
    try {
      await _channel.invokeMethod('startService');
    } catch (e) {
      // Handle native bridge error safely
    }
  }

  @override
  Future<void> stopListening() async {
    try {
      await _channel.invokeMethod('stopService');
    } catch (e) {
      // Handle native bridge error safely
    }
  }

  @override
  void setSensitivity(ShakeSensitivity sensitivity) {
    _detector.setSensitivity(sensitivity);
  }
}
