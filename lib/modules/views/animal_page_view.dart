import 'package:flutter/material.dart';
import 'package:friend_animals/pages/animal_page.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../services/service.dart';

abstract class AnimalPageView extends State<AnimalPage> {
  @override
  void initState() {
    super.initState();
    getServices();
  }

  bool isLoading = true;
  bool isUserPosts = false;
  UserModel? userModel;
  PostModel? postModel;
  bool favorite = false;

  final _service = Service();
  final viewUserModel = Service().userLoginControl();

  Future<void> getServices() async {
    if (userModel == null) {
      postModel = await _service.getPostDetails(widget.postId);
      userModel = await _service.getUserDetails(postModel?.userMail ?? 'd');
      final userMail = viewUserModel!.email ?? 'sadasd';
      favorite = await _service.getPostFavorite(userMail, widget.postId);

      if (userModel != null && postModel != null) {
        setState(() {
          if (userModel!.email! == viewUserModel!.email) {
            isUserPosts = true;
          }
          isLoading = false;
        });
      }
    }
  }

  void deletePost() {
    _service.deletePost(widget.postId);
    Navigator.pop(context);
  }

  String dateFormatter(String date) {
    if (date != '') {
      DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
      return DateFormat.yMMMEd('tr_TR').format(tempDate);
    } else {
      return '';
    }
  }

  Future<void> getPostDetails() async {
    var model = await _service.getPostDetails(widget.postId);
    if (model != null) {
      postModel = model;
    }
  }

  void changeFavorite() {
    setState(() {
      favorite = !favorite;
    });

    _service.setPostFavorite(viewUserModel!.email!, widget.postId, favorite);
  }

  final String noImageUrl =
      'https://uxwing.com/wp-content/themes/uxwing/download/12-peoples-avatars/no-profile-picture.png';
}
