import 'package:flutter_task/core/cache/cache_manger.dart';
import 'package:flutter_task/core/utils/app_constants.dart';

class UserPrefCache {
  static void deleteCurrentUser() {
    bool isTokenExist =
        CacheManager.sharedPreferences!.containsKey(AppConstants.currrentUser);
    if (isTokenExist) {
      CacheManager.sharedPreferences!.remove(AppConstants.currrentUser);
      // ignore: deprecated_member_use
      CacheManager.sharedPreferences!.commit();
    }
  }

  static void saveCurrentUser(String user) {
    CacheManager.sharedPreferences!.setString(AppConstants.currrentUser, user);
  }

  static dynamic getCurrentUser() =>
      CacheManager.sharedPreferences!.getString(AppConstants.currrentUser);
}
