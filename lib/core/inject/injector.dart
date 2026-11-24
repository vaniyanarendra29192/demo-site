import 'package:base_frame/core/network/network_info.dart';
import 'package:base_frame/imports/core_imports.dart';
import 'package:base_frame/inject/base_injector.dart';
import 'package:base_frame/services/app_routes/app_routes_service.dart';
import 'package:base_frame/services/localization/localization_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../app/application/config/base_arch_config.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  generateForDir: ['lib/app/application', 'lib/core/inject', 'lib/features'],
  throwOnMissingDependencies: true,
)
Future<void> configureDependencies() async =>
    await getIt.init(environment: 'dev');

@module
abstract class PluginModule {
  @preResolve
  Future<LocalizationService> get localizationService async =>
      BaseInjector.localizationService;

  @preResolve
  Future<AppRoutesService> get appRoutesService async =>
      BaseInjector.appRoutesService;

  @preResolve
  Future<EventBus> get eventBus async => BaseInjector.eventBus;

  NetworkInfoImpl get networkInfo => BaseInjector.networkInfoImpl;
}

class Injector {
  static Future<bool> setup() async {
    await configureDependencies();
    getIt<BaseArchConfig>().init();
    BaseState.setExternalResolver(Injector.resolve);
    return true;
  }

  static T resolve<T extends Object>() => getIt<T>();
}
