import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.maxLength,
    required this.maxLine,
    required this.keyboardType,
  }) : super(key: key);

  final int maxLength;
  final int maxLine;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final EdgeInsets outPadding = const EdgeInsets.all(5.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outPadding,
      child: TextFormField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.background,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            filled: true,
            focusColor: Theme.of(context).primaryColor,
            hintText: hintText,
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.subtitle1),
        controller: controller,
      ),
    );
  }
}
