part of '../dexa.dart';

Future<int> gatherDigitsOfMaxFileSize(
  List<FileSystemEntity> files, {
  bool isHumanReadable = false,
}) async {
  final List<int> fileSizes = [0];

  for (final FileSystemEntity entity in files) {
    final String file = entity.uri.toFilePath(windows: Platform.isWindows);
    final FileStat fileStat = await FileStat.stat(file);

    int size = 0;
    size = fileStat.size;

    if (isHumanReadable) {
      final String fileSize = fileSizeHumanReadable(fileStat);
      size = fileSize.length - 1;
      if (stdout.supportsAnsiEscapes) size -= 17;
      if (fileSize == '-') size = 1;
    }
    fileSizes.add(size);
  }
  final int maxFileSize = fileSizes.reduce(max);
  final int digits = maxFileSize.toString().length;

  if (isHumanReadable) return maxFileSize;
  return digits;
}
