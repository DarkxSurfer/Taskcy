import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final ImagePicker picker = ImagePicker();
  Reference storageRef = FirebaseStorage.instance.ref();
  getImageFromGallery() async {
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print("this is an image file $image");
    if (image != null) {
      print("this is image path ${image.path}");
      print("this is image name ${image.name}");
      // saveimagetoFirebase(imageFile);
      // saveimage(image);
      return File(image.path);
    } else {
      return null;
    }
  }

  saveimage(XFile file) async {
    storageRef.child('image/some-image${DateTime.now()}.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    storageRef.putData(await file.readAsBytes(), metadata);
    var imageurl = await storageRef.getDownloadURL();
    print("imageurl --$imageurl");
  }

  saveimagetoFirebase(uploadingFile) async {
    try {
      final mountainImagesRef = storageRef.child("abc.jpg");
      await mountainImagesRef.putFile(uploadingFile);
    } catch (e) {
      print("this is an error $e");
    }
  }

  getimagefromFirebase() async {
    try {
      final imageUrl = await storageRef
          .child("flutter-tests/some-image.jpg")
          .getDownloadURL();
      print("image from firebase $imageUrl");
    } catch (e) {
      print("thsi is an erroe $e");
    }
  }
}
