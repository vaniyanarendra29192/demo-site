import 'package:base_frame/imports/core_imports.dart';
import 'package:base_frame/imports/dart_package_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/utils_import.dart';
import '../../localization/site_language.dart';
import '../bloc/application_bloc.dart';
import '../bloc/application_contract.dart';

class Application extends StatefulWidget {
  const Application({super.key, this.initialLanguage});

  final SiteLanguage? initialLanguage;
  static const languagePreference = 'site_language';

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends BaseState<AppBloc, Application>
    with WidgetsBindingObserver {
  late final RouterConfig<Object> _routerConfig;
  late SiteLanguage? _language = widget.initialLanguage;

  Future<void> _changeLanguage(SiteLanguage language) async {
    setState(() => _language = language);
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(
        Application.languagePreference,
        language.code,
      );
    } on Exception catch (error) {
      debugPrint('Could not save language preference: $error');
    }
  }

  @override
  void initState() {
    super.initState();

    _routerConfig = AppRouter(navigatorKey: navigatorKey).config();

    WidgetsBinding.instance.addObserver(this);

    bloc.add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>.value(
      value: bloc,
      child: BlocBuilder<AppBloc, ApplicationData>(
        builder: (_, state) => state.state == ScreenState.content
            ? MaterialApp.router(
                routerConfig: _routerConfig,
                locale: _language?.locale,
                supportedLocales: SiteLanguage.values.map(
                  (language) => language.locale,
                ),
                localizationsDelegates: GlobalMaterialLocalizations.delegates,
                builder: (_, child) => SiteLanguageScope(
                  onChanged: _changeLanguage,
                  child: child ?? const SizedBox.shrink(),
                ),
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: AppColors.backgroundColor,
                  ),
                ),
                debugShowCheckedModeBanner: false,
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  void onViewEvent(ViewAction event) {
    switch (event.runtimeType) {
      case const (ChangeTheme):
        _forceRebuildWidgets();
      case const (NavigateScreen):
        _buildHandleActionEvent(event as NavigateScreen);
    }
  }

  void _buildHandleActionEvent(NavigateScreen screen) async {
    switch (screen.target) {}
  }

  void _forceRebuildWidgets() {
    void rebuild(Element widget) {
      if (widget.dirty) return;
      try {
        widget.markNeedsBuild();
      } catch (_) {
        return;
      }
      widget.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      bloc.add(DisposeEvent());
    } else if (state == AppLifecycleState.paused) {
      bloc.add(AppPausedEvent());
    } else if (state == AppLifecycleState.resumed) {
      bloc.add(AppResumedEvent());
    }
  }
}
