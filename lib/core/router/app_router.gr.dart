// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AboutPage]
class AboutRoute extends PageRouteInfo<void> {
  const AboutRoute({List<PageRouteInfo>? children})
    : super(AboutRoute.name, initialChildren: children);

  static const String name = 'AboutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AboutPage();
    },
  );
}

/// generated route for
/// [ContactPage]
class ContactRoute extends PageRouteInfo<void> {
  const ContactRoute({List<PageRouteInfo>? children})
    : super(ContactRoute.name, initialChildren: children);

  static const String name = 'ContactRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactPage();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    SiteSection? initialSection,
    List<PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, initialSection: initialSection),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomeScreen(key: args.key, initialSection: args.initialSection);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, this.initialSection});

  final Key? key;

  final SiteSection? initialSection;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, initialSection: $initialSection}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return key == other.key && initialSection == other.initialSection;
  }

  @override
  int get hashCode => key.hashCode ^ initialSection.hashCode;
}

/// generated route for
/// [OverviewPage]
class OverviewRoute extends PageRouteInfo<void> {
  const OverviewRoute({List<PageRouteInfo>? children})
    : super(OverviewRoute.name, initialChildren: children);

  static const String name = 'OverviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OverviewPage();
    },
  );
}

/// generated route for
/// [ServicesPage]
class ServicesRoute extends PageRouteInfo<void> {
  const ServicesRoute({List<PageRouteInfo>? children})
    : super(ServicesRoute.name, initialChildren: children);

  static const String name = 'ServicesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServicesPage();
    },
  );
}
