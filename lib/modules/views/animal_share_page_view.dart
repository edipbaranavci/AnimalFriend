import 'dart:io';
import 'package:flutter/material.dart';
import 'package:friend_animals/modules/models/post_model.dart';
import 'package:friend_animals/modules/services/service.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/constants.dart';
import '../../pages/animal_share_page.dart';

abstract class AnimalSharePageView extends State<AnimalSharePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  File? selectedImage;

  String selectedCity = 'İstanbul';
  bool isLoading = false;
  bool isShare = false;
  final int _imageQuality = 50;
  String? imageName;
  String? imagePath;

  final _service = Service();

  void changeCity(String? newValue) {
    setState(() {
      selectedCity = newValue!;
    });
  }

  void _loagingChange() {
    setState(() {
      isLoading = !isLoading;
      isShare = !isShare;
    });
  }

  Future<void> getImage(ImageSource imageSource) async {
    XFile? getImage = await ImagePicker().pickImage(
      imageQuality: _imageQuality,
      source: imageSource,
    );
    if (getImage != null) {
      _loagingChange();
      setState(() {
        selectedImage = File(getImage.path);
        imageName = getImage.name;
        imagePath = getImage.path;
      });
      _loagingChange();
    } else {
      _noImageSelect();
    }
  }

  void _noImageSelect() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AnimalSharePageStrings.noFileSelectedTitle),
      ),
    );
  }

  Future<void> sharePost() async {
    _loagingChange();
    if (selectedImage != null && imageName != null) {
      String imageUrl = await _service.fileUpload(imagePath!, imageName!);
      final PostModel postModel = PostModel(
        postImage: imageUrl,
        postAbout: aboutController.text,
        postDate: DateTime.now().toString(),
        postFavoriteCount: 0,
        postLocation: selectedCity,
        postShowCount: 0,
        postTitle: titleController.text,
        userMail: widget.userMail,
      );
      _service.postUpload(postModel: postModel);
    }
    _loagingChange();
  }
}
