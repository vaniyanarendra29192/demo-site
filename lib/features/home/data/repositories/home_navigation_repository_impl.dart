import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain/home_navigation_repository.dart';
import '../model/route_model.dart';

@LazySingleton(as: HomeNavigationRepository)
class HomeNavigationRepositoryImpl implements HomeNavigationRepository {
  final StreamController<RouteModel> _homeNavigationController =
      StreamController<RouteModel>.broadcast();

  @override
  Stream<RouteModel> get homeNavigationControllerStream =>
      _homeNavigationController.stream;

  @override
  void notifyHomeNavigationControllerStream(RouteModel routeModel) =>
      _homeNavigationController.add(routeModel);
}
