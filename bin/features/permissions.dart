import 'dart:io';

import '../constants/ansi.dart';

String filePermissions(FileStat fileStat) {
  String output = '';
  if (stdout.supportsAnsiEscapes) {
    List<String> permissions = fileStat.modeString().split("");

    for (String i in permissions) {
      switch (i) {
        case "r":
          output += "r".color(AnsiColors.yellow);
          break;
        case "w":
          output += "w".color(AnsiColors.red);
          break;
        case "x":
          output += "x".color(AnsiColors.green);
          break;
        case "-":
          output += "-".color(AnsiColors.green);
          break;
      }
    }
    return output.bold() + ' ';
  }
  return fileStat.modeString();
}
