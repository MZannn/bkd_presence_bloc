import 'package:intl/intl.dart';

String formatDate(String inputDateTime) {
  final inputFormat = DateFormat('yyyy-MM-dd');
  final outputFormat = DateFormat('EEEE, dd-MM-yyyy', 'id');

  final dateTime = inputFormat.parse(inputDateTime);
  final dateString = outputFormat.format(dateTime);
  return dateString;
}
