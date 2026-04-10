enum ShakeSensitivity {
  /// Low threshold; detects minor wrist flicks
  high(2.0),
  /// Balanced threshold for intentional shakes
  medium(3.0),
  /// High threshold requiring forceful movement
  low(4.5);

  final double thresholdG;

  const ShakeSensitivity(this.thresholdG);
}
