import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../features/home/ui/view/home_screen.dart';
import '../../features/home/ui/view/site_content.dart';
import '../../features/home/ui/view/site_routes.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    ..._initialRoute,
    ..._sharedRoutes,
    ..._siteRoutes,
  ];

  // ==================== CONFIGURATION ====================
  // Add/remove shared routes here - they'll be available everywhere

  static final _sharedRoutesConfig = [];

  List<CustomRoute> get _initialRoute => [
    CustomRoute(
      page: HomeRoute.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.noTransition,
      duration: const Duration(milliseconds: 2),
    ),
  ];

  List<CustomRoute> get _siteRoutes => [
    CustomRoute(
      page: OverviewRoute.page,
      path: '/overview',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      page: AboutRoute.page,
      path: '/about',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      page: ServicesRoute.page,
      path: '/services',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    CustomRoute(
      page: ContactRoute.page,
      path: '/contact',
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
  ];

  static List<AutoRoute> get _sharedRoutes => _sharedRoutesConfig
      .map(
        (page) => CustomRoute(
          page: page,
          path: '/${page.name}',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
      )
      .toList();
}
