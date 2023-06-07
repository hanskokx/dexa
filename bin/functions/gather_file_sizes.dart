part of '../dexa.dart';

Future<int> gatherDigitsOfMaxFileSize(
  List<FileSystemEntity> files,
) async {
  final List<int> fileSizes = [0];
  for (final FileSystemEntity entity in files) {
    final String file = entity.uri.toFilePath(windows: Platform.isWindows);
    final FileStat fileStat = await FileStat.stat(file);
    final int size = fileStat.size;
    fileSizes.add(size);
  }
  final int maxFileSize = fileSizes.reduce(max);
  final int digits = maxFileSize.toString().length;
  print(digits);
  return digits;
}
