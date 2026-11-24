import 'package:flutter/material.dart';

import 'site_messages_gu.dart';
import 'site_messages_hi.dart';

enum SiteLanguage {
  english('en', 'English'),
  gujarati('gu', 'ગુજરાતી'),
  hindi('hi', 'हिन्दी');

  const SiteLanguage(this.code, this.label);

  final String code;
  final String label;

  Locale get locale => Locale(code);

  static SiteLanguage? fromCode(String? code) {
    for (final language in values) {
      if (language.code == code) return language;
    }
    return null;
  }
}

class SiteLanguageScope extends InheritedWidget {
  const SiteLanguageScope({
    super.key,
    required this.onChanged,
    required super.child,
  });

  final ValueChanged<SiteLanguage> onChanged;

  static SiteLanguageScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SiteLanguageScope>();

  @override
  bool updateShouldNotify(SiteLanguageScope oldWidget) =>
      onChanged != oldWidget.onChanged;
}

extension SiteTranslation on BuildContext {
  SiteLanguage get siteLanguage =>
      SiteLanguage.fromCode(Localizations.localeOf(this).languageCode) ??
      SiteLanguage.english;

  String tr(String message, [Map<String, String> arguments = const {}]) {
    final translated = switch (siteLanguage) {
      SiteLanguage.english => message,
      SiteLanguage.gujarati => siteMessagesGu[message] ?? message,
      SiteLanguage.hindi => siteMessagesHi[message] ?? message,
    };
    if (arguments.isEmpty) return translated;
    return translated.replaceAllMapped(
      RegExp(r'\{(\w+)\}'),
      (match) => arguments[match[1]] ?? match[0]!,
    );
  }
}
