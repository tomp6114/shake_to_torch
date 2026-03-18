enum ShakeSensitivity {
  high(2.0),    // Highly sensitive, small shakes detect
  medium(3.0),  // Normal sensitivity
  low(4.5);     // Requires significant force

  final double thresholdG;

  const ShakeSensitivity(this.thresholdG);
}
