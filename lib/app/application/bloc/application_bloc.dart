import 'dart:async';
import 'dart:io';

import 'package:base_frame/imports/core_imports.dart';
import 'package:base_frame/imports/dart_package_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'application_contract.dart';

@injectable
class AppBloc extends BaseBloc<MainAppEvent, ApplicationData> {
  AppBloc()
      : super(initState) {
    on<InitEvent>(_initEvent);
    on<DisposeEvent>(_disposeEvent);
    on<AppResumedEvent>(_appResumedEvent);
    on<AppPausedEvent>(_appPausedEvent);
  }

  // Indirection for `exit(0)` so the dispose handler can be exercised in
  // unit tests without terminating the test process. Override in tests.
  static void Function(int code) exitFn = exit;


  static ApplicationData get initState => (ApplicationDataBuilder()
        ..state = ScreenState.content)
      .build();

  void _initEvent(_, Emitter<ApplicationData> emit) async {
  }



  Future<void> _appPausedEvent(AppPausedEvent event, __) async {
    printLog(message: 'App is Paused');
  }

  Future<void> _appResumedEvent(
      AppResumedEvent event, Emitter<ApplicationData> emit) async {
    printLog(message: 'App is Resumed');
  }

  void _disposeEvent(_, __) {
    if (!kIsWeb) exitFn(0);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

