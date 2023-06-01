import 'package:intl/intl.dart';

timeFormatting(String dateTimeString) {
  final formattedDateTimeString = dateTimeString.split('.')[0];
  final dateTime = DateTime.parse(formattedDateTimeString);
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  final date = formatter.format(dateTime);
  DateTime formattedDateTime = DateTime.parse(date);
  return formattedDateTime;
}
