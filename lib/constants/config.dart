import 'package:intl/intl.dart';

String FormatDateVi(DateTime date) {
  DateTime currentTime =
      DateTime(date.year, date.month, date.day, date.hour, date.minute);
  String formattedTime =
      '${currentTime.day}/${currentTime.month}/${currentTime.year}';

  return formattedTime;
}

DateTime formatStringToDate(String date) {
  try {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateTime parsedDate = dateFormat.parse(date);
    return parsedDate;
  } catch (e) {
    return DateTime.now();
  }
}
