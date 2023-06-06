part of '../dexa.dart';

Future<Directory> getPath(argResults) async {
  final List<String?> path = argResults.rest as List<String?>;
  if (path.isEmpty) return Directory.current;

  return Directory.fromUri(Uri.directory(path.first!));
}
