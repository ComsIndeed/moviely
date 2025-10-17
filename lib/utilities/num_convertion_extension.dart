// file: duration_extensions.dart

extension DurationFromNum on num {
  /// Converts the number into a Duration based on the provided field.
  Duration toDuration({required DurationField field}) {
    switch (field) {
      case DurationField.seconds:
        return Duration(seconds: toInt());
      case DurationField.minutes:
        return Duration(minutes: toInt());
      case DurationField.hours:
        return Duration(hours: toInt());
      case DurationField.days:
        return Duration(days: toInt());
      case DurationField.milliseconds:
        return Duration(milliseconds: toInt());
    }
  }
}

// Helper enum for clarity
enum DurationField { seconds, minutes, hours, days, milliseconds }
