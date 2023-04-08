import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:provider/provider.dart';
import 'package:sariapp/providers/RoutingNav.dart';
import 'package:sariapp/utils/Constants.dart';

class Helper {
  static void changeScreen(context, index) {
    Provider.of<RoutingNav>(context, listen: false).setPageIndex(index);
    Provider.of<RoutingNav>(context, listen: false)
        .pageController
        .jumpToPage(index);
  }

  static void closeDialog(context) {
    Navigator.pop(context);
  }

  static void showWarningToast(context, message) {
    MotionToast(
        description: Text(message),
        position: MotionToastPosition.top,
        borderRadius: 0.0,
        height: 36.0,
        iconSize: 20.0,
        icon:  Icons.info,
        primaryColor: HexColor(kGoldWebColor),
        width:  300,
        enableAnimation: false)
        .show(context);
  }

  static void showErrorToast(context, message) {
    MotionToast.error(
            description: Text(message),
            position: MotionToastPosition.top,
            borderRadius: 0.0,
            height: 36.0,
            iconSize: 20.0,
            enableAnimation: false)
        .show(context);
  }

  static void showInfoToast(context, message) {
    MotionToast(
            description: Text(message),
            position: MotionToastPosition.top,
            borderRadius: 0.0,
            height: 36.0,
            iconSize: 20.0,
            icon:  Icons.info,
            primaryColor: HexColor(kIndigoColor),
            width:  300,
            enableAnimation: false)
        .show(context);
  }
}
