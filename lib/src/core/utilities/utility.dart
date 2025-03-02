import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utility {
  static void navigate(
      {required BuildContext context,
      required String route,
      Object? arguments,
      bool root = false}) {
    Navigator.of(context, rootNavigator: root)
        .pushNamed(route, arguments: arguments);
  }

  static void navigateBack({required BuildContext context, dynamic data}) =>
      Navigator.pop(context, data);

  static void showSnackBar({
    required BuildContext context,
    required String content,
    String? type,
  }) {
    late final Color color;

    switch (type) {
      case 'success':
        color = Colors.green;
        break;
      case 'error':
        color = Colors.red;
        break;
      default:
        color = Colors.black;
    }

    final snackBar = SnackBar(
      content: Text(content),
      backgroundColor: color,
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  static String listToString(List<String> items) {
    return items.join(', ');
  }

  static String capitalizeFirst(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  static String thousandFormatted(num number) {
    // final formatter = NumberFormat("#,##0.00");
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(number);
  }
}
