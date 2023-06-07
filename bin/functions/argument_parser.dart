import 'dart:io';

import 'package:args/args.dart';

/// Parses arguments passed into the program.
(Directory, UserArguments) parseArguments(
  ArgParser parser, {
  List<String>? arguments,
}) {
  Argument.values.map(
    (e) => parser.addFlag(e.name, negatable: false, abbr: e.abbr),
  );

  final List<String> args = [if (arguments != null) ...arguments];

  final ArgResults argResults = parser.parse(args);

  final UserArguments parsedArguments = UserArguments(
    longFileListing: (argResults["long"] == true) ? true : false,
    humanReadableFileSize:
        (argResults["human-readable"] == true) ? true : false,
    showHeaders: (argResults["headers"] == true) ? true : false,
    showFileTypeIcon: (argResults["icons"] == true) ? true : false,
    listAllFiles: (argResults["all"] == true)
        ? true
        : false, // https://github.com/dart-lang/sdk/issues/40303
  );

  final Directory directory = Directory.fromUri(
    Uri.directory(argResults.rest.first),
  );

  return (directory, parsedArguments);
}

enum Argument {
  all("all", "a"),
  humanReadable("human-readable", "h"),
  long("long", "l"),
  headers("headers", "H"),
  icons("icons", "I");

  final String name;
  final String abbr;

  const Argument(this.name, this.abbr);
}

class UserArguments {
  final bool longFileListing;
  final bool humanReadableFileSize;
  final bool showHeaders;
  final bool showFileTypeIcon;
  final bool listAllFiles;

  const UserArguments({
    this.longFileListing = false,
    this.humanReadableFileSize = false,
    this.showHeaders = false,
    this.showFileTypeIcon = false,
    this.listAllFiles = false,
  });
}
