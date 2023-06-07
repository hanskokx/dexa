import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'functions/argument_parser.dart';

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
part 'functions/handle_error.dart';
part 'functions/list_directory_contents.dart';

void main(List<String> arguments) async {
  exitCode = 0; // presume success
  final ArgParser parser = ArgParser();

  final (Directory directory, UserArguments args) = parseArguments(
    parser,
    arguments: arguments,
  );

  // List all files and directories in the given path, then sort with dirctories on top
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
  final int maxFileSizeLengthInDigits = await gatherDigitsOfMaxFileSize(
    fileList,
    isHumanReadable: args.humanReadableFileSize,
  );

  if (args.showHeaders && args.longFileListing) {
    writeHeaders(
      showFileTypeIcon: args.showFileTypeIcon,
      fileSizeDigits: maxFileSizeLengthInDigits,
    );
  }

  for (final FileSystemEntity element in fileList) {
    final String currentFile =
        element.uri.toFilePath(windows: Platform.isWindows);

    try {
      final FileStat fileStat = await FileStat.stat(currentFile);

      if (args.longFileListing && args.showHeaders) {
        stdout.write(fileType(fileStat));
        stdout.write(filePermissions(fileStat));

        stdout.write(
          fileSize(
            fileStat,
            fileSizeDigits: maxFileSizeLengthInDigits,
            humanReadableFileSize: args.humanReadableFileSize,
          ),
        );

        stdout.write(fileOwner(fileStat));
        stdout.write(fileModificationDate(fileStat));
      }

      if (args.showFileTypeIcon) {
        stdout.write(
          showFileIcon(
            path: directory.path,
            file: currentFile,
            fileType: fileStat.type,
            showHeaders: args.showHeaders,
          ),
        );
      }

      stdout.write(fileName(element, fileStat, currentFile));

      stdout.write(args.longFileListing ? "\n" : "  ");
    } on FileSystemException catch (e) {
      stderr.write('$e');
      exit(2);
    } catch (_) {
      await handleError(currentFile);
    }
  }
}
