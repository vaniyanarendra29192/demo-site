import 'package:base_frame/imports/core_imports.dart';
import 'package:built_value/built_value.dart';

part 'application_contract.g.dart';

abstract class ApplicationData
    implements Built<ApplicationData, ApplicationDataBuilder> {
  factory ApplicationData([void Function(ApplicationDataBuilder) updates]) =
      _$ApplicationData;

  ApplicationData._();

  ScreenState get state;

  String? get errorMessage;

}

abstract class MainAppEvent {}

class InitEvent extends MainAppEvent {}

class DisposeEvent extends MainAppEvent {}

class AppResumedEvent extends MainAppEvent {}

class AppPausedEvent extends MainAppEvent {}
