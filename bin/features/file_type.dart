import 'dart:io';

import '../constants/ansi.dart';

String fileType(fileStat) {
  late String? type;
  type = fileStat.type.toString()[0];
  if (fileStat.type.toString()[0] == "f") type = ".";
  if (stdout.supportsAnsiEscapes) {
    switch (type) {
      case "d":
        type = type.color(AnsiColors.cyan).bold();
        break;
      default:
        type = type.color(AnsiColors.white).bold();
    }
  }

  return (type);
}
