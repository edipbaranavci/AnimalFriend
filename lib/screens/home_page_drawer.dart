import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friend_animals/constant/constants.dart';
import 'package:friend_animals/modules/models/user_model.dart';
import 'package:friend_animals/modules/services/service.dart';
import 'package:friend_animals/modules/ui/page_to.dart';
import 'package:friend_animals/pages/animal_share_page.dart';
import 'package:friend_animals/pages/login_page.dart';
import 'package:friend_animals/pages/my_posts_page.dart';
import 'package:get/get.dart';

import '../pages/favorites_page.dart';
import '../widgets/private/home_page_drawer_screen.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key? key,
    required this.userModel,
  }) : super(key: key);
  final UserModel userModel;

  Future<void> signOut() async {
    await Service().signOut();
    PageTo.page(const LoginPage(), arguments: 'd');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(userModel.photoUrl.toString()),
                ),
                title: Text(userModel.displayName.toString()),
                subtitle: Text(userModel.loginDate.toString()),
              ),
              HomePageDrawerListTile(
                onTap: () =>
                    PageTo.page(AnimalSharePage(userMail: userModel.email!)),
                icon: const Icon(FontAwesomeIcons.plus),
                title: HomePageDrawerStrings.adoptAnimalsTitle,
              ),
              HomePageDrawerListTile(
                onTap: () =>
                    PageTo.page(MyPostsPage(userMail: userModel.email!)),
                icon: const Icon(FontAwesomeIcons.bullhorn),
                title: HomePageDrawerStrings.myPostsTitle,
              ),
              HomePageDrawerListTile(
                onTap: () => PageTo.page(const FavoritesPage()),
                icon: const Icon(FontAwesomeIcons.heart),
                title: HomePageDrawerStrings.myFavoriteTitle,
              ),
              HomePageDrawerListTile(
                onTap: () {},
                icon: const Icon(FontAwesomeIcons.commentDots),
                title: HomePageDrawerStrings.messagesTitle,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton.icon(
                onPressed: signOut,
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  HomePageDrawerStrings.accountOutButtonTitle,
                  style: Theme.of(context).textTheme.headline6,
                )),
          )
        ],
      ),
    );
  }
}
