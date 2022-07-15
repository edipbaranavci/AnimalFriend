import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friend_animals/constant/cities_list.dart';
import 'package:friend_animals/constant/padding_margin.dart';
import 'package:friend_animals/widgets/global/app_bar_widget.dart';
import 'package:friend_animals/widgets/global/image_background.dart';
import 'package:image_picker/image_picker.dart';
import '../constant/constants.dart';
import '../modules/views/animal_share_page_view.dart';
import '../widgets/global/elevated_button.dart';
import '../widgets/private/animal_share_page.dart';

class AnimalSharePage extends StatefulWidget {
  final String userMail;
  const AnimalSharePage({Key? key, required this.userMail}) : super(key: key);

  @override
  State<AnimalSharePage> createState() => _AnimalSharePageState();
}

class _AnimalSharePageState extends AnimalSharePageView {
  @override
  Widget build(BuildContext context) {
    return ImageBackground(
      child: Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.background.withOpacity(0.7),
        appBar: CustomAppBar(child: const _AppBar()),
        body: isShare == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: CustomPadding.pagePadding,
                child: ListView(
                  children: [
                    selectedImage == null
                        ? const SizedBox.shrink()
                        : SizedBox(
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.file(selectedImage!),
                            ),
                          ),
                    _SelectCity(
                      onChanged: changeCity,
                      selectedCity: selectedCity,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      controller: titleController,
                      hintText: AnimalSharePageStrings.titleHintAndLabelText,
                      labelText: AnimalSharePageStrings.titleHintAndLabelText,
                      maxLength: AnimalShareConstants.titleMaxLength,
                      maxLine: AnimalShareConstants.titleMaxLine,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: aboutController,
                      hintText: AnimalSharePageStrings.aboutHintAndLabelText,
                      labelText: AnimalSharePageStrings.aboutHintAndLabelText,
                      maxLength: AnimalShareConstants.aboutMaxLength,
                      maxLine: AnimalShareConstants.aboutMaxLine,
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        var control = await showModalBottomSheet(
                          context: context,
                          builder: (context) => const _BottomSheet(),
                        );
                        getImage(control);
                      },
                      padding: 0,
                      child: Text(selectedImage == null
                          ? AnimalSharePageStrings.buttonTitle
                          : AnimalSharePageStrings.buttonSelectedTitle),
                    ),
                    selectedImage != null
                        ? _ShareButton(
                            onPressed: () {
                              sharePost();
                              Navigator.pop(context);
                            },
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onPressed,
      child: Text(AnimalSharePageStrings.shareButtonTitle),
    );
  }
}

class _SelectCity extends StatelessWidget {
  const _SelectCity({
    Key? key,
    required this.onChanged,
    required this.selectedCity,
  }) : super(key: key);

  final void Function(String?)? onChanged;
  final String selectedCity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.chevron_right),
      title: Text(AnimalSharePageStrings.cityTitle,
          style: Theme.of(context).textTheme.subtitle1),
      trailing: DropdownButton<String>(
        onChanged: onChanged,
        value: selectedCity,
        items: CitiesList.list.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SizedBox(
        width: 100,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: const Icon(
                FontAwesomeIcons.camera,
              ),
            ),
            Text(AnimalSharePageStrings.selectSourceTitle),
            CustomElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: const Icon(
                FontAwesomeIcons.fileImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: BackButton(color: Theme.of(context).primaryColor),
      title: Text(
        AnimalSharePageStrings.pageTitle,
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: const Icon(Icons.ios_share),
    );
  }
}
