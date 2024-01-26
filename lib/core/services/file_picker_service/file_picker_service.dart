import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:saving/core/services/file_picker_service/app_file_result.dart';

/// [AppFilePicker] is extracted to another class, to make changes easier
/// like update package or replacing with another package.
/// All methods must returns [AppFileResult],
/// to be not addicted from package in other files where we use pickers

class AppFilePicker {
  /// [_pickImage] Get image from gallery and camera
  static Future<AppFileResult?> _pickImage(
    ImageSource source,
    int? imageQuality, [
    bool isFront = false,
  ]) async {
    final picker = ImagePicker();

    /// CameraDevice.front have some issue, https://github.com/flutter/flutter/issues/55644
    final image = await picker.pickImage(
      source: source,
      preferredCameraDevice: isFront ? CameraDevice.front : CameraDevice.rear,
      imageQuality: imageQuality,
    );

    return image != null
        ? AppFileResult(file: File(image.path), mimeType: image.mimeType)
        : null;
  }

  /// [showPhotoGallery] Single image from gallery
  Future<AppFileResult?> showPhotoGallery({int? imageQuality}) =>
      _pickImage(ImageSource.gallery, imageQuality);

  /// [takePhoto] Take image from camera
  Future<AppFileResult?> takePhoto({bool isFront = false, int? imageQuality}) =>
      _pickImage(ImageSource.camera, imageQuality, isFront);

  /// [showVideoGallery] Single video from gallery
  Future<AppFileResult?> showVideoGallery() async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(source: ImageSource.gallery);

    return video != null
        ? AppFileResult(file: File(video.path), mimeType: video.mimeType)
        : null;
  }
}
