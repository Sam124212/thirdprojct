import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

//Service to Upload files/images to Firebase

class UploaderService {
  final Reference storageRef = FirebaseStorage.instance.ref("ProfileImages");
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// [dir] is the directory on firebase storage bucket
  Future<UploadedFile> uploadFile(File file, String dir,
      {Function(double)? onProgress}) async {
    UploadTask uploadTask;

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String extension = p.extension(file.path);

    Reference ref = storageRef
        .child("Files")
        .child(dir)
        .child(auth.currentUser?.uid ?? 'anonymous')
        .child('/$fileName.$extension');

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes());
    } else {
      uploadTask = ref.putFile(File(file.path));
    }

    final subscription = uploadTask.snapshotEvents.listen((event) {
      final progress =
          event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      if (onProgress != null) onProgress(progress);
    });

    final TaskSnapshot downloadUrl = (await uploadTask);

    final String url = await downloadUrl.ref.getDownloadURL();

    subscription.cancel();

    return UploadedFile(
      downloadLink: url,
    );
  }
}

class UploadedFile {
  final String downloadLink;
  // final FileType fileType;

  UploadedFile({
    required this.downloadLink,
  });
}

// enum FileType { Thumbnail, Image, Video, Audio }
