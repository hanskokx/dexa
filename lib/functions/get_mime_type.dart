import 'package:mime/mime.dart';

String? getMimeType(String file) {
  late String? mimeType;
  mimeType = lookupMimeType(file);

  return mimeType;
}
