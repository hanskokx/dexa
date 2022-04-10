part of '../dexa.dart';

String fileName(FileSystemEntity element, FileStat fileStat, String path) {
  String output = basename(path);
  AnsiColors color = AnsiColors.green;

  if (stdout.supportsAnsiEscapes) {
    if (fileStat.type == FileSystemEntityType.directory) {
      color = AnsiColors.blue;
    }

    if (fileStat.type == FileSystemEntityType.link) {
      color = AnsiColors.blue;
      output = output.color(AnsiColors.blue);
      output += " -> ";
      output += element.absolute.path;
    }

    output = output.color(color).bold();
  }
  return output;
}
