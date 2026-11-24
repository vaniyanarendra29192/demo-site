import 'package:base_frame/services/app_routes/app_routes_service.dart';
import 'package:base_frame/services/localization/localization_service.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants.dart';
import '../../../core/utils/routes.dart';

@lazySingleton
class BaseArchConfig {
  BaseArchConfig(this._localizationService, this._appRoutesService);

  final LocalizationService _localizationService;
  final AppRoutesService _appRoutesService;

  void init() {
    _localizationService.addLocalizations(
      localizationList: AppConstants.localizationList,
    );
    _appRoutesService.setAppRoutesServiceData(
      isAuthenticated: false,
      protectedRoutesList: AppRoutes().protectedRoutsList(),
    );
  }
}
