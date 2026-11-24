import '../data/model/route_model.dart';

abstract class HomeNavigationRepository {
  Stream<RouteModel> get homeNavigationControllerStream;

  void notifyHomeNavigationControllerStream(RouteModel routeModel);
}
