import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

DateTime removeTimeDate(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

String formatMoney(double money) {
  final NumberFormat formatter = NumberFormat('#,##0', 'vi_VN');
  return formatter.format(money);
}

String removeCurrencySeparator(String amount) {
  return amount.replaceAll('.', '');
}

class MoneyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,##0', 'vi_VN');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Xóa các ký tự không phải số
    final newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Nếu văn bản rỗng, trả về giá trị gốc
    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Định dạng văn bản mới
    final formattedText = _formatter.format(int.parse(newText));

    // Trả về giá trị đã định dạng
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
 
 
void getToPage({dynamic page}) {
   Get.to(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}

void getOffPage({dynamic page}){
  Get.off(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}


void getOffAllPage({dynamic page}){
  Get.offAll(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}