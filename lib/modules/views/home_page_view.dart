import 'package:flutter/material.dart';
import '../../pages/home_page.dart';
import '../models/user_model.dart';
import '../services/service.dart';

abstract class HomePageView extends State<HomePage> {
  final String locationTitle = 'Konum';

  final String location = 'İstanbul';

  final TextEditingController searchController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Future<UserModel?> getUserDetailsModel(String email) async {
    return await Service().getUserDetails(email);
  }
}
