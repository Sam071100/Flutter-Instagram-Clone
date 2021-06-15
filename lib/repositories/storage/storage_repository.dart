import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({
    FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  //this method is uploading the image to the Firebae storage and giving us back the Download url string
  Future<String> _uploadImage({
    @required File image,
    @required String ref,
  }) async {
    final downloadUrl = await _firebaseStorage
        .ref(ref)
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    return downloadUrl;
  }

  @override
  Future<String> uploadProfileImage({String url, File image}) async {
    var imageId = Uuid().v4();

    // Update the user Profile image by overwritting the previous profile image
    if (url.isNotEmpty) {
      final exp = RegExp(r'userProfile_(.*).jpg');
      imageId = exp.firstMatch(url)[1];
    }

    final downloadUrl = await _uploadImage(
      image: image,
      ref: 'image/users/userProfile_$imageId.jpg',
    );
    return downloadUrl;
  }

  @override
  Future<String> uploadPostImage({File image}) async {
    final imageId = Uuid().v4();
    final downloadUrl = await _uploadImage(
      image: image,
      ref: 'image/posts/post_$imageId.jpg',
    );
    return downloadUrl;
  }
}
