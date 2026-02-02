class ConvertDate {
  String convertDate(DateTime selectedDates) {
    var selectedDate = selectedDates;
    final safeDate = DateTime.utc(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedDate.hour,
      selectedDate.minute,
      selectedDate.second,
      selectedDate.millisecond,
    );

    var forMated = safeDate.toIso8601String();

    return forMated;
  }
}
