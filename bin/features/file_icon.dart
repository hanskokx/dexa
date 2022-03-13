import '../constants/filetype_icons.dart';
import '../functions/get_mime_type.dart';

String showFileIcon(String file) {
  String icon = '';
  String? mimeType = getMimeType(file);
  if (mimeType != null) {
    mimeType = mimeType.split('/')[1];
    icon += iconSet[mimeType] ?? '';
  }
  return icon.padRight(2);
}
