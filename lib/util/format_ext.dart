import 'package:intl/intl.dart';

final _dateFormat = DateFormat("d MMM y, HH:mm");
final _numberFormat = NumberFormat("##0.#", "en_GB");

extension DateFormatExt on DateTime {
  String get formatted => _dateFormat.format(this);
}

extension NumberFormatExt on double {
  String get percent => "${_numberFormat.format(this * 100)}%";
}
