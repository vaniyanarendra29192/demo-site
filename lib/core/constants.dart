// ignore_for_file: constant_identifier_names, type_annotate_public_apis

import 'package:flutter/material.dart';

import '../app/localization/en.dart';

final navigatorKey = GlobalKey<NavigatorState>();
var currentRouteName = '';

abstract class AppConstants {
  static final localizationList = [EnglishLocalization()];
  static const textFieldMaxLength = 2;
  static const bulletUnicodeValue = '\u2022';
}
