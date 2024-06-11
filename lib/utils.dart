import 'package:intl/intl.dart';

String formatNumber(int n) {
  return NumberFormat("#,###").format(n);
}