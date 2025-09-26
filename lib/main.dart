import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tebbi/configs/app_colors.dart';
import 'package:tebbi/configs/app_constants.dart';
import 'package:tebbi/cubits/locale_cubit.dart';
import 'package:tebbi/screens/splash/splash_screen.dart';
import 'package:tebbi/shared/services/local_storage/hive_local_storage_service.dart';
import 'package:tebbi/shared/utilities/local_storage_utility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await HiveLocalStorageService.initialize();
  await HiveLocalStorageService.registerUninitializedBox(
    LocalStorageUtility.userInfoBoxKey,
  );
  await HiveLocalStorageService.registerUninitializedBox(
    LocalStorageUtility.userPreferencesBoxKey,
  );
  await HiveLocalStorageService.registerUninitializedBox(
    AppConstants.encryptionKey,
  );
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  final bool containsEncryptionKey = await secureStorage.containsKey(
    key: AppConstants.encryptionKey,
  );

  if (!containsEncryptionKey) {
    final List<int> key = Hive.generateSecureKey();
    await secureStorage.write(
      key: AppConstants.encryptionKey,
      value: base64UrlEncode(key),
    );
  }
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', '`EG`')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'EG'),
      startLocale: LocaleCubit(prefs).state,
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => LocaleCubit(prefs))],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
