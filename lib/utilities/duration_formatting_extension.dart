// file: duration_extensions.dart (cont.)

extension DurationFormatting on Duration {
  /// Converts a Duration into a H:M:S string, omitting leading zero padding.
  String get toHmsString {
    // 1. Get total hours, then the remainder minutes/seconds
    int totalHours = inHours;
    int remainingMinutes = inMinutes.remainder(60);
    int remainingSeconds = inSeconds.remainder(60);

    // 2. Format parts. Note: We do NOT use padLeft() on hours/minutes.
    String hoursStr = totalHours.toString();
    String minutesStr = remainingMinutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    // 3. Conditional formatting:
    if (totalHours > 0) {
      // If there are hours, include them: H:MM:SS
      return '$hoursStr:$minutesStr:$secondsStr';
    } else if (remainingMinutes > 0) {
      // If there are minutes (but no hours): M:SS
      // We explicitly skip the minutesStr padLeft(2) for the single-digit minute
      return '$remainingMinutes:$secondsStr';
    } else {
      // Otherwise, just show seconds: S
      // If you always want MM:SS even if it's 0:01, change this to return '0:$secondsStr'
      return secondsStr;
    }
  }
}
