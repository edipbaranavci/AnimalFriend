import 'package:flutter/material.dart';
import 'package:friend_animals/modules/models/user_model.dart';
import 'package:friend_animals/modules/services/service.dart';
import 'package:intl/intl.dart';
import '../constant/paddings/animal_post_screen.dart';
import '../modules/models/post_model.dart';
import '../widgets/global/loading_url_image.dart';
import '../widgets/private/animal_post_screen.dart';

class AnimalPost extends StatefulWidget {
  const AnimalPost({
    Key? key,
    required this.onTap,
    required this.postModel,
  }) : super(key: key);

  final Function()? onTap;
  final PostModel postModel;

  @override
  State<AnimalPost> createState() => _AnimalPostState();
}

class _AnimalPostState extends State<AnimalPost> {
  @override
  void initState() {
    super.initState();
    getUserModel();
  }

  BorderRadius _borderRadiusCircular() => BorderRadius.circular(15);

  UserModel? _userModel = UserModel();
  final _service = Service();

  Future<void> getUserModel() async {
    for (var i = 0; i < 3; i++) {
      final getUser = await _service.getUserDetails(widget.postModel.userMail!);
      if (getUser != null) {
        _userModel = getUser;
        break;
      }
    }
  }

  final String noImageUrl =
      'https://uxwing.com/wp-content/themes/uxwing/download/12-peoples-avatars/no-profile-picture.png';

  String dateFormatter(String date) {
    if (date != '') {
      DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
      return DateFormat.yMMMEd('tr_TR').format(tempDate);
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: _borderRadiusCircular(),
      child: SizedBox(
        height: AnimalPostScreenConstants.postHeight,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            _DetailsWidgets(
              borderRadius: _borderRadiusCircular(),
              postAbout: widget.postModel.postAbout ?? '',
              postLocation: widget.postModel.postLocation ?? '',
              postTitle: widget.postModel.postTitle ?? '',
            ),
            _ImageView(imageUrl: widget.postModel.postImage!),
            _CountsWidgets(
              postFavoriteCount: widget.postModel.postFavoriteCount.toString(),
              postShowCount: widget.postModel.postShowCount.toString(),
            ),
            _UserAndDateWidget(
              date: dateFormatter(widget.postModel.postDate ?? ''),
              imageUrl: _userModel?.photoUrl ?? noImageUrl,
              userName: _userModel?.displayName ?? '',
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsWidgets extends StatelessWidget {
  const _DetailsWidgets({
    Key? key,
    required this.postAbout,
    required this.postTitle,
    required this.postLocation,
    required this.borderRadius,
  }) : super(key: key);

  final String postAbout;
  final String postTitle;
  final String postLocation;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AnimalPostScreenConstants.descriptionTopValue,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: AnimalPostScreenConstants.postDescriptionHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: borderRadius,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimalPostDetails(
                  text: postTitle,
                  fontWeight: FontWeight.bold,
                ),
                AnimalPostDetails(
                  text: postAbout,
                  fontWeight: FontWeight.w400,
                ),
                AnimalPostDetails(
                  text: postLocation,
                  fontWeight: FontWeight.w300,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserAndDateWidget extends StatelessWidget {
  const _UserAndDateWidget({
    Key? key,
    required this.userName,
    required this.imageUrl,
    required this.date,
  }) : super(key: key);

  final String userName;
  final String imageUrl;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: AnimalPostScreenConstants.userAndDateTop,
      child: SizedBox(
        width: AnimalPostScreenConstants.userAndDateWidth,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: AnimalPostScreenConstants.userImageRadius,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(userName),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(date),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountsWidgets extends StatelessWidget {
  const _CountsWidgets({
    Key? key,
    required this.postFavoriteCount,
    required this.postShowCount,
  }) : super(key: key);

  final String postFavoriteCount;
  final String postShowCount;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 20,
        bottom: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                postFavoriteCount,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                Icons.remove_red_eye_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                postShowCount,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ],
        ));
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;
  BorderRadius _borderRadiusCircular() => BorderRadius.circular(15);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AnimalPostScreenConstants.imageTopValue,
      left: AnimalPostScreenConstants.imageLeftValue,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: _borderRadiusCircular(),
        ),
        height: AnimalPostScreenConstants.postImageHeight,
        width: MediaQuery.of(context).size.width * 0.40,
        child: ClipRRect(
          borderRadius: _borderRadiusCircular(),
          child: LoadingUrlImage(imageUrl: imageUrl),
        ),
      ),
    );
  }
}
