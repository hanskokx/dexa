part of '../dexa.dart';

const List<String> wellKnownFileExtensions = [
  "x-msdownload",
];

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
      if (file.replaceFirst(path, '').startsWith('.')) {
        icon = defaultIcons['hiddenfile'];
        break;
      }

      // String? mimeType = lookupMimeType(path + file)?.split('/')[1];
      // if (mimeType == 'plain' ||
      // mimeType == null ||
      // wellKnownFileExtensions.contains(mimeType)) {
      final String mimeType = file.split('.').last.toLowerCase();
      // }

      final Map<String, String>? data = iconSet[mimeType];

      if (data != null) {
        icon = data['icon'];
        color = data['color'];
      }

      if (file.startsWith('.')) {
        icon = defaultIcons['hiddenfile'];
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
