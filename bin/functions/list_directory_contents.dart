part of '../dexa.dart';

Future<List<FileSystemEntity>> listDirectoryContents(
  Directory dir, {
  required FileSystemEntityType type,
}) {
  final List<FileSystemEntity> files = <FileSystemEntity>[];
  final Completer<List<FileSystemEntity>> completer =
      Completer<List<FileSystemEntity>>();
  final Stream<FileSystemEntity> lister = dir.list(recursive: false);

  lister.listen(
    (file) async {
      final FileStat currentFileStat = await FileStat.stat(file.path);
      if (currentFileStat.type == type) {
        files.add(file);
      }
    },
    onError: (e) => handleError(e),
    onDone: () => completer.complete(files),
  );
  return completer.future;
}
