import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class SplashLocalDataSource {
  Future<bool> checkUserToken();
  Future<void> cacheUserToken(String token);
}

@LazySingleton(as: SplashLocalDataSource)
class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const userTokenKey = 'USER_TOKEN';

  SplashLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> checkUserToken() async {
    try {
      final token = sharedPreferences.getString(userTokenKey);
      return token != null;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserToken(String token) async {
    try {
      await sharedPreferences.setString(userTokenKey, token);
    } catch (e) {
      throw CacheException();
    }
  }
}
