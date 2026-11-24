import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app/localization/site_language.dart';
import '../../../../core/router/app_router.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../data/repositories/email_project_inquiry_gateway.dart';
import '../../domain/project_inquiry.dart';
import 'sections/expertise_section.dart';
import 'sections/hero_section.dart';
import 'sections/home_video.dart';
import 'sections/inquiry_section.dart';
import 'sections/offerings_sections.dart';
import 'sections/site_chrome.dart';
import 'site_content.dart';
import 'site_theme.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialSection});

  final SiteSection? initialSection;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const ProjectInquiryGateway _gateway = EmailProjectInquiryGateway(
    companyEmail,
  );
  final _anchors = {
    for (final section in SiteSection.values) section: GlobalKey(),
  };
  final _active = ValueNotifier(SiteSection.home);
  final _selection = ValueNotifier<String?>(null);
  final _scrollController = ScrollController();
  final _pageFocus = FocusNode(debugLabel: 'Website page');

  @override
  void dispose() {
    _active.dispose();
    _selection.dispose();
    _scrollController.dispose();
    _pageFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final initialSection = widget.initialSection;
    if (initialSection == SiteSection.overview) {
      _active.value = SiteSection.overview;
    } else if (initialSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _navigate(initialSection);
      });
    }
  }

  void _navigate(SiteSection section) {
    final target = _anchors[section]?.currentContext;
    if (target == null) {
      final router = StackRouterScope.of(context)?.controller;
      if (section == SiteSection.overview) {
        router?.navigate(const OverviewRoute());
      } else if (section == SiteSection.home) {
        router?.navigate(HomeRoute());
      }
      return;
    }
    _pageFocus.requestFocus();
    _active.value = section;
    Scrollable.ensureVisible(
      target,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _chooseService(String service) {
    _selection.value = service;
    _navigate(SiteSection.contact);
  }

  Future<void> _openContact(Uri uri) async {
    try {
      if (await launchUrl(uri)) return;
    } on Exception {
      // Some devices do not handle email or telephone links.
    }
    if (!mounted) return;
    final contact = uri.scheme == 'tel' ? companyPhone : companyEmail;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.tr('Could not open this link. Contact us at {contact}.', {
            'contact': contact,
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData(
      fontFamily: siteFont,
      fontFamilyFallback: siteFontFallback,
      scaffoldBackgroundColor: siteCanvas,
      colorScheme: ColorScheme.fromSeed(
        seedColor: sitePrimary,
        primary: sitePrimary,
        surface: siteCanvas,
      ),
    ),
    child: LayoutBuilder(
      builder: (context, bounds) {
        final textScale = MediaQuery.textScalerOf(context).scale(14) / 14;
        final desktopWidth = context.siteLanguage == SiteLanguage.english
            ? 1040
            : 1200;
        final compact =
            bounds.maxWidth < desktopWidth * textScale.clamp(1.0, 2.0);
        final isHome =
            widget.initialSection == null ||
            widget.initialSection == SiteSection.home;
        final showVideo =
            isHome &&
            (ModalRoute.isCurrentOf(context) ?? true) &&
            !MediaQuery.disableAnimationsOf(context);
        final isOverview = widget.initialSection == SiteSection.overview;
        void contact() => _navigate(SiteSection.contact);
        return PrimaryScrollController(
          controller: _scrollController,
          child: Focus(
            focusNode: _pageFocus,
            autofocus: true,
            skipTraversal: true,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (showVideo)
                  HomeVideo(scrollController: _scrollController)
                else
                  const ColoredBox(color: siteNight),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  bottomNavigationBar: SiteBottomBar(
                    compact: compact,
                    active: _active,
                    onNavigate: _navigate,
                    onCall: () => _openContact(companyPhoneUri),
                    onInquiry: contact,
                  ),
                  body: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        SiteHeader(
                          compact: compact,
                          active: _active,
                          onNavigate: _navigate,
                          onContact: _openContact,
                          onService: _chooseService,
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, viewport) =>
                                SingleChildScrollView(
                                  primary: true,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (isHome)
                                        SizedBox(
                                          key: _anchors[SiteSection.home],
                                          height: viewport.maxHeight,
                                        ),
                                      if (isOverview)
                                        SiteSectionFrame(
                                          key: _anchors[SiteSection.overview],
                                          compact: compact,
                                          color: Colors.transparent,
                                          child: HeroSection(
                                            compact: compact,
                                            onConsultation: contact,
                                            onExplore: () =>
                                                _navigate(SiteSection.services),
                                          ),
                                        ),
                                      SiteSectionFrame(
                                        key: _anchors[SiteSection.services],
                                        compact: compact,
                                        color: siteWash,
                                        child: ServicesSection(
                                          compact: compact,
                                          onService: _chooseService,
                                        ),
                                      ),
                                      SiteSectionFrame(
                                        key: _anchors[SiteSection.about],
                                        compact: compact,
                                        child: ExpertiseSection(
                                          compact: compact,
                                          expertiseKey:
                                              _anchors[SiteSection.expertise]!,
                                          onConnect: contact,
                                          onHealthcare: () =>
                                              _chooseService(healthcareService),
                                        ),
                                      ),
                                      SiteSectionFrame(
                                        compact: compact,
                                        color: siteWash,
                                        child: ProcessSection(compact: compact),
                                      ),
                                      SiteSectionFrame(
                                        key: _anchors[SiteSection.portfolio],
                                        compact: compact,
                                        color: siteWash,
                                        child: PortfolioSection(
                                          compact: compact,
                                        ),
                                      ),
                                      SiteSectionFrame(
                                        key: _anchors[SiteSection.contact],
                                        compact: compact,
                                        color: siteCanvas,
                                        child: InquirySection(
                                          compact: compact,
                                          selection: _selection,
                                          gateway: _gateway,
                                          onContact: _openContact,
                                        ),
                                      ),
                                      SiteSectionFrame(
                                        compact: compact,
                                        color: siteNight,
                                        child: SiteFooter(
                                          compact: compact,
                                          onNavigate: _navigate,
                                          onContact: _openContact,
                                          onService: _chooseService,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
