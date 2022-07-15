import 'package:flutter/material.dart';

class AnimalPostDetails extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  const AnimalPostDetails({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: fontWeight, fontSize: 19),
      ),
    );
  }
}
