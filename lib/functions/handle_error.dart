import 'dart:io';

void handleError(error) async {
  stderr.writeln(error.toString() + "\n");
  exitCode = 2;
  exit(exitCode);
}
