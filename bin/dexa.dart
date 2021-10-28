import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

void main(List<String> arguments) async {
  exitCode = 0; // presume success
  final parser = ArgParser();
  late Directory directory;

  // Set parser flags
  parser.addFlag("all", negatable: false, abbr: 'a');
  parser.addFlag("human-readable", negatable: false, abbr: 'h');
  parser.addFlag("long", negatable: false, abbr: 'l');
  parser.addFlag("headers", negatable: false, abbr: 'H');
  parser.addFlag("recursive", negatable: false, abbr: 'R');

  ArgResults argResults = parser.parse(arguments);

  // Read parser flags
  Map<String, bool> args = {
    'longFileListing': (argResults["long"] == true) ? true : false,
    'humanReadableFileSize':
        (argResults["human-readable"] == true) ? true : false,
    'showHeaders': (argResults["headers"] == true) ? true : false,
    'listRecursively': (argResults["recursive"] == true) ? true : false,
    'listAllFiles': (argResults["all"] == true)
        ? true
        : false, // https://github.com/dart-lang/sdk/issues/40303
  };

  // List all files and directories in the given path, then sort with dirctories on top
  directory = await _getPath(argResults);
  List<FileSystemEntity> fileList = [];
  List<FileSystemEntity> files =
      await _dirContents(directory, type: FileSystemEntityType.file);
  List<FileSystemEntity> directories =
      await _dirContents(directory, type: FileSystemEntityType.directory);

  fileList.addAll(directories);
  fileList.addAll(files);

  // ! Main logic starts here
  run(args, fileList);
}

const Map<int, String> _fileSizes = {
  0: " ",
  1: " ",
  1024: "",
  1048576: "kilobytes",
  1073741824: "Megabytes",
  1099511627776: "Gigabytes",
  1152921504606846976: "Terrabytes"
};

void run(Map<String, bool> args, List<FileSystemEntity> fileList) async {
  if (args['showHeaders']!) _displayHeaders();

  for (FileSystemEntity element in fileList) {
    String output = '';

    String path = element.uri.toFilePath(windows: Platform.isWindows);

    try {
      FileStat fileStat = await FileStat.stat(path);

      if (args['longFileListing']!) {
        output += _fileType(fileStat);
        output += _filePermissions(fileStat);

        (args['humanReadableFileSize']!)
            ? output += _fileSizeHumanReadable(fileStat)
            : output += _fileSize(fileStat);

        output += _fileOwner(fileStat);
        output += _fileModificationDate(fileStat);
      }

      output += _fileName(element, fileStat, path);

      if (args['longFileListing']!) {
        output += "\n";
      } else {
        output += "  ";
      }

      stdout.write(output);
    } on FileSystemException catch (_) {
      stderr.write("Oh, dangit.");
      exit(2);
    } catch (_) {
      _handleError(path);
    }

    // if (args['listRecursively']!) {
    //   List<String> newArguments = _buildNewArguments(args);
    //   for (FileSystemEntity directory in fileList) {
    //     FileStat fileTest = await FileStat.stat(directory.path);
    //     if (fileTest.type == FileSystemEntityType.directory) {
    //       List<FileSystemEntity?> directoryListTest = await _dirContents(
    //           Directory(directory.path),
    //           type: FileSystemEntityType.file);
    //       List<FileSystemEntity?> directoryListDirTest = await _dirContents(
    //           Directory(directory.path),
    //           type: FileSystemEntityType.directory);
    //       if (directoryListTest.isNotEmpty || directoryListDirTest.isNotEmpty) {
    //         String rDir = directory.path
    //             .split("\\")
    //             .lastWhere((element) => element.isNotEmpty);
    //         stdout.write("./" + rDir + ":\n");
    //         newArguments.add(directory.path);
    //         main(newArguments);
    //       }
    //     }
    //   }
    // }
  }
}

// List<String> _buildNewArguments(Map<String, bool> args) {
//   List<String> newArguments = [];
//   args.forEach((key, value) {
//     switch (key) {
//       case "listAllFiles":
//         newArguments.add('a');
//         break;
//       case "humanReadableFileSize":
//         newArguments.add('h');
//         break;
//       case "longFileListing":
//         newArguments.add('l');
//         break;
//       case "showHeaders":
//         newArguments.add('H');
//         break;
//       case "listRecursively":
//         newArguments.add('R');
//         break;
//     }
//   });
//   return newArguments;
// }

Future<List<FileSystemEntity>> _dirContents(Directory dir,
    {required FileSystemEntityType type}) {
  List<FileSystemEntity> files = <FileSystemEntity>[];
  Completer<List<FileSystemEntity>> completer =
      Completer<List<FileSystemEntity>>();
  Stream<FileSystemEntity> lister = dir.list(recursive: false);

  lister.listen(
    (file) async {
      FileStat currentFileStat = await FileStat.stat(file.path);
      if (currentFileStat.type == type) {
        files.add(file);
      }
    },
    onError: (e) => _handleError(e),
    onDone: () => completer.complete(files),
  );
  return completer.future;
}

void _displayHeaders() {
  String header = "";

  header += "Permissions".underline() + " ";
  header += "Size".underline() + " ";
  // header += "User".underline() + " ";
  header += "Date Modified".underline() + " ".padRight(4, " ");
  header += "Name".underline() + " ";

  header += "\n";
  stdout.write(header);
}

String _fileModificationDate(FileStat fileStat) {
  DateTime modified = fileStat.modified;
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  String output = formatter.format(modified).padRight(17, " ");
  if (stdout.supportsAnsiEscapes) {
    output = output.color(AnsiColors.cyan);
  }
  return output;
}

String _fileName(FileSystemEntity element, FileStat fileStat, String path) {
  String output = basename(path);
  AnsiColors color = AnsiColors.green;

  if (stdout.supportsAnsiEscapes) {
    if (fileStat.type == FileSystemEntityType.directory) {
      color = AnsiColors.blue;
    }

    if (fileStat.type == FileSystemEntityType.link) {
      color = AnsiColors.blue;
      output = output.color(AnsiColors.blue);
      output += " -> ";
      output += element.absolute.path;
    }

    output = output.color(color).bold();
  }
  return output;
}

String _fileOwner(FileStat fileStat) {
  // TODO: This isn't actually possible at this time. https://github.com/dart-lang/sdk/issues/47478
  String output = "";
  if (stdout.supportsAnsiEscapes) {
    return output.color(AnsiColors.yellow).bold();
  }
  return output;
}

String _filePermissions(FileStat fileStat) {
  String output = '';
  if (stdout.supportsAnsiEscapes) {
    List<String> permissions = fileStat.modeString().split("");

    for (String i in permissions) {
      switch (i) {
        case "r":
          output += "r".color(AnsiColors.yellow).bold();
          break;
        case "w":
          output += "w".color(AnsiColors.red).bold();
          break;
        case "x":
          output += "x".color(AnsiColors.green).bold();
          break;
        case "-":
          // output += "x".color(AnsiColors.green).underline().bold();
          output += "-".color(AnsiColors.green).bold();
          break;
      }
    }
    return output;
  }
  return fileStat.modeString();
}

String _fileSize(FileStat fileStat) {
  // String fileSizeString = _fileSizeString(size);

  if (fileStat.size == 0) {
    return "-".padLeft(6, ' ') + " ".dim();
  }

  String output =
      fileStat.size.toString().padLeft(6, ' ') + " "; // + fileSizeString + " ";

  if (stdout.supportsAnsiEscapes) {
    output = output.color(AnsiColors.green).bold();
  }
  return output;
}

String _fileSizeHumanReadable(FileStat fileStat) {
  String? fileSizeString = _fileSizeString(fileStat.size);

  if (fileStat.size == 0 || fileStat.type == FileSystemEntityType.directory) {
    return "-".padLeft(6, ' ').dim() + " ";
  }

  num size = fileStat.size;
  int nextIndex =
      _fileSizes.entries.firstWhere((element) => element.key > size).key;
  int sizeDivisor =
      _fileSizes.entries.where((element) => element.key < nextIndex).last.key;

  size = (size / sizeDivisor).round();

  String output = (size.toString() + fileSizeString).padLeft(6, ' ') + " ";

  if (stdout.supportsAnsiEscapes) {
    output = output.color(AnsiColors.green).bold();
  }
  return output;
}

String _fileSizeString(int size) {
  String? fileSizeString = _fileSizes.entries
      .firstWhere((element) => element.key >= size)
      .value
      .toString();

  if (fileSizeString == '') return "";
  return fileSizeString[0];
}

String _fileType(fileStat) {
  late String? type;
  type = fileStat.type.toString()[0];
  if (fileStat.type.toString()[0] == "f") type = ".";
  if (stdout.supportsAnsiEscapes) {
    switch (type) {
      case "d":
        type = type.color(AnsiColors.cyan).bold();
        break;
      default:
        type = type.color(AnsiColors.white).bold();
    }
  }

  return (type);
}

Future<Directory> _getPath(argResults) async {
  List<String?> path = argResults.rest;
  if (path.isEmpty) return Directory.current;

  return Directory.fromUri(Uri.directory(path.first!));
}

void _handleError(error) async {
  stderr.writeln(error.toString() + "\n");
  exitCode = 2;
  exit(exitCode);
}

enum AnsiCodes {
  bold,
  dim,
  italic,
  underline,
  blinking,
  inverse,
  invisible,
  strikethrough
}

enum AnsiColors {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  brightBlack,
  brightRed,
  brightGreen,
  brightYellow,
  brightBlue,
  brightMagenta,
  brightCyan,
  brightWhite,
}
enum AnsiResets {
  all,
  bold,
  dim,
  italic,
  underline,
  blinking,
  inverse,
  invisible,
  strikethrough
}
enum Args {
  longFileListing,
  humanReadableFileSize,
  showHeaders,
  listRecursively,
  listAllFiles
}

extension StringExtension on String {
  static const Map<AnsiCodes, String> ansiCodes = {
    AnsiCodes.bold: "\x1B[1m",
    AnsiCodes.dim: "\x1B[2m",
    AnsiCodes.italic: "\x1B[3m",
    AnsiCodes.underline: "\x1B[4m",
    AnsiCodes.blinking: "\x1B[5m",
    AnsiCodes.inverse: "\x1B[7m",
    AnsiCodes.invisible: "\x1B[8m",
    AnsiCodes.strikethrough: "\x1B[9m",
  };

  static const Map<AnsiColors, String> ansiForegroundColors = {
    AnsiColors.black: "\x1B[30m",
    AnsiColors.red: "\x1B[31m",
    AnsiColors.green: "\x1B[32m",
    AnsiColors.yellow: "\x1B[33m",
    AnsiColors.blue: "\x1B[34m",
    AnsiColors.magenta: "\x1B[35m",
    AnsiColors.cyan: "\x1B[36m",
    AnsiColors.white: "\x1B[37m",
    AnsiColors.brightBlack: "\x1B[90m",
    AnsiColors.brightRed: "\x1B[91m",
    AnsiColors.brightGreen: "\x1B[92m",
    AnsiColors.brightYellow: "\x1B[93m",
    AnsiColors.brightBlue: "\x1B[94m",
    AnsiColors.brightMagenta: "\x1B[95m",
    AnsiColors.brightCyan: "\x1B[96m",
    AnsiColors.brightWhite: "\x1B[97m",
  };

  static const Map<AnsiResets, String> ansiResets = {
    AnsiResets.all: "\x1B[0m",
    AnsiResets.bold: "\x1B[22m",
    AnsiResets.dim: "\x1B[22m",
    AnsiResets.italic: "\x1B[23m",
    AnsiResets.underline: "\x1B[24m",
    AnsiResets.blinking: "\x1B[25m",
    AnsiResets.inverse: "\x1B[27m",
    AnsiResets.invisible: "\x1B[28m",
    AnsiResets.strikethrough: "\x1B[29m",
  };

  String color(AnsiColors color) {
    return ansiForegroundColors[color]! + this + ansiResets[AnsiResets.all]!;
  }

  String bold() {
    return ansiCodes[AnsiCodes.bold]! + this + ansiResets[AnsiResets.bold]!;
  }

  String dim() {
    return ansiCodes[AnsiCodes.dim]! + this + ansiResets[AnsiResets.dim]!;
  }

  String italic() {
    return ansiCodes[AnsiCodes.italic]! + this + ansiResets[AnsiResets.italic]!;
  }

  String underline() {
    return ansiCodes[AnsiCodes.underline]! +
        this +
        ansiResets[AnsiResets.underline]!;
  }

  String blinking() {
    return ansiCodes[AnsiCodes.blinking]! +
        this +
        ansiResets[AnsiResets.blinking]!;
  }

  String inverse() {
    return ansiCodes[AnsiCodes.inverse]! +
        this +
        ansiResets[AnsiResets.inverse]!;
  }

  String invisible() {
    return ansiCodes[AnsiCodes.invisible]! +
        this +
        ansiResets[AnsiResets.invisible]!;
  }

  String strikethrough() {
    return ansiCodes[AnsiCodes.strikethrough]! +
        this +
        ansiResets[AnsiResets.strikethrough]!;
  }
}
