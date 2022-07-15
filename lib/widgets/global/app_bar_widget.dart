import 'package:flutter/material.dart';
import 'package:friend_animals/constant/padding_margin.dart';

import '../../constant/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget? child;
  final Color? backgroundColor;

  CustomAppBar({Key? key, this.child, this.backgroundColor})
      : preferredSize =
            const Size.fromHeight(Constants.appBarPreferredSizeValue),
        super(key: key);

  final ShapeBorder _border =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      shape: _border,
      margin: CustomMargin.appBarMargin,
      child: child,
    );
  }
}
