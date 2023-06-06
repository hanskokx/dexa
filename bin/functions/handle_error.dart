part of '../dexa.dart';

Future<void> handleError(error) async {
  stderr.writeln("$error\n");
  exitCode = 2;
  exit(exitCode);
}
