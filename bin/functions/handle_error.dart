part of '../dexa.dart';

void handleError(error) async {
  stderr.writeln(error.toString() + "\n");
  exitCode = 2;
  exit(exitCode);
}
