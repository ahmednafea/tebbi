import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tebbi/cubits/locale_cubit.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LocaleCubit>().state;

    final List<Map<String, dynamic>> languages = [
      {'locale': const Locale('en', 'US'), 'name': 'English', 'flag': '🇺🇸'},
      {'locale': const Locale('ar', 'SA'), 'name': 'العربية', 'flag': '🇸🇦'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: currentLocale,
          isDense: true,
          icon: const Icon(Icons.language),
          items: languages.map((lang) {
            final String flag = lang['flag'] as String;
            final String name = lang['name'] as String;
            final Locale locale = lang['locale'] as Locale;

            return DropdownMenuItem(
              value: locale,
              child: Row(
                children: [
                  Text(flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(name, style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
          onChanged: (locale) {
            if (locale != null) {
              context.read<LocaleCubit>().setLocale(locale);
              context.setLocale(locale);
            }
          },
        ),
      ),
    );
  }
}
