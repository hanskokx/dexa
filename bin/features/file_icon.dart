import 'dart:io';

import '../constants/ansi.dart';
import '../constants/filetype_icons.dart';
import '../functions/get_mime_type.dart';

String showFileIcon(String file, FileSystemEntityType type) {
  String output = '';
  String? mimeType;
  String? icon;
  String? color;

  switch (type) {
    case FileSystemEntityType.directory:
      icon = defaultIcons['dir'];
      break;
    case FileSystemEntityType.link:
      // TODO: Handle this case.
      break;
    default:
      mimeType = getMimeType(file);
      if (mimeType != null) {
        // We have a mime type, so let's check if it's in the list of known file types.
        mimeType = mimeType.split('/')[1];
        Map? data = iconSet[mimeType];

        // The file type has been found in the list of known file types.
        if (data != null) {
          icon = data['icon'];
          color = data['color'];
        }
      }
      break;
  }
  icon ??= defaultIcons['file'];
  color ??= ansiForegroundColors[AnsiColors.white];

  if (stdout.supportsAnsiEscapes) {
    output += color!;
  }

  output += icon!;
  if (stdout.supportsAnsiEscapes) {
    output += ansiResets[AnsiResets.all]!;
  }
  output += ' ';
  return output.padRight(2);
}
