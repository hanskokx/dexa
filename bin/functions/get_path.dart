import 'dart:io';

Future<Directory> getPath(argResults) async {
  List<String?> path = argResults.rest;
  if (path.isEmpty) return Directory.current;

  return Directory.fromUri(Uri.directory(path.first!));
}
