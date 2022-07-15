import 'package:flutter/material.dart';

class LoadingUrlImage extends StatelessWidget {
  const LoadingUrlImage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, isLoading) => isLoading == null
          ? child
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
