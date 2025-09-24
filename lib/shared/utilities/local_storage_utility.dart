import 'package:tebbi/configs/app_constants.dart';
import 'package:tebbi/shared/services/local_storage/hive_local_storage_service.dart';

class LocalStorageUtility {
  //Box keys
  static const String userPreferencesBoxKey = 'user_preferences_box_key';
  static const String userInfoBoxKey = 'user_info_box_key';
  static const String userEncryptedBoxKey = AppConstants.encryptionKey;

  //Entry keys
  static const String _userExistsOnDeviceKey = 'user_exists_on_device';
  static const String _appLanguageKey = 'app_language';
  static const String emailKey = 'email';
  static const String passwordKey = 'password';
  static String? _interimToken;
  static String? _accessToken;
  static String? _refreshToken;
  static String? _userEmail;
  static String? _userPassword;
  static bool? _userExistsOnDevice;

  /// Gets the user's phone number from local storage.
  static Future<String?> get userEmail async {
    if (_userEmail != null) return _userEmail!;

    final String? email =
        HiveLocalStorageService.getEntry(userEncryptedBoxKey, emailKey)
            as String?;

    return _userEmail = email;
  }

  /// Sets the user's phone number in local storage.
  static Future<void> setUserEmail({required String value}) async {
    await HiveLocalStorageService.saveEntry(
      userEncryptedBoxKey,
      emailKey,
      value,
    );
    _userEmail = value;
  }

  /// Deletes the user's phone number from local storage.
  static Future<void> deleteUserEmail() async {
    await HiveLocalStorageService.deleteEntry(userEncryptedBoxKey, emailKey);
    _userEmail = null;
  }

  /// Gets the user's national ID from local storage.
  static Future<String?> get userPassword async {
    if (_userPassword != null) return _userPassword!;

    final String? userPassword =
        HiveLocalStorageService.getEntry(userEncryptedBoxKey, passwordKey)
            as String?;

    return _userPassword = userPassword;
  }

  /// Sets the user's national ID in local storage.
  static Future<void> setUserPassword({required String value}) async {
    await HiveLocalStorageService.saveEntry(
      userEncryptedBoxKey,
      passwordKey,
      value,
    );
    _userPassword = value;
  }

  /// Deletes the user's national ID from local storage.
  static Future<void> deleteUserPassword() async {
    await HiveLocalStorageService.deleteEntry(userEncryptedBoxKey, passwordKey);
    _userPassword = null;
  }

  /// Gets the user's existence status from local storage.
  static Future<bool> get userExistsOnDevice async {
    if (_userExistsOnDevice != null) return _userExistsOnDevice!;

    final bool userIsLoggedIn =
        HiveLocalStorageService.getEntry(
              userEncryptedBoxKey,
              _userExistsOnDeviceKey,
            )
            as bool? ??
        false;

    return _userExistsOnDevice = userIsLoggedIn;
  }

  /// Sets the user's existence status in local storage.
  static Future<void> setUserExistsOnDevice({required bool value}) async {
    await HiveLocalStorageService.saveEntry(
      userEncryptedBoxKey,
      _userExistsOnDeviceKey,
      value,
    );
    _userExistsOnDevice = value;
  }

  /// Gets the user's interim token from local storage.
  ///
  /// If the interim token has not been set before, it will return `null`.
  static String? get userInterimToken => _interimToken;

  /// Gets the user's access token from local storage.
  ///
  /// If the access token has not been set before, it will return `null`.
  static String? get userAccessToken => _accessToken;

  /// Gets the user's refresh token from local storage.
  ///
  /// If the refresh token has not been set before, it will return `null`.
  static String? get userRefreshToken => _refreshToken;

  /// Saves the user's interim token in local storage.
  static void saveInterimToken(String? token) => _interimToken = token;

  /// Saves the user's access and refresh tokens in local storage.
  static void saveUserTokens({required String accessToken}) {
    _accessToken = accessToken;
  }

  /// Deletes the user's interim token from local storage.
  static void deleteInterimToken() => _interimToken = null;

  /// Deletes the user's access and refresh tokens from local storage.
  static void deleteUserTokens() {
    _accessToken = null;
    _refreshToken = null;
  }

  /// Gets the app language from local storage.
  ///
  /// If the app language has not been set before, it will return `null`.
  static String? get appLanguage {
    final String? appLanguage =
        HiveLocalStorageService.getEntry(userPreferencesBoxKey, _appLanguageKey)
            as String?;

    return appLanguage;
  }

  /// Saves the app language in local storage.
  static Future<void> saveAppLanguage({required String appLanguage}) async {
    await HiveLocalStorageService.saveEntry(
      userPreferencesBoxKey,
      _appLanguageKey,
      appLanguage,
    );
  }
}
