import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constant/enums.dart';
import '../../pages/favorites_page.dart';
import '../services/service.dart';

abstract class FavoritesPageView extends State<FavoritesPage> {
  final _service = Service();
  final viewUserModel = Service().userLoginControl();
  final String pageTitle = 'Favorilerim';
  bool isLoading = true;
  List<String> favoritesPostIds = [];
  Future<void> getPostIds() async {
    favoritesPostIds =
        await _service.getFavoritesPostIds(viewUserModel!.email ?? 'f');
    //print(favoritesPostIds);

    if (favoritesPostIds.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }
  }

  final Stream<QuerySnapshot> posts = FirebaseFirestore.instance
      .collection(CollectionNames.post.name)
      .orderBy(PostFieldNames.postDate.name, descending: true)
      .snapshots();

  @override
  void initState() {
    super.initState();
    if (favoritesPostIds.isEmpty) {
      getPostIds();
    }
  }
}
