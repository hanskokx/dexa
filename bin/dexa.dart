import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

part 'constants/ansi.dart';
part 'constants/file_sizes.dart';
part 'constants/filetype_icons.dart';
part 'features/file_icon.dart';
part 'features/file_name.dart';
part 'features/file_owner.dart';
part 'features/file_size.dart';
part 'features/file_type.dart';
part 'features/headers.dart';
part 'features/modification_date.dart';
part 'features/permissions.dart';
part 'functions/gather_file_sizes.dart';
part 'functions/get_mime_type.dart';
part 'functions/get_path.dart';
part 'functions/handle_error.dart';
part 'functions/list_directory_contents.dart';

void main(List<String> arguments) async {
  exitCode = 0; // presume success
  final parser = ArgParser();
  late Directory directory;

  // Set parser flags
  parser.addFlag("all", negatable: false, abbr: 'a');
  parser.addFlag("human-readable", negatable: false, abbr: 'h');
  parser.addFlag("long", negatable: false, abbr: 'l');
  parser.addFlag("headers", negatable: false, abbr: 'H');
  // parser.addFlag("recursive", negatable: false, abbr: 'R');
  parser.addFlag("icons", negatable: false, abbr: 'I');

  final ArgResults argResults = parser.parse(arguments);

  // Read parser flags
  final Map<String, bool> args = {
    'longFileListing': (argResults["long"] == true) ? true : false,
    'humanReadableFileSize':
        (argResults["human-readable"] == true) ? true : false,
    'showHeaders': (argResults["headers"] == true) ? true : false,
    // 'listRecursively': (argResults["recursive"] == true) ? true : false,
    'showFileTypeIcon': (argResults["icons"] == true) ? true : false,
    'listAllFiles': (argResults["all"] == true)
        ? true
        : false, // https://github.com/dart-lang/sdk/issues/40303
  };

  // List all files and directories in the given path, then sort with dirctories on top
  directory = await getPath(argResults);
  final List<FileSystemEntity> fileList = [];
  final List<FileSystemEntity> files =
      await listDirectoryContents(directory, type: FileSystemEntityType.file);
  final List<FileSystemEntity> directories = await listDirectoryContents(
    directory,
    type: FileSystemEntityType.directory,
  );

  fileList.addAll(directories);
  fileList.addAll(files);

  // * Main logic starts here
  late int? maxFileSizeLengthInDigits;
  if (args['showHeaders']! && args['longFileListing']!) {
    maxFileSizeLengthInDigits = await gatherDigitsOfMaxFileSize(fileList);
    displayHeaders(args: args, fileSizeDigits: maxFileSizeLengthInDigits);
  }

  for (final FileSystemEntity element in fileList) {
    String output = '';

    final String currentFile =
        element.uri.toFilePath(windows: Platform.isWindows);

    try {
      final FileStat fileStat = await FileStat.stat(currentFile);

      if (args['longFileListing']!) {
        if (args['showHeaders']!) {
          output += fileType(fileStat);
          output += filePermissions(fileStat);

          output += fileSize(
            fileStat,
            fileSizeDigits: maxFileSizeLengthInDigits ?? 0,
            args: args,
          );

          output += fileOwner(fileStat);
          output += fileModificationDate(fileStat);
        }
      }

      if (args['showFileTypeIcon']!) {
        final String fileToProcess = directory.path + currentFile;
        final FileSystemEntityType type = fileStat.type;
        output +=
            showFileIcon(fileToProcess, type, headers: args['showHeaders']!);
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
      await handleError(currentFile);
    }
  }
}
