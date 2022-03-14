import 'dart:io';

import 'package:args/args.dart';

import 'features/file_icon.dart';
import 'features/file_name.dart';
import 'features/file_owner.dart';
import 'features/file_size.dart';
import 'features/file_type.dart';
import 'features/headers.dart';
import 'features/modification_date.dart';
import 'features/permissions.dart';
import 'functions/gather_file_sizes.dart';
import 'functions/get_path.dart';
import 'functions/handle_error.dart';
import 'functions/list_directory_contents.dart';

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
  parser.addFlag("icons", negatable: false, abbr: 'I');

  ArgResults argResults = parser.parse(arguments);

  // Read parser flags
  Map<String, bool> args = {
    'longFileListing': (argResults["long"] == true) ? true : false,
    'humanReadableFileSize':
        (argResults["human-readable"] == true) ? true : false,
    'showHeaders': (argResults["headers"] == true) ? true : false,
    'listRecursively': (argResults["recursive"] == true) ? true : false,
    'showFileTypeIcon': (argResults["icons"] == true) ? true : false,
    'listAllFiles': (argResults["all"] == true)
        ? true
        : false, // https://github.com/dart-lang/sdk/issues/40303
  };

  // List all files and directories in the given path, then sort with dirctories on top
  directory = await getPath(argResults);
  List<FileSystemEntity> fileList = [];
  List<FileSystemEntity> files =
      await listDirectoryContents(directory, type: FileSystemEntityType.file);
  List<FileSystemEntity> directories = await listDirectoryContents(
    directory,
    type: FileSystemEntityType.directory,
  );

  fileList.addAll(directories);
  fileList.addAll(files);

  // ! Main logic starts here
  late int? maxFileSizeLengthInDigits;
  if (args['showHeaders']! && args['longFileListing']!) {
    maxFileSizeLengthInDigits = await gatherDigitsOfMaxFileSize(fileList);
    displayHeaders(args: args, fileSizeDigits: maxFileSizeLengthInDigits);
  }

  for (FileSystemEntity element in fileList) {
    String output = '';

    String currentFile = element.uri.toFilePath(windows: Platform.isWindows);

    try {
      FileStat fileStat = await FileStat.stat(currentFile);

      if (args['longFileListing']!) {
        output += fileType(fileStat);
        output += filePermissions(fileStat);

        // TODO: This should be a `padFileSize` function which can handle both
        output += fileSize(fileStat,
            fileSizeDigits: maxFileSizeLengthInDigits ?? 0, args: args);

        output += fileOwner(fileStat);
        output += fileModificationDate(fileStat);

        if (args['showFileTypeIcon']!) {
          String fileToProcess = directory.path + currentFile;
          FileSystemEntityType type = fileStat.type;
          output +=
              showFileIcon(fileToProcess, type, headers: args['showHeaders']!);
        }
      }

      output += fileName(element, fileStat, currentFile);

      if (args['longFileListing']!) {
        output += "\n";
      } else {
        output += "  ";
      }

      stdout.write(output);
    } on FileSystemException catch (e) {
      stderr.write('$e');
      exit(2);
    } catch (_) {
      handleError(currentFile);
    }
  }
}