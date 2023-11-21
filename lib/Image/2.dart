import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

//Image Picker from gallery/camera & cropper
class MyImagePicker {
  Future<File?> pickImage({
    double x = 1,
    double y = 1,
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    XFile? file = await ImagePicker().pickImage(source: imageSource);
    if (file == null) return null;

    final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(
          ratioX: x,
          ratioY: y,
        ));

    return croppedImage == null ? null : File(croppedImage.path);
  }

  Future<File?> pickLandscapeImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    return pickImage(x: 16, y: 9, imageSource: imageSource);
  }

  Future<File?> cameraImage({
    double x = 1,
    double y = 1,
    ImageSource imageSource = ImageSource.camera,
  }) async {
    XFile? file = await ImagePicker().pickImage(source: imageSource);
    if (file == null) return null;

    final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(
          ratioX: x,
          ratioY: y,
        ));

    return croppedImage == null ? null : File(croppedImage.path);
  }
}

class CameraImage {
  Future<File?> pickImage({
    double x = 1,
    double y = 1,
    ImageSource imageSource = ImageSource.camera,
  }) async {
    XFile? file = await ImagePicker().pickImage(source: imageSource);
    if (file == null) return null;

    final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(
          ratioX: x,
          ratioY: y,
        ));

    return croppedImage == null ? null : File(croppedImage.path);
  }
}
