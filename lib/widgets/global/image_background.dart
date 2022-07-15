import 'package:flutter/material.dart';
import 'package:friend_animals/constant/path_constants.dart';

class ImageBackground extends StatelessWidget {
  final Widget child;
  const ImageBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,
          image: AssetImage(PathConstants.backgroundImagePath),
        )),
        child: child,
      ),
    );
  }
}
