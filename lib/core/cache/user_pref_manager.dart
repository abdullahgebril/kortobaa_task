import 'package:flutter_task/core/cache/cache_manger.dart';
import 'package:flutter_task/core/utils/app_constants.dart';

class UserPrefManager {
  static Future saveCurrentUserAccessToken(String accessToken) async {
    CacheManager.saveString(AppConstants.ACCESS_TOKEN, accessToken);
  }

  static Future<String?> getCurrentUserAccessToken() async {
    return CacheManager.getString(AppConstants.ACCESS_TOKEN);
  }

  static Future saveCurrentUserRefreshToken(String refreshToken) async {
    CacheManager.saveString(AppConstants.REFRESH_TOKEN, refreshToken);
  }

  static Future<String?> getCurrentUserRefreshToken() async {
    return CacheManager.getString(AppConstants.REFRESH_TOKEN);
  }
}
