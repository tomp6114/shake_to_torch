enum ShakeSensitivity {
  high(10.0),   // Highly sensitive, small shakes detect
  medium(15.0), // Normal sensitivity
  low(20.0);    // Requires significant force

  final double thresholdG;

  const ShakeSensitivity(this.thresholdG);
}
