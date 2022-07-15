import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:friend_animals/constant/padding_margin.dart';
import 'package:friend_animals/modules/services/service.dart';
import 'package:friend_animals/modules/ui/page_to.dart';
import 'package:friend_animals/pages/animal_page.dart';
import 'package:friend_animals/screens/animal_post.dart';
import 'package:friend_animals/widgets/global/app_bar_widget.dart';
import '../constant/constants.dart';
import '../constant/enums.dart';
import '../constant/paddings/home_page_padding.dart';
import '../modules/models/user_model.dart';
import '../modules/views/home_page_view.dart';
import '../screens/home_page_drawer.dart';
import '../widgets/global/image_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomePageView {
  final Stream<QuerySnapshot> posts = FirebaseFirestore.instance
      .collection(CollectionNames.post.name)
      .orderBy(PostFieldNames.postDate.name, descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return ImageBackground(
      child: Scaffold(
        key: scaffoldKey,
        drawer: HomePageDrawer(userModel: widget.userModel),
        appBar: CustomAppBar(
          child: _HomeAppBar(
            menuFunction: () => scaffoldKey.currentState?.openDrawer(),
            locationFunction: () {},
            profileFunction: () => scaffoldKey.currentState?.openDrawer(),
            locationTitle: locationTitle,
            location: location,
            ppUrl: widget.userModel.photoUrl!,
          ),
        ),
        body: Padding(
          padding: CustomPadding.pagePadding,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
            ),
            child: Column(
              children: [
                _SearchWidget(searchController: searchController),
                Expanded(
                  child: _Posts(
                    posts: posts,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Posts extends StatelessWidget {
  const _Posts({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final Stream<QuerySnapshot<Object?>> posts;

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
            final _service = Service();
            final postModel = _service.getPostModel(snapshot.data!.docs, index);
            return AnimalPost(
              postModel: postModel,
              onTap: () => PageTo.page(AnimalPage(
                postId: snapshot.data!.docs[index].id,
              )),
            );
          },
        );
      },
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: HomePagePadding.searchField,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
          iconColor: Theme.of(context).primaryColor,
          hintText: HomePageStrings.searchWidgetTitle,
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({
    Key? key,
    required this.locationTitle,
    required this.location,
    required this.ppUrl,
    this.menuFunction,
    this.locationFunction,
    this.profileFunction,
  }) : super(key: key);

  final String locationTitle;
  final String location;
  final String ppUrl;

  final Function()? menuFunction;
  final Function()? locationFunction;
  final Function()? profileFunction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
          onPressed: menuFunction,
          icon: const Icon(
            Icons.menu,
          )),
      title: Text(
        locationTitle,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: InkWell(
          onTap: locationFunction,
          child: Text(
            location,
            style: Theme.of(context).textTheme.headline5,
          )),
      trailing: InkWell(
        onTap: profileFunction,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.red,
            backgroundImage: CachedNetworkImageProvider(ppUrl),
          ),
        ),
      ),
    );
  }
}
