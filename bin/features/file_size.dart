part of '../dexa.dart';

String fileSize(
  FileStat fileStat, {
  required int fileSizeDigits,
  required Map<String, bool> args,
}) {
  late String output;
  if (args['humanReadableFileSize']!) {
    output = fileSizeHumanReadable(fileStat);
  } else {
    final String nhrfs = nonHumanReadableFileSize(fileStat);
    int digitsToSubtract = 0;
    digitsToSubtract = nhrfs.split(RegExp(r'\d')).length - 7;
    if (nhrfs[0] == '-') {
      digitsToSubtract = 1;
    }
    output = " " * (fileSizeDigits - digitsToSubtract);
    output += ' $nhrfs';
  }
  return output;
}

String fileSizeHumanReadable(FileStat fileStat) {
  final String fileSizeString = _fileSizeString(fileStat.size);

  if (fileStat.size == 0 || fileStat.type == FileSystemEntityType.directory) {
    return "${"-".dim()} ";
  }

  num size = fileStat.size;
  final int nextIndex =
      fileSizes.entries.firstWhere((element) => element.key > size).key;
  final int sizeDivisor =
      fileSizes.entries.where((element) => element.key < nextIndex).last.key;

  size = (size / sizeDivisor).round();

  String output = "$size$fileSizeString ";

  if (stdout.supportsAnsiEscapes) {
    output = output.color(AnsiColors.green).bold();
  }
  return output;
}

String nonHumanReadableFileSize(FileStat fileStat) {
  if (fileStat.size == 0) {
    return "-${" ".dim()}";
  }

  String output = "${fileStat.size} ";

  if (stdout.supportsAnsiEscapes) {
    output = output.color(AnsiColors.green).bold();
  }
  return output;
}

String _fileSizeString(int size) {
  final String fileSizeString = fileSizes.entries
      .firstWhere((element) => element.key >= size)
      .value
      .toString();

  if (fileSizeString == '') return "";
  return fileSizeString[0];
}
