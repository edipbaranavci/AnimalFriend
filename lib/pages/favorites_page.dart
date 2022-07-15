import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friend_animals/constant/padding_margin.dart';
import 'package:friend_animals/widgets/global/app_bar_widget.dart';
import 'package:friend_animals/widgets/global/image_background.dart';
import '../constant/constants.dart';
import '../modules/services/service.dart';
import '../modules/ui/page_to.dart';
import '../modules/views/favorites_page_view.dart';
import '../screens/animal_post.dart';
import 'animal_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends FavoritesPageView {
  @override
  Widget build(BuildContext context) {
    return ImageBackground(
      child: Scaffold(
        appBar: CustomAppBar(
          child: _AppBar(pageTitle: pageTitle),
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
                  child: _FavoritePosts(
                    favoritePostId: favoritesPostIds,
                    posts: posts,
                  ),
                ),
              ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
    required this.pageTitle,
  }) : super(key: key);

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const BackButton(),
      title: Text(
        pageTitle,
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: const Icon(FontAwesomeIcons.heart),
    );
  }
}

class _FavoritePosts extends StatelessWidget {
  const _FavoritePosts({
    Key? key,
    required this.posts,
    required this.favoritePostId,
  }) : super(key: key);

  final Stream<QuerySnapshot<Object?>> posts;
  final List<String> favoritePostId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: posts,
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
            if (favoritePostId.contains(postId) == true) {
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
