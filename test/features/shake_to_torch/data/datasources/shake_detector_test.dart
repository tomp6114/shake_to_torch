import 'package:flutter_test/flutter_test.dart';
import 'package:shake_to_torch/features/shake_to_torch/domain/entities/shake_sensitivity.dart';
import 'package:shake_to_torch/features/shake_to_torch/data/datasources/shake_detector.dart';

void main() {
  late ShakeDetector detector;

  setUp(() {
    detector = ShakeDetector(ShakeSensitivity.medium); // 15G threshold
  });

  test('should not trigger on small movements less than threshold', () {
    // 5G is below the 15G medium threshold
    final result = detector.processEvent(5 * 9.80665, 0, 0, 100);
    expect(result, isFalse);
  });

  test('should trigger on back-and-forth sequence within 500ms time period', () {
    // 1st shake: +20G on X axis
    var result = detector.processEvent(20 * 9.80665, 0, 0, 100);
    expect(result, isFalse); // Hasn't gone back yet

    // 2nd shake: -20G on X axis within 500ms window (at 300ms -> Delta=200ms)
    result = detector.processEvent(-20 * 9.80665, 0, 0, 300);
    expect(result, isTrue); // Back and forth completed successfully
  });

  test('should clear sequence and NOT trigger if back-and-forth takes longer than 500ms', () {
    detector.processEvent(20 * 9.80665, 0, 0, 100);
    
    // Reverse movement happens too late (Delta=550ms)
    final result = detector.processEvent(-20 * 9.80665, 0, 0, 650);
    expect(result, isFalse);
  });

  test('should enforce the same active axis for the back-and-forth motion', () {
    detector.processEvent(20 * 9.80665, 0, 0, 100); // X axis active
    
    // Strong reverse movement on a different axis shouldn't complete the back-and-forth
    final result = detector.processEvent(0, -20 * 9.80665, 0, 300); // Y axis
    expect(result, isFalse);
  });
}
