import 'package:flutter/material.dart';
import 'package:friend_animals/modules/services/service.dart';
import '../../constant/constants.dart';
import '../../constant/paddings/login_page_padding.dart';
import '../../constant/path_constants.dart';
import '../../pages/home_page.dart';
import '../../pages/login_page.dart';
import '../models/user_model.dart';
import '../ui/page_to.dart';

abstract class LoginPageView extends State<LoginPage> {
  final service = Service();
  bool isLoading = false;

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> loginButton() async {
    _changeLoading();
    final getUser = await service.userLogin();
    if (getUser != null) {
      PageTo.page(HomePage(userModel: getUser));
    }
    _changeLoading();
  }

  Padding welcomeImage() {
    return Padding(
      padding: LoginPagePadding.imagePadding,
      child: Image.asset(PathConstants.welcomeImagePath),
    );
  }

  Text welcomeTitle(BuildContext context) {
    return Text(
      WelcomePageStrings.appWelcomeTitle,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
