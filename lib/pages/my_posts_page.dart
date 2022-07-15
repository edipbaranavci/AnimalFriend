import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:friend_animals/modules/views/my_posts_page_view.dart';
import 'package:friend_animals/widgets/global/app_bar_widget.dart';
import 'package:friend_animals/widgets/global/image_background.dart';

import '../constant/constants.dart';
import '../constant/padding_margin.dart';
import '../modules/services/service.dart';
import '../modules/ui/page_to.dart';
import '../screens/animal_post.dart';
import 'animal_page.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({Key? key, required this.userMail}) : super(key: key);
  final String userMail;

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends MyPostsPageView {
  @override
  Widget build(BuildContext context) {
    return ImageBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          child: ListTile(
            leading: const BackButton(),
            title: Text(pageTitle),
          ),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Padding(
                padding: CustomPadding.pagePadding,
                child: Center(
                  child: _MyPosts(
                    myPosts: myPostIds,
                    stream: posts,
                  ),
                ),
              ),
      ),
    );
  }
}

class _MyPosts extends StatelessWidget {
  const _MyPosts({
    Key? key,
    required this.stream,
    required this.myPosts,
  }) : super(key: key);

  final Stream<QuerySnapshot<Object?>> stream;
  final List<String> myPosts;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              HomePageDrawerStrings.errorText,
              style: Theme.of(context).textTheme.headline6,
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data?.size,
          itemBuilder: (context, index) {
            final String postId = snapshot.data!.docs[index].id;
            if (myPosts.contains(postId) == true) {
              final postModel =
                  Service().getPostModel(snapshot.data!.docs, index);
              return AnimalPost(
                postModel: postModel,
                onTap: () => PageTo.page(AnimalPage(
                  postId: snapshot.data!.docs[index].id,
                )),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
