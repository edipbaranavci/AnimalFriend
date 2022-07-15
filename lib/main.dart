import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:friend_animals/constant/enums.dart';
import 'package:friend_animals/modules/services/service.dart';
import 'package:friend_animals/pages/home_page.dart';
import 'package:friend_animals/settings/themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'modules/services/error_writer.dart';
import 'pages/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  initializeDateFormatting('tr');
  GetStorage.init(CollectionNames.user.name);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? loginWidget() {
    try {
      final userModel = Service().userLoginControl();
      if (userModel != null) {
        return HomePage(userModel: userModel);
      } else {
        return const LoginPage();
      }
    } catch (e) {
      ErrorWriter.write(e, this);
    }
    return const LoginPage();
  }

  final String _appTitle = 'Hayvan Dostu';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: _appTitle,
      theme: CustomThemes.light(),
      themeMode: ThemeMode.light,
      home: loginWidget(),
    );
  }
}
