import 'package:base_frame/core/screen_state.dart';
import 'package:built_value/built_value.dart';

part 'home_contract.g.dart';

abstract class HomeData implements Built<HomeData, HomeDataBuilder> {
  factory HomeData([void Function(HomeDataBuilder) updates]) = _$HomeData;

  HomeData._();

  ScreenState get state;

  String? get errorMessage;
}

abstract class HomeEvent {}

class InitHomeEvent extends HomeEvent {}
