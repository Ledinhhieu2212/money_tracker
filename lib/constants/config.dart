import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String FormatDateVi(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
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

String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

DateTime generateRandomDateTime() {
  DateTime now = DateTime.now();
  DateTime startDate = DateTime(now.year, 1, 1);
  DateTime endDate = DateTime(now.year, now.month, now.day);
  int totalDays = endDate.difference(startDate).inDays;

  // Tạo số ngày ngẫu nhiên trong khoảng từ 0 đến totalDays
  int randomDays =
      Random().nextInt(totalDays + 1); // +1 để bao gồm cả ngày cuối

  // Thêm số ngày ngẫu nhiên vào startDate
  DateTime randomDate = startDate.add(Duration(days: randomDays));

  // Trả về kết quả chỉ có phần ngày, giờ mặc định là 00:00:00
  return DateTime(randomDate.year, randomDate.month, randomDate.day);
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

void getOffPage({dynamic page}) {
  Get.off(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}

void getOffAllPage({dynamic page}) {
  Get.offAll(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}

void getToPageToBack({dynamic page}) {
  Get.to(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500), arguments: () {
    Get.to(page);
  });
}
