import '../entities/shake_sensitivity.dart';

abstract class SensorRepository {
  /// Stream that emits an event whenever a verified "shake" is detected.
  Stream<void> get shakeEvents;

  /// Starts listening to the hardware sensors
  Future<void> startListening();

  /// Stops listening to hardware sensors
  Future<void> stopListening();

  /// Updates the algorithm's sensitivity dynamically
  void setSensitivity(ShakeSensitivity sensitivity);
}
