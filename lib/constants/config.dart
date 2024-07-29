
String FormatDateVi(DateTime date) {
  DateTime currentTime =
      DateTime(date.year, date.month, date.day, date.hour, date.minute);
  String formattedTime =
      '${currentTime.day}/${currentTime.month}/${currentTime.year}';

  return formattedTime;
}
