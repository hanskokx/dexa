part of '../dexa.dart';

String fileOwner(FileStat fileStat) {
  // TODO: This isn't actually possible at this time. https://github.com/dart-lang/sdk/issues/47478
  const String output = "";
  if (stdout.supportsAnsiEscapes) {
    return output.color(AnsiColors.yellow).bold();
  }
  return output;
}
