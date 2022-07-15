import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friend_animals/modules/cache/cache_manager.dart';
import 'package:friend_animals/modules/models/user_model.dart';
import 'package:friend_animals/modules/services/fire_store_service.dart';
import '../models/image_upload_model.dart';
import '../models/post_model.dart';
import 'google_sign_in_service.dart';
import 'image_upload_service.dart';

class Service {
  final _fireStoreService = FireStoreService();
  final _googleSignInService = GoogleSignInService();
  final _cacheManager = CacheManager();
  final _imageUploadService = ImageUploadService();

  Future<UserModel?> userLogin() async {
    final userModel = await _googleSignInService.signInWithGoogle();
    if (userModel != null) {
      _fireStoreService.userRegister(userModel);
      _cacheManager.putUser(userModel);
      final getUser = _cacheManager.getUser();
      if (getUser != null) {
        return getUser;
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await _googleSignInService.sigOutGoogle();
    _cacheManager.clear();
  }

  Future<UserModel?> getUserDetails(String userMail) async {
    return await _fireStoreService.getUserDetails(userMail);
  }

  UserModel? userLoginControl() => _cacheManager.getUser();

  Future<bool> getPostFavorite(String userMail, String post) async {
    return await _fireStoreService.getPostFavorite(userMail, post);
  }

  void setPostFavorite(String email, String postId, bool favoriteBool) {
    _fireStoreService.setPostFavorite(email, postId, favoriteBool);
  }

  void deletePost(String postId) {
    _fireStoreService.deletePost(postId);
  }

  Future<List<String>> getFavoritesPostIds(String userMail) async {
    return await _fireStoreService.getFavoritePostIds(userMail);
  }

  Future<List<String>> getMyPostIds(String userMail) async {
    return await _fireStoreService.getMyPostIds(userMail);
  }

  PostModel getPostModel(List<QueryDocumentSnapshot<Object?>> doc, int index) {
    return _fireStoreService.getPostModel(doc, index);
  }

  void setFavoriteValue(int count, String postId) {
    _fireStoreService.setFavoriteValue(count, postId);
  }

  Future<int> getFavoriteValue(String postId) async {
    return await _fireStoreService.getFavoriteValue(postId);
  }

  void postUpload({required PostModel postModel}) {
    _fireStoreService.setPostUpload(postModel: postModel);
  }

  Future<PostModel?> getPostDetails(String postId) async {
    return await _fireStoreService.getPostDetails(postId);
  }

  Future<String> fileUpload(String path, String name) async {
    return await _imageUploadService.setFile(path, name);
  }

  void imageNameUpload(ImageUploadModel imageUploadModel) {
    _fireStoreService.setImageNameUpload(imageUploadModel);
  }
}
