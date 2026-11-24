import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'app/application/platform/browser_resume.dart';
import 'app/application/view/application.dart';
import 'app/localization/site_language.dart';
import 'core/inject/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerBrowserResume();

  debugRepaintRainbowEnabled = false;

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await Injector.setup();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SiteLanguage? initialLanguage;
  try {
    final preferences = await SharedPreferences.getInstance();
    initialLanguage = SiteLanguage.fromCode(
      preferences.getString(Application.languagePreference),
    );
  } on Exception catch (error) {
    debugPrint('Could not read language preference: $error');
  }

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) =>
          Application(initialLanguage: initialLanguage),
    ),
  );
}
