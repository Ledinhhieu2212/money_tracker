import 'package:get/get.dart';

class Localization extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': "Hello ",
      "spending": "Spending ",
      "income": "Income ",
      "status_income_spending": "Revenue and expenditure situation" 
    },
    'vi_VN': {
      'hello': "Chào ",
      "spending": "Chi tiêu ",
      "income": "Thu nhập ",
      "status_income_spending": "Tình hình thu chi" 
    }
  };
} 