import 'dart:async';

import 'package:base_frame/imports/core_imports.dart';
import 'package:base_frame/imports/dart_package_imports.dart';
import 'package:injectable/injectable.dart';
import 'home_contract.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeData> {
  HomeBloc({required EventBus eventBus})
      : _eventBus = eventBus,
        super(initState) {
    on<InitHomeEvent>(_initHomeEvent);
    _observeStreamSubscription();
    _observeEventBus();
    _listenNavigationScreen();
  }

  static HomeData get initState =>
      (HomeDataBuilder()
            ..state = ScreenState.content
            ..errorMessage = '')
          .build();

  final EventBus _eventBus;

  void _initHomeEvent(_, Emitter<HomeData> emitter) {}

  void _observeStreamSubscription() {}

  @override
  Future<void> close() {
    return super.close();
  }

  void _observeEventBus() =>
      _eventBus.events.listen(_handleBusEvents).bindToLifecycle(this);

  void _handleBusEvents(BusEvent it) async {
    switch (it.runtimeType) {}
  }

  void _listenNavigationScreen() {}
}
