import 'package:base_frame/imports/core_imports.dart';
import 'package:built_value/built_value.dart';
part 'full_screen_error_contractor.g.dart';

abstract class FullScreenErrorData
    implements Built<FullScreenErrorData, FullScreenErrorDataBuilder> {
  factory FullScreenErrorData([
    void Function(FullScreenErrorDataBuilder) updates,
  ]) = _$FullScreenErrorData;

  FullScreenErrorData._();

  ScreenState get state;

  String? get errorMessage;
}

abstract class FullScreenErrorEvent {}

class InitFullScreenErrorEvent extends FullScreenErrorEvent {}
