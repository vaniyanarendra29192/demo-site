import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'site_content.dart';

@RoutePage()
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const HomeScreen(initialSection: SiteSection.overview);
}

@RoutePage()
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const HomeScreen(initialSection: SiteSection.about);
}

@RoutePage()
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const HomeScreen(initialSection: SiteSection.services);
}

@RoutePage()
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const HomeScreen(initialSection: SiteSection.contact);
}
