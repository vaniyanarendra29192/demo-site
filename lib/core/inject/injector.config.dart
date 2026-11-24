// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:base_frame/core/network/network_info.dart' as _i858;
import 'package:base_frame/imports/core_imports.dart' as _i955;
import 'package:base_frame/services/app_routes/app_routes_service.dart'
    as _i239;
import 'package:base_frame/services/localization/localization_service.dart'
    as _i293;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:the_neelkanth_heritage/app/application/bloc/application_bloc.dart'
    as _i382;
import 'package:the_neelkanth_heritage/app/application/config/base_arch_config.dart'
    as _i608;
import 'package:the_neelkanth_heritage/core/inject/injector.dart' as _i852;
import 'package:the_neelkanth_heritage/features/full_screen_error/ui/bloc/full_screen_error_bloc.dart'
    as _i1029;
import 'package:the_neelkanth_heritage/features/home/data/repositories/home_navigation_repository_impl.dart'
    as _i544;
import 'package:the_neelkanth_heritage/features/home/domain/home_navigation_repository.dart'
    as _i827;
import 'package:the_neelkanth_heritage/features/home/ui/bloc/home_bloc.dart'
    as _i255;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final pluginModule = _$PluginModule();
    gh.factory<_i382.AppBloc>(() => _i382.AppBloc());
    await gh.factoryAsync<_i293.LocalizationService>(
      () => pluginModule.localizationService,
      preResolve: true,
    );
    await gh.factoryAsync<_i239.AppRoutesService>(
      () => pluginModule.appRoutesService,
      preResolve: true,
    );
    await gh.factoryAsync<_i955.EventBus>(
      () => pluginModule.eventBus,
      preResolve: true,
    );
    gh.factory<_i858.NetworkInfoImpl>(() => pluginModule.networkInfo);
    gh.lazySingleton<_i827.HomeNavigationRepository>(
      () => _i544.HomeNavigationRepositoryImpl(),
    );
    gh.factory<_i1029.FullScreenErrorBloc>(
      () => _i1029.FullScreenErrorBloc(gh<_i858.NetworkInfoImpl>()),
    );
    gh.factory<_i255.HomeBloc>(
      () => _i255.HomeBloc(eventBus: gh<_i955.EventBus>()),
    );
    gh.lazySingleton<_i608.BaseArchConfig>(
      () => _i608.BaseArchConfig(
        gh<_i293.LocalizationService>(),
        gh<_i239.AppRoutesService>(),
      ),
    );
    return this;
  }
}

class _$PluginModule extends _i852.PluginModule {}
