import 'package:flutter/material.dart';

import '../../../../../app/localization/site_language.dart';

import '../site_content.dart';
import '../site_theme.dart';
import 'inquiry_section.dart';

const _barBackground = Color(0x4d091323);

class SiteHeader extends StatelessWidget {
  const SiteHeader({
    super.key,
    required this.compact,
    required this.active,
    required this.onNavigate,
    required this.onContact,
    required this.onService,
  });

  final bool compact;
  final ValueNotifier<SiteSection> active;
  final ValueChanged<SiteSection> onNavigate;
  final ValueChanged<Uri> onContact;
  final ValueChanged<String> onService;

  @override
  Widget build(BuildContext context) {
    final languageScope = SiteLanguageScope.maybeOf(context);
    final brand = InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => onNavigate(SiteSection.home),
      child: const _Brand(),
    );
    return Material(
      color: _barBackground,
      child: SiteFrame(
        compact: compact,
        child: SizedBox(
          height: compact ? 64 : 80,
          child: Row(
            children: [
              if (compact)
                Expanded(
                  child: Align(alignment: Alignment.centerLeft, child: brand),
                )
              else ...[
                brand,
                const Spacer(),
              ],
              if (languageScope != null && compact)
                _LanguageMenu(onChanged: languageScope.onChanged),
              if (compact) ...[
                IconButton(
                  tooltip: context.tr('Call SoftLance'),
                  style: IconButton.styleFrom(
                    backgroundColor: siteWash,
                    foregroundColor: sitePrimary,
                  ),
                  onPressed: () => onContact(companyPhoneUri),
                  icon: const Icon(Icons.phone_outlined, size: 20),
                ),
                if (languageScope == null) const SizedBox(width: 6),
                PopupMenuButton<SiteSection>(
                  tooltip: context.tr('Open navigation menu'),
                  icon: const Icon(Icons.menu),
                  onSelected: onNavigate,
                  itemBuilder: (context) => [
                    for (final section in SiteSection.values)
                      PopupMenuItem(
                        value: section,
                        child: Text(context.tr(section.label)),
                      ),
                  ],
                ),
              ] else ...[
                ValueListenableBuilder(
                  valueListenable: active,
                  builder: (context, current, _) => Row(
                    children: [
                      for (final section in SiteSection.values)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () => onNavigate(section),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                              ),
                              child: Text(
                                context.tr(section.label),
                                style: siteText(
                                  13,
                                  weight: FontWeight.w700,
                                  color: current == section
                                      ? siteLightBlue
                                      : Colors.white,
                                ),
                              ),
                            ),
                            if (section == SiteSection.services)
                              PopupMenuButton<String>(
                                tooltip: context.tr('Choose a service'),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                  minWidth: 190,
                                ),
                                onSelected: onService,
                                itemBuilder: (context) => [
                                  for (final service in siteServices)
                                    PopupMenuItem(
                                      value: service.title,
                                      child: Text(context.tr(service.title)),
                                    ),
                                ],
                                child: const SizedBox(
                                  width: 24,
                                  height: 44,
                                  child: Icon(
                                    Icons.expand_more,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                if (languageScope != null)
                  _LanguageMenu(onChanged: languageScope.onChanged),
                if (MediaQuery.sizeOf(context).width >= 1150)
                  TextButton.icon(
                    onPressed: () => onContact(companyPhoneUri),
                    icon: const Icon(
                      Icons.phone_outlined,
                      color: siteLightBlue,
                      size: 19,
                    ),
                    label: const Text(
                      companyPhone,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                else
                  IconButton(
                    tooltip: context.tr('Call {phone}', {
                      'phone': companyPhone,
                    }),
                    onPressed: () => onContact(companyPhoneUri),
                    icon: const Icon(
                      Icons.phone_outlined,
                      color: siteLightBlue,
                      size: 20,
                    ),
                  ),
                const SizedBox(width: 8),
                SiteButton(
                  context.tr('Discuss Your Project'),
                  onPressed: () => onNavigate(SiteSection.contact),
                  icon: Icons.arrow_forward,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageMenu extends StatelessWidget {
  const _LanguageMenu({required this.onChanged});

  final ValueChanged<SiteLanguage> onChanged;

  @override
  Widget build(BuildContext context) => PopupMenuButton<SiteLanguage>(
    tooltip: context.tr('Change language'),
    icon: const Icon(Icons.language, color: siteLightBlue),
    initialValue: context.siteLanguage,
    onSelected: onChanged,
    itemBuilder: (_) => [
      for (final language in SiteLanguage.values)
        PopupMenuItem(value: language, child: Text(language.label)),
    ],
  );
}

class SiteFooter extends StatelessWidget {
  const SiteFooter({
    super.key,
    required this.compact,
    required this.onNavigate,
    required this.onContact,
    required this.onService,
  });

  final bool compact;
  final ValueChanged<SiteSection> onNavigate;
  final ValueChanged<Uri> onContact;
  final ValueChanged<String> onService;

  @override
  Widget build(BuildContext context) {
    final summary = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Brand(footer: true),
        const SizedBox(height: 14),
        Text(
          context.tr(
            'Engineering smart software, mobile platforms and connected medical technology.',
          ),
          style: siteText(13, color: const Color(0xffb9c7db)),
        ),
      ],
    );
    final contact = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!compact)
          siteEyebrow(context.tr('Direct Contact'), color: Colors.white),
        if (!compact) const SizedBox(height: 8),
        ContactDetails(onContact: onContact),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (compact) ...[
          summary,
          const SizedBox(height: 13),
          const Divider(color: Color(0xff334360)),
          contact,
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30,
            children: [
              Expanded(flex: 4, child: summary),
              Expanded(
                flex: 2,
                child: _FooterLinks(
                  heading: context.tr('Navigation'),
                  links: {
                    for (final section in SiteSection.values)
                      context.tr(section.label): () => onNavigate(section),
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: _FooterLinks(
                  heading: context.tr('Core Competencies'),
                  links: {
                    for (final service in siteServices)
                      context.tr(service.title): () => onService(service.title),
                  },
                ),
              ),
              Expanded(flex: 4, child: contact),
            ],
          ),
        const SizedBox(height: 20),
        const Divider(color: Color(0xff334360)),
        const SizedBox(height: 10),
        Text(
          context.tr('© {year} {company}. All rights reserved.', {
            'year': DateTime.now().year.toString(),
            'company': companyName,
          }),
          style: siteText(12, color: const Color(0xffb9c7db)),
        ),
      ],
    );
  }
}

class SiteBottomBar extends StatelessWidget {
  const SiteBottomBar({
    super.key,
    required this.compact,
    required this.active,
    required this.onNavigate,
    required this.onCall,
    required this.onInquiry,
  });

  final bool compact;
  final ValueNotifier<SiteSection> active;
  final ValueChanged<SiteSection> onNavigate;
  final VoidCallback onCall;
  final VoidCallback onInquiry;

  @override
  Widget build(BuildContext context) => Material(
    color: _barBackground,
    child: SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.center,
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: compact ? double.infinity : 640,
          ),
          child: ValueListenableBuilder(
            valueListenable: active,
            builder: (context, current, _) => Row(
              children: [
                for (final (icon, label, callback, section) in [
                  (
                    Icons.home_outlined,
                    SiteSection.home.label,
                    () => onNavigate(SiteSection.home),
                    SiteSection.home,
                  ),
                  (
                    Icons.info_outline,
                    SiteSection.overview.label,
                    () => onNavigate(SiteSection.overview),
                    SiteSection.overview,
                  ),
                  (
                    Icons.grid_view_outlined,
                    SiteSection.services.label,
                    () => onNavigate(SiteSection.services),
                    SiteSection.services,
                  ),
                  (
                    Icons.work_outline,
                    SiteSection.portfolio.label,
                    () => onNavigate(SiteSection.portfolio),
                    SiteSection.portfolio,
                  ),
                  (Icons.phone_outlined, 'Call Expert', onCall, null),
                  (
                    Icons.chat_bubble_outline,
                    'Inquire Now',
                    onInquiry,
                    SiteSection.contact,
                  ),
                ])
                  Expanded(
                    child: Semantics(
                      selected: current == section,
                      child: TextButton(
                        onPressed: callback,
                        style: TextButton.styleFrom(
                          foregroundColor: current == section
                              ? siteLightBlue
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 7,
                          ),
                          shape: const RoundedRectangleBorder(),
                          minimumSize: const Size(0, 54),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 20),
                            const SizedBox(height: 3),
                            Text(
                              context.tr(label),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11, height: 1.2),
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
      ),
    ),
  );
}

class _Brand extends StatelessWidget {
  const _Brand({this.footer = false});

  final bool footer;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: siteWash,
          border: Border.all(color: siteBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset('assets/brand/softlance-mark.png'),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              footer ? companyName : 'SoftLance',
              maxLines: footer ? null : 1,
              overflow: footer ? null : TextOverflow.ellipsis,
              style: siteText(
                footer ? 16 : 21,
                weight: FontWeight.w800,
                height: 1.1,
                color: Colors.white,
              ),
            ),
            if (!footer)
              Text(
                'TECHNOLOGIES',
                style: siteText(
                  9,
                  weight: FontWeight.w800,
                  color: siteLightBlue,
                  spacing: 1.3,
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks({required this.heading, required this.links});

  final String heading;
  final Map<String, VoidCallback> links;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      siteEyebrow(heading, color: Colors.white),
      const SizedBox(height: 7),
      for (final entry in links.entries)
        TextButton(
          onPressed: entry.value,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 5),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            entry.key,
            style: siteText(12, color: const Color(0xffb9c7db)),
          ),
        ),
    ],
  );
}
