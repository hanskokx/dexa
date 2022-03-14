import 'dart:io';

import '../constants/ansi.dart';

void displayHeaders({
  required Map<String, bool> args,
  required int fileSizeDigits,
}) {
  String header = "";

  header += "Permissions".underline() + " ";
  header += "Size".underline() + (" " * (fileSizeDigits - 5)) + " ";
  // header += "User".underline() + " ";
  header += "Date Modified".underline() + " ".padRight(4, " ");
  if (args['showFileTypeIcon']!) {
    header += "Icon".underline() + " ";
  }
  header += "Name".underline() + " ";

  header += "\n";
  stdout.write(header);
}