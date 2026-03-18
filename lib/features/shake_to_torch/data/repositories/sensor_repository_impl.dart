import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../../domain/entities/shake_sensitivity.dart';
import '../../domain/repositories/sensor_repository.dart';
import '../datasources/shake_detector.dart';

class SensorRepositoryImpl implements SensorRepository {
  final ShakeDetector _detector;
  StreamSubscription<UserAccelerometerEvent>? _subscription;
  final _shakeEventController = StreamController<void>.broadcast();

  SensorRepositoryImpl({ShakeDetector? detector})
      : _detector = detector ?? ShakeDetector(ShakeSensitivity.medium);

  @override
  Stream<void> get shakeEvents => _shakeEventController.stream;

  @override
  Future<void> startListening() async {
    // Left empty internally as BLoC handles starting the MethodChannel Service directly.
    // The native Android layer entirely executes the algorithm guaranteeing locked-screen operation!
  }

  @override
  Future<void> stopListening() async {
    // Matches identical native delegation.
  }

  @override
  void setSensitivity(ShakeSensitivity sensitivity) {
    _detector.setSensitivity(sensitivity);
  }
}
