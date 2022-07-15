import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friend_animals/modules/models/favorite_post_model.dart';

import '../../constant/enums.dart';
import '../models/image_upload_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import 'error_writer.dart';

class FireStoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserDetails(String userMail) async {
    // Create a reference to the document the transaction will use
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(CollectionNames.user.name)
        .doc(userMail);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      } else {
        return UserModel(
          displayName: snapshot.get(UserFieldNames.displayName.name),
          email: snapshot.get(UserFieldNames.email.name),
          id: snapshot.get(UserFieldNames.id.name),
          loginDate: snapshot.get(UserFieldNames.loginDate.name),
          photoUrl: snapshot.get(UserFieldNames.photoUrl.name),
        );
      }
    }).catchError((error) => ErrorWriter.write(error, this));
  }

  void userRegister(UserModel userModel) {
    CollectionReference user = _firestore.collection(CollectionNames.user.name);
    user
        .doc(userModel.email)
        .set(userModel.toMap())
        .catchError((e) => ErrorWriter.write(e, this));
  }

  void setImageNameUpload(ImageUploadModel imageUploadModel) {
    CollectionReference image =
        _firestore.collection(CollectionNames.image.name);
    image
        .doc(imageUploadModel.imageCode)
        .set(imageUploadModel.toMap())
        // ignore: avoid_print
        .catchError((e) => ErrorWriter.write(e, this));
  }

  void setPostUpload({required PostModel postModel}) {
    CollectionReference post = _firestore.collection(CollectionNames.post.name);
    post
        .doc()
        .set(postModel.toMap())
        .catchError((e) => ErrorWriter.write(e, this));
  }

  PostModel getPostModel(List<QueryDocumentSnapshot<Object?>> doc, int index) {
    return PostModel(
      postAbout: doc[index][PostFieldNames.postAbout.name],
      postTitle: doc[index][PostFieldNames.postTitle.name],
      postLocation: doc[index][PostFieldNames.postLocation.name],
      postDate: doc[index][PostFieldNames.postDate.name],
      postFavoriteCount: doc[index][PostFieldNames.postFavoriteCount.name],
      postImage: doc[index][PostFieldNames.postImage.name],
      postShowCount: doc[index][PostFieldNames.postShowCount.name],
      userMail: doc[index][PostFieldNames.userMail.name],
    );
  }

  Future<List<String>> getMyPostIds(String userMail) async {
    List<QueryDocumentSnapshot<Object?>> myPostIds = [];
    List<String> sendList = [];
    CollectionReference posts =
        _firestore.collection(CollectionNames.post.name);

    var response = posts.get();
    await response.then((value) {
      myPostIds = value.docs;
      for (var element in myPostIds) {
        if (element.get(PostFieldNames.userMail.name) == userMail) {
          sendList.add(element.id);
        }
      }
      return sendList;
    });

    return sendList;
  }

  void deletePost(String postId) {
    DocumentReference post =
        _firestore.collection(CollectionNames.post.name).doc(postId);
    post.delete();
  }

  Future<PostModel?> getPostDetails(String postId) async {
    // Create a reference to the document the transaction will use
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(CollectionNames.post.name)
        .doc(postId);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      } else {
        return PostModel(
          postAbout: snapshot.get(PostFieldNames.postAbout.name),
          postDate: snapshot.get(PostFieldNames.postDate.name),
          postFavoriteCount:
              snapshot.get(PostFieldNames.postFavoriteCount.name),
          postImage: snapshot.get(PostFieldNames.postImage.name),
          postLocation: snapshot.get(PostFieldNames.postLocation.name),
          postShowCount: snapshot.get(PostFieldNames.postShowCount.name),
          postTitle: snapshot.get(PostFieldNames.postTitle.name),
          userMail: snapshot.get(PostFieldNames.userMail.name),
        );
      }
    }).catchError((error) => ErrorWriter.write(error, this));
  }

  Future<bool> getPostFavorite(String userMail, String postId) async {
    DocumentReference documentReference = _firestore
        .collection(CollectionNames.favoriteUser.name)
        .doc(FavoriteUserCollectionNames.users.name)
        .collection(userMail)
        .doc(postId);
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (snapshot.exists) {
        return snapshot.get(FavoriteFieldNames.favoriteBool.name) ?? false;
      } else {
        return false;
      }
    });
  }

  Future<List<String>> getFavoritePostIds(String userMail) async {
    List<QueryDocumentSnapshot<Object?>> favoritesPostIds = [];
    List<String> sendList = [];
    CollectionReference favorites = _firestore
        .collection(CollectionNames.favoriteUser.name)
        .doc(FavoriteUserCollectionNames.users.name)
        .collection(userMail);

    var response = favorites.get();
    await response.then((value) {
      favoritesPostIds = value.docs;
      for (var element in favoritesPostIds) {
        if (element.get(FavoriteFieldNames.favoriteBool.name) == true) {
          sendList.add(element.id);
        }
      }
      return sendList;
    });

    return sendList;
  }

  Future<void> setFavoriteValue(int count, String postId) async {
    final postFavoriteValue =
        _firestore.collection(CollectionNames.post.name).doc(postId);

    if (count < 1) {
      count = 0;
    }

    postFavoriteValue.update({
      PostFieldNames.postFavoriteCount.name: count,
    });
  }

  Future<int> getFavoriteValue(String postId) {
    // Create a reference to the document the transaction will use
    DocumentReference documentReference =
        _firestore.collection(CollectionNames.post.name).doc(postId);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      int? favoriteCount = snapshot.get(PostFieldNames.postFavoriteCount.name);
      exit;
      return favoriteCount ?? 0;
    }).catchError((error) => ErrorWriter.write(error, this));
  }

  void setPostFavorite(String email, String postId, bool favoriteBool) {
    CollectionReference favoritePostCol = _firestore
        .collection(CollectionNames.favoritePost.name)
        .doc(FavoritePostCollectionNames.posts.name)
        .collection(postId);

    CollectionReference favoriteUserCol = _firestore
        .collection(CollectionNames.favoriteUser.name)
        .doc(FavoriteUserCollectionNames.users.name)
        .collection(email);

    final favoritePostModel = FavoritePostModel(
      postId: postId,
      userMail: email,
      favoriteBool: favoriteBool,
      favoriteDate: DateTime.now().toString(),
    );

    favoritePostCol
        .doc(email)
        .set(favoritePostModel.toMap())
        .catchError((e) => ErrorWriter.write(e, this));

    favoriteUserCol
        .doc(postId)
        .set(favoritePostModel.toMap())
        .catchError((e) => ErrorWriter.write(e, this));

    if (favoriteBool == true) {
      favoritePostCol
          .doc(email)
          .set(favoritePostModel.toMap())
          .catchError((e) => ErrorWriter.write(e, this));
      favoriteUserCol
          .doc(postId)
          .set(favoritePostModel.toMap())
          .catchError((e) => ErrorWriter.write(e, this));
    } else {
      DocumentReference favoritePostDoc = favoritePostCol.doc(email);
      DocumentReference favoriteUserDoc = favoriteUserCol.doc(postId);
      favoriteUserDoc.delete();
      favoritePostDoc.delete();
    }
  }
}
