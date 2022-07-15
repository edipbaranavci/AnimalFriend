import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PageTo {
  static page(Widget widget,
      {Transition? transition = Transition.fade, dynamic arguments}) {
    Get.to(
      widget,
      transition: transition,
      arguments: arguments,
    );
  }
}
