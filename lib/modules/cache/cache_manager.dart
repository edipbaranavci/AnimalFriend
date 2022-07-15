import 'dart:developer';

import 'package:friend_animals/constant/enums.dart';
import 'package:friend_animals/modules/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

final String _boxKey = CollectionNames.user.name;

class CacheManager {
  final _box = GetStorage(_boxKey);

  UserModel? getUser() {
    for (var i = 0; i < 9; i++) {
      final oku = _box.read(_boxKey);
      if (oku != null) {
        final userModel = UserModel.fromMap(oku);
        return userModel;
      }
    }
    return null;
  }

  Future<void> clear() async {
    await _box.remove(_boxKey);
  }

  void putUser(UserModel userModel) {
    _box.write(_boxKey, userModel.toMap());
    print(_box.read(_boxKey));
  }
}
