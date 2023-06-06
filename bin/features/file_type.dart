part of '../dexa.dart';

String fileType(FileStat fileStat) {
  String? type = fileStat.type.toString()[0];
  if (fileStat.type.toString()[0] == "f") type = ".";
  if (stdout.supportsAnsiEscapes) {
    switch (type) {
      case "d":
        type = type.color(AnsiColors.cyan);
        break;
      default:
        type = type.color(AnsiColors.white);
    }
    type = type.bold();
  }

  return type;
}
