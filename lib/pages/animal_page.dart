import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friend_animals/constant/padding_margin.dart';
import 'package:friend_animals/widgets/global/app_bar_widget.dart';
import 'package:friend_animals/widgets/global/elevated_button.dart';
import 'package:friend_animals/widgets/global/image_background.dart';
import 'package:friend_animals/widgets/global/loading_url_image.dart';
import '../modules/views/animal_page_view.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final String postId;

  @override
  State<AnimalPage> createState() => _AnimalViewPageState();
}

class _AnimalViewPageState extends AnimalPageView {
  @override
  Widget build(BuildContext context) {
    return ImageBackground(
        child: Scaffold(
      appBar: CustomAppBar(
        child: ListTile(
          leading: const BackButton(),
          title: Text(
            postModel?.postTitle ?? '',
            maxLines: 2,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_outlined),
          ),
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
              child: Container(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.7),
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: InteractiveViewer(
                                    child: LoadingUrlImage(
                                      imageUrl:
                                          postModel?.postImage ?? noImageUrl,
                                    ),
                                  ),
                                );
                              });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: InteractiveViewer(
                            child: LoadingUrlImage(
                              imageUrl: postModel?.postImage ?? noImageUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          userModel?.photoUrl ?? noImageUrl,
                        ),
                      ),
                      title: Text(userModel?.displayName ?? ''),
                      subtitle: Text(dateFormatter(postModel?.postDate ?? '')),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(FontAwesomeIcons.heart,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(postModel?.postFavoriteCount.toString() ?? '0')
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(FontAwesomeIcons.eye,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(postModel?.postShowCount.toString() ?? '0'),
                          ],
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.paw),
                      title: Text(postModel?.postTitle ?? ''),
                      subtitle: Text(postModel?.postAbout ?? ''),
                    ),
                    isUserPosts
                        ? ListTile(
                            onTap: deletePost,
                            title: Text(
                              'Postu Sil',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CustomElevatedButton(
                    onPressed: changeFavorite,
                    child: Icon(
                      Icons.favorite,
                      color: favorite == true
                          ? Colors.red
                          : Theme.of(context).colorScheme.background,
                    ),
                  ),
                  title: CustomElevatedButton(
                    onPressed: () {},
                    child: const Text('Sahiplen'),
                  ),
                ),
              ),
            ),
    ));
  }
}
