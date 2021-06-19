import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Helpers {
  static final money = NumberFormat("##,###.00", "in-ID");

  static String moneify(int amount) {
    return "Rp. " + money.format(amount);
  }

  static Iterable<E> mapIndexed<E, T>(
      Iterable<T> items, E Function(int index, T item) callback) sync* {
    int index = 0;

    for (final item in items) {
      yield callback(index, item);
      index++;
    }
  }

  static List<TextEditingController> generateEditingControllers(int amount) {
    List<TextEditingController> result = [];

    for (int i = 1; i <= amount; i++) {
      result.add(TextEditingController());
    }

    return result;
  }

  static changeStatusBarColor({Color color: Colors.transparent, dark: true}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: !dark ? Brightness.light : Brightness.dark));
  }
}
