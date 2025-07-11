enum SyncInterval {
  daily(24 * 60 * 60 * 1000, '1 Day'),
  everyTwoDays(2 * 24 * 60 * 60 * 1000, '2 Days'),
  weekly(7 * 24 * 60 * 60 * 1000, '1 Week'),
  biweekly(15 * 24 * 60 * 60 * 1000, '15 Days'),
  monthly(30 * 24 * 60 * 60 * 1000, '1 Month');

  const SyncInterval(this.milliseconds, this.label);

  final int milliseconds;
  final String label;
}
