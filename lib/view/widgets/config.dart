import 'package:get/get.dart';

// ignore: non_constant_identifier_names
void GetToPage({dynamic page}) {
   Get.to(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}

// ignore: non_constant_identifier_names
void GetOffPage({dynamic page}){
  Get.off(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}


// ignore: non_constant_identifier_names
void GetOffAllPage({dynamic page}){
  Get.offAll(page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500));
}