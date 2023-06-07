part of '../dexa.dart';

String showFileIcon(
  String file,
  FileSystemEntityType type, {
  bool showHeaders = false,
}) {
  String output = '';
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
      final String mimeType =
          lookupMimeType(file)?.split('/')[1] ?? file.split('.').last;

      final Map<String, String>? data = iconSet[mimeType];

      // The file type has been found in the list of known file types.
      if (data != null) {
        icon = data['icon'];
        color = data['color'];
      }
      break;
  }
  icon ??= defaultIcons['file'];
  color ??= ansiForegroundColors[AnsiColors.white];

  if (stdout.supportsAnsiEscapes) {
    output += color!;
  }
  if (showHeaders) {
    output += icon!.padRight(5);
  } else {
    output += '$icon ';
  }

  if (stdout.supportsAnsiEscapes) {
    output += ansiResets[AnsiResets.all]!;
  }
  return output;
}
