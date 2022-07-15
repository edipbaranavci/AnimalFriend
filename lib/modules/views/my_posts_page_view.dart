import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constant/enums.dart';
import '../../pages/my_posts_page.dart';
import '../services/service.dart';

abstract class MyPostsPageView extends State<MyPostsPage> {
  final _service = Service();
  final viewUserModel = Service().userLoginControl();
  final String pageTitle = 'İlanlarım';
  bool isLoading = true;
  List<String> myPostIds = [];
  Future<void> getPostIds() async {
    myPostIds = await _service.getMyPostIds(viewUserModel!.email ?? 'f');

    if (myPostIds.isNotEmpty) {
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
    if (myPostIds.isEmpty) {
      getPostIds();
    }
  }
}
