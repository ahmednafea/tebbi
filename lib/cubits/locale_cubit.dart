import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const _key = 'locale_code';
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(_loadInitial(_prefs));

  static Locale _loadInitial(SharedPreferences prefs) {
    final code = prefs.getString(_key);
    if (code != null) {
      final parts = code.split('_');
      return Locale(parts[0], parts.length > 1 ? parts[1] : null);
    }
    return const Locale('en', 'US'); // default
  }

  Future<void> setLocale(Locale locale) async {
    emit(locale);
    final code = locale.countryCode != null
        ? "${locale.languageCode}_${locale.countryCode}"
        : locale.languageCode;
    await _prefs.setString(_key, code);
  }
}
