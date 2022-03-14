import 'dart:io';
import 'dart:math';

Future<int> gatherFileSizes(List<FileSystemEntity> files) async {
  List<int> fileSizes = [0];
  for (FileSystemEntity entity in files) {
    String file = entity.uri.toFilePath(windows: Platform.isWindows);
    FileStat fileStat = await FileStat.stat(file);
    int size = fileStat.size;
    fileSizes.add(size);
  }
  int maxFileSize = fileSizes.reduce(max);
  return maxFileSize;
}
