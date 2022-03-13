import 'dart:io';

import '../constants/ansi.dart';

void displayHeaders() {
  String header = "";

  header += "Permissions".underline() + " ";
  header += "Size".underline() + " ";
  // header += "User".underline() + " ";
  header += "Date Modified".underline() + " ".padRight(4, " ");
  header += "Name".underline() + " ";

  header += "\n";
  stdout.write(header);
}
