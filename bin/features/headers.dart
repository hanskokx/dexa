part of '../dexa.dart';

String getHeaders({
  bool showFileTypeIcon = false,
  required int fileSizeDigits,
}) {
  final String padding = stdout.supportsAnsiEscapes ? " " : '';
  String header = "";

  header += "${"Permissions".underline()} ";
  header += "${"Size".underline()}${" " * (fileSizeDigits - 5)} $padding";
  // header += "User".underline() + " ";
  header += "${"Date Modified".underline()}  $padding";
  if (showFileTypeIcon) {
    header += " ${"Icon".underline()}$padding";
  }

  header += "${"Name".underline()} $padding";

  header += "\n";

  return header;
}
