import 'dart:io';

import '../constants/ansi.dart';

String fileOwner(FileStat fileStat) {
  // TODO: This isn't actually possible at this time. https://github.com/dart-lang/sdk/issues/47478
  String output = "";
  if (stdout.supportsAnsiEscapes) {
    return output.color(AnsiColors.yellow).bold();
  }
  return output;
}
