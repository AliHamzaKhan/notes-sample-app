


import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final now = DateTime.now();

  if (date.year == now.year &&
      date.month == now.month &&
      date.day == now.day) {
    return 'Today, ${DateFormat('hh:mm a').format(date)}';
  }

  if (date.year == now.subtract(const Duration(days: 1)).year &&
      date.month == now.subtract(const Duration(days: 1)).month &&
      date.day == now.subtract(const Duration(days: 1)).day) {
    return 'Yesterday, ${DateFormat('hh:mm a').format(date)}';
  }

  return DateFormat('dd/MM/yyyy').format(date);
}