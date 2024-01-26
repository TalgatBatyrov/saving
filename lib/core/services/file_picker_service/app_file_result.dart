import 'dart:io';

//[AppFileResult] pick file with extension or mimeType
class AppFileResult {
  AppFileResult({required this.file, this.extension, this.mimeType});
  final File file;

  final String? extension;

  final String? mimeType;

  bool get isPdf => extension != null && extension == 'pdf';
}
