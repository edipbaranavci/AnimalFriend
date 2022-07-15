import 'package:flutter/material.dart';

class HomePageDrawerListTile extends StatelessWidget {
  const HomePageDrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(title),
    );
  }
}
