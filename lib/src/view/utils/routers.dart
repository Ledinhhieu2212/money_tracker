import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  PageNavigator({this.ctx});
  // Ngữ cảnh điều hướng giữa các trang
  BuildContext? ctx;

  // Đều hướng đến trang mới và giữ lại các trang trước đó trong stack điều hướng
  Future nextPage({Widget? page}) {
    return Navigator.push(
        ctx!,
        MaterialPageRoute(
          builder: (context) => page!,
        ));
  }

  // Điều hướng đến một trang mới và loại bỏ tất cả các trang trước đó khỏi stack điều hướng.
  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
      ctx!,
      MaterialPageRoute(
        builder: (context) => page!,
      ),
      (route) => false,
    );
  }
}