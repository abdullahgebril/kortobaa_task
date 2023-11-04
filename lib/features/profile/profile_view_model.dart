import 'package:flutter_task/core/cache/user_cache.dart';
import 'package:flutter_task/features/registration/model/user_model.dart';

class ProfileViewModel {
  User? user;

  getCurrentUser() {
    user = UserPrefCache.getCurrentUser();
  }
}
