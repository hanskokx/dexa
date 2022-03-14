import 'dart:io';

import '../constants/ansi.dart';

void displayHeaders({
  required Map<String, bool> args,
  required int fileSizeDigits,
}) {
  String header = "";
  String padding = '';

  if (stdout.supportsAnsiEscapes) {
    padding = ' ';
  }

  header += "Permissions".underline() + " ";
  header += "Size".underline() + (" " * (fileSizeDigits - 5)) + " " + padding;
  // header += "User".underline() + " ";
  header += "Date Modified".underline() + "   " + padding;
  if (args['showFileTypeIcon']!) {
    header += "Icon".underline();
  }
  header += " " + "Name".underline() + " " + padding;

  header += "\n";
  stdout.write(header);
}
