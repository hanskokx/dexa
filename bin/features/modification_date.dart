import 'dart:io';

import 'package:intl/intl.dart';

import '../constants/ansi.dart';

String fileModificationDate(FileStat fileStat) {
  DateTime modified = fileStat.modified;
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  String output = formatter.format(modified).padRight(17, " ");
  if (stdout.supportsAnsiEscapes) {
    output = output.color(AnsiColors.cyan);
  }
  return output;
}
