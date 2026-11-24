import 'package:flutter/material.dart';

import '../../../../../app/localization/site_language.dart';

import '../site_content.dart';
import '../site_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.compact,
    required this.onConsultation,
    required this.onExplore,
  });

  final bool compact;
  final VoidCallback onConsultation;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final heading = siteText(
      compact ? 30 : 57,
      editorial: !compact,
      color: Colors.white,
      weight: FontWeight.w800,
      height: 1.12,
      spacing: compact ? -1.2 : -2.1,
    );
    final actions = [
      SiteButton(
        context.tr('Get a Free Consultation'),
        onPressed: onConsultation,
        light: true,
        icon: Icons.arrow_forward,
      ),
      SiteButton(
        context.tr('Explore Services'),
        onPressed: onExplore,
        secondary: true,
      ),
    ];
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: compact ? siteLightBlue : siteWash,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: siteBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 15,
                color: sitePrimary,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  context.tr(companyLocation),
                  style: siteText(
                    12,
                    weight: FontWeight.w700,
                    color: sitePrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 21),
        Semantics(
          header: true,
          child: Text.rich(
            TextSpan(
              style: heading,
              children: [
                if (context.siteLanguage == SiteLanguage.english)
                  TextSpan(text: 'Building Smart Software for a '),
                TextSpan(
                  text: context.siteLanguage == SiteLanguage.english
                      ? 'Digital–First World'
                      : context.tr(
                          'Building Smart Software for a Digital–First World',
                        ),
                  style: heading.copyWith(
                    color: siteLightBlue,
                    fontStyle: compact ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          context.tr(
            'We design, develop and deliver scalable digital solutions, from mobile apps and web platforms to custom software, cloud deployment and AI-powered applications.',
          ),
          style: siteText(compact ? 15 : 17, color: siteOnDark, height: 1.65),
        ),
        const SizedBox(height: 24),
        if (compact)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [actions.first, const SizedBox(height: 9), actions.last],
          )
        else
          Wrap(spacing: 14, runSpacing: 10, children: actions),
        if (!compact) ...[
          const SizedBox(height: 28),
          const _Highlights(compact: false),
        ],
      ],
    );
    if (compact) {
      return Column(
        children: [
          copy,
          const SizedBox(height: 16),
          const _MobileTerminal(),
          const SizedBox(height: 12),
          const _Highlights(compact: true),
        ],
      );
    }
    return Row(
      children: [
        Expanded(flex: 10, child: copy),
        const SizedBox(width: 30),
        Expanded(
          flex: 9,
          child: SitePanel(
            color: siteWash,
            radius: 14,
            child: _DesktopArtwork(),
          ),
        ),
      ],
    );
  }
}

class _Highlights extends StatelessWidget {
  const _Highlights({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    const highlights = [
      (
        Icons.calendar_today_outlined,
        '10+ Years',
        'IT Experience',
        sitePrimary,
      ),
      (
        Icons.monitor_heart_outlined,
        'Healthcare',
        'IoT Expertise',
        Color(0xff008468),
      ),
      (Icons.memory, 'AI Driven', 'Technologies', Color(0xff6146e8)),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        for (final (icon, title, detail, color) in highlights)
          Expanded(
            child: SitePanel(
              color: siteWash,
              radius: 12,
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 5 : 9,
                vertical: 9,
              ),
              child: compact
                  ? Column(
                      children: [
                        IconTile(icon, color, size: 28),
                        const SizedBox(height: 4),
                        Text(
                          context.tr(title),
                          textAlign: TextAlign.center,
                          style: siteText(11, weight: FontWeight.w800),
                        ),
                        Text(
                          context.tr(detail),
                          textAlign: TextAlign.center,
                          style: siteText(10, color: siteMuted),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        IconTile(icon, color, size: 30),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr(title),
                                style: siteText(12, weight: FontWeight.w800),
                              ),
                              Text(
                                context.tr(detail),
                                style: siteText(11, color: siteMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
      ],
    );
  }
}

class _MobileTerminal extends StatelessWidget {
  const _MobileTerminal();

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: siteWash,
      boxShadow: const [
        BoxShadow(
          color: Color(0x151049a5),
          blurRadius: 18,
          offset: Offset(0, 9),
        ),
      ],
    ),
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
        Row(
          children: [
            const _WindowLights(),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                context.tr('MULTI-PLATFORM READY'),
                textAlign: TextAlign.end,
                style: siteText(9, color: siteMuted, spacing: 1.4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        DecoratedBox(
          decoration: BoxDecoration(
            color: siteWash,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: siteBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const IconTile(Icons.code, sitePrimary, size: 36),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('Full-Stack Cloud & App'),
                        style: siteText(
                          13,
                          weight: FontWeight.w800,
                          color: siteInk,
                        ),
                      ),
                      Text(
                        'Flutter · React · Node · AI',
                        style: siteText(11, color: siteMuted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _DesktopArtwork extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Semantics(
    image: true,
    label: context.tr('Laptop and mobile app development illustration'),
    child: ExcludeSemantics(
      child: AspectRatio(
        aspectRatio: 1.24,
        child: LayoutBuilder(
          builder: (context, bounds) {
            final w = bounds.maxWidth;
            final h = bounds.maxHeight;
            return Stack(
              children: [
                Positioned(
                  left: w * .18,
                  right: w * .05,
                  bottom: h * .06,
                  height: h * .35,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Color(0x9300bff5), Color(0x002666ff)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: w * .08,
                  top: 0,
                  child: _badge(context, 0, 'Android · iOS · Flutter'),
                ),
                Positioned(
                  right: 0,
                  top: 8,
                  child: _badge(
                    context,
                    3,
                    context.tr('Deploy · Manage · Scale'),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: h * .19,
                  child: _badge(context, 1, context.tr('Portals · Websites')),
                ),
                Positioned(
                  right: 0,
                  top: h * .21,
                  child: _badge(context, 4, context.tr('Social · Search')),
                ),
                Positioned(
                  left: w * .16,
                  right: w * .18,
                  top: h * .37,
                  bottom: h * .21,
                  child: _laptop(),
                ),
                Positioned(
                  right: w * .12,
                  top: h * .4,
                  width: w * .19,
                  height: h * .37,
                  child: _phone(),
                ),
                Positioned(
                  left: 0,
                  bottom: h * .07,
                  child: _badge(
                    context,
                    2,
                    context.tr('Business · Enterprise'),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: h * .05,
                  child: _badge(context, 5, context.tr('Models · Automation')),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );

  Widget _badge(BuildContext context, int index, String detail) {
    final service = siteServices[index];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x161049a5),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          IconTile(service.icon, service.color, size: 29),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(service.shortTitle),
                style: siteText(11, weight: FontWeight.w800),
              ),
              Text(detail, style: siteText(9, color: siteMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _laptop() => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(14),
        bottom: Radius.circular(4),
      ),
      color: siteNight,
      border: Border.all(color: sitePrimary, width: 5),
      boxShadow: const [
        BoxShadow(
          color: Color(0x5530538c),
          blurRadius: 22,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const _WindowLights(),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'SoftLance Core',
                overflow: TextOverflow.ellipsis,
                style: siteText(10, color: siteLightBlue, spacing: 1.2),
              ),
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Icon(Icons.code, size: 55, color: siteLightBlue),
          ),
        ),
        Container(width: 128, height: 5, color: sitePrimary),
        const SizedBox(height: 5),
        Container(width: 100, height: 5, color: siteSlate),
      ],
    ),
  );

  Widget _phone() => Container(
    padding: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: siteNight, width: 5),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [sitePrimary, siteNight],
      ),
      boxShadow: const [BoxShadow(color: Color(0x7745d5ff), blurRadius: 9)],
    ),
    child: Column(
      children: [
        Container(
          width: 23,
          height: 3,
          decoration: BoxDecoration(
            color: siteNight,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const Spacer(),
        const Icon(Icons.widgets_outlined, color: siteLightBlue, size: 23),
        const Spacer(),
        Container(width: 25, height: 3, color: siteLightBlue),
      ],
    ),
  );
}

class _WindowLights extends StatelessWidget {
  const _WindowLights();

  @override
  Widget build(BuildContext context) => const Row(
    spacing: 5,
    children: [
      Icon(Icons.circle, size: 8, color: Color(0xffff6578)),
      Icon(Icons.circle, size: 8, color: Color(0xffffc652)),
      Icon(Icons.circle, size: 8, color: Color(0xff36d8ae)),
    ],
  );
}
