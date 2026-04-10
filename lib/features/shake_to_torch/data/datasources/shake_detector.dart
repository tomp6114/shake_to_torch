import '../../domain/entities/shake_sensitivity.dart';

class ShakeDetector {
  ShakeSensitivity _sensitivity;
  
  int _lastTime = 0;
  bool _waitForNegative = false;
  bool _waitForPositive = false;
  int _activeAxis = -1; // 0=X, 1=Y, 2=Z
  
  ShakeDetector(this._sensitivity);
  
  void setSensitivity(ShakeSensitivity sensitivity) {
    _sensitivity = sensitivity;
  }
  
  /// Returns [true] if a complete back-and-forth shake was detected 
  /// within the configured window frame (500ms).
  bool processEvent(double x, double y, double z, int timestampMs) {
    final gx = x / 9.80665;
    final gy = y / 9.80665;
    final gz = z / 9.80665;
    
    double maxG = 0;
    int dominantAxis = -1;
    bool isPositive = false;
    
    if (gx.abs() > maxG) { maxG = gx.abs(); dominantAxis = 0; isPositive = gx > 0; }
    if (gy.abs() > maxG) { maxG = gy.abs(); dominantAxis = 1; isPositive = gy > 0; }
    if (gz.abs() > maxG) { maxG = gz.abs(); dominantAxis = 2; isPositive = gz > 0; }
    
    // If we exceed 500ms since the last strong movement, reset the back-and-forth state.
    if (_activeAxis != -1 && timestampMs - _lastTime > 500) {
      _waitForNegative = false;
      _waitForPositive = false;
      _activeAxis = -1;
    }
    
    if (maxG > _sensitivity.thresholdG) {
      if (_activeAxis == -1) {
        // This is the first strong movement initializing the back-and-forth expectation
        _activeAxis = dominantAxis;
        _lastTime = timestampMs;
        if (isPositive) {
          _waitForNegative = true;
        } else {
          _waitForPositive = true;
        }
      } else if (_activeAxis == dominantAxis) {
        // We are on the same active axis. Check if we moved in the opposite direction.
        if ((isPositive && _waitForPositive) || (!isPositive && _waitForNegative)) {
          _activeAxis = -1;
          _waitForNegative = false;
          _waitForPositive = false;
          _lastTime = timestampMs;
          return true;
        }
      }
    }
    
    return false;
  }
}
