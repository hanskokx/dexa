import '../constants/ansi.dart';
import '../constants/filetype_icons.dart';
import '../functions/get_mime_type.dart';

String showFileIcon(String file) {
  String output = '';
  String? mimeType = getMimeType(file);
  if (mimeType != null) {
    // We have a mime type, so let's check if it's in the list of known file types.
    mimeType = mimeType.split('/')[1];
    Map? data = iconSet[mimeType];

    // The file type has been found in the list of known file types.
    if (data != null) {
      output += data['color'];
      output += data['icon'];
      output += ansiResets[AnsiResets.all]!;
      output += ' ';
    }
  }
  return output.padRight(2);
}
