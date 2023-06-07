part of '../dexa.dart';

String showFileIcon({
  bool showHeaders = false,
  required String path,
  required String file,
  required FileSystemEntityType fileType,
}) {
  String output = '';
  String? icon;
  String? color;

  switch (fileType) {
    case FileSystemEntityType.directory:
      icon = defaultIcons['dir'];

      if (file.startsWith('.')) {
        icon = defaultIcons['hiddendir'];
      }

      if (file == '.git') {
        icon = iconSet['git']?['icon'];
        color = iconSet['git']?['color'];
      }

      break;
    case FileSystemEntityType.link:
      icon = defaultIcons['symlink_file'];
      break;
    default:
      final String mimeType =
          lookupMimeType(path + file)?.split('/')[1] ?? file.split('.').last;

      final Map<String, String>? data = iconSet[mimeType];

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
