part of '../dexa.dart';

String fileModificationDate(FileStat fileStat) {
  final DateTime modified = fileStat.modified;
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  String output = formatter.format(modified).padRight(17, " ");
  if (stdout.supportsAnsiEscapes) {
    output = output.color(AnsiColors.cyan);
  }
  return output;
}
