import 'package:base_frame/imports/localization_imports.dart';

abstract class AppLocalization extends BaseLocalization {
  AppLocalization({required super.code, required super.name, super.country});

  static AppLocalization currentLocalization() =>
      Localization.currentLocalization as AppLocalization;

  String get companyName;

  String get retry;

  String get ok;

  String get done;

  String get somethingWentWrongPleaseTryAgain;

  String get sessionExpired;

  String get noInternetSubtitle;

  String get connectionLostTitle;

  String get somethingWentWrongDescription;
}
