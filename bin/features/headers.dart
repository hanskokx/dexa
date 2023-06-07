part of '../dexa.dart';

void writeHeaders({
  bool showFileTypeIcon = false,
  required int fileSizeDigits,
}) {
  final String padding = stdout.supportsAnsiEscapes ? " " : "";

  stdout.write("Permissions".underline());
  stdout.write(padding);
  stdout.write("Size".underline());
  stdout.write(padding * fileSizeDigits);
  // header += "User".underline() + " ";
  stdout.write("Date Modified".underline());
  stdout.write(padding * 4);
  if (showFileTypeIcon) {
    stdout.write("Icon".underline());
    stdout.write(padding);
  }

  stdout.write("Name".underline());
  stdout.write(padding);

  stdout.write(ansiResets[AnsiResets.all]!);
  stdout.write("\n");
}
