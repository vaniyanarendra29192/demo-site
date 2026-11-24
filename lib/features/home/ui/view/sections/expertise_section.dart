import 'package:flutter/material.dart';

import '../../../../../app/localization/site_language.dart';

import '../site_theme.dart';

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({
    super.key,
    required this.compact,
    required this.expertiseKey,
    required this.onConnect,
    required this.onHealthcare,
  });

  final bool compact;
  final Key expertiseKey;
  final VoidCallback onConnect;
  final VoidCallback onHealthcare;

  @override
  Widget build(BuildContext context) {
    final founder = _FounderCard(compact: compact, onConnect: onConnect);
    final healthcare = _HealthcareCard(
      key: expertiseKey,
      compact: compact,
      onHealthcare: onHealthcare,
    );
    return compact
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14,
            children: [founder, healthcare],
          )
        : IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 26,
              children: [
                Expanded(child: founder),
                Expanded(child: healthcare),
              ],
            ),
          );
  }
}

class _FounderCard extends StatelessWidget {
  const _FounderCard({required this.compact, required this.onConnect});

  final bool compact;
  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) => SitePanel(
    padding: EdgeInsets.all(compact ? 18 : 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: compact ? 54 : 82,
              height: compact ? 54 : 82,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Color(0xff14469d), Color(0xff0c1734)],
                ),
              ),
              child: Text(
                'NV',
                style: siteText(
                  compact ? 18 : 24,
                  weight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  siteEyebrow(context.tr('Meet the Founder')),
                  const SizedBox(height: 4),
                  Text(
                    context.tr('Narendra Vaniya'),
                    style: siteText(
                      compact ? 18 : 25,
                      weight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.tr('MCA (2015) · 10+ Years of Experience'),
                    style: siteText(
                      12,
                      weight: FontWeight.w700,
                      color: sitePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          context.tr(
            'A software engineer with a decade of experience in mobile applications and healthcare IoT, now leading SoftLance Technologies to build practical, future-ready digital products.',
          ),
          style: siteText(14, color: siteMuted),
        ),
        const SizedBox(height: 13),
        SiteButton(
          context.tr('Connect with Founder'),
          onPressed: onConnect,
          secondary: true,
          icon: Icons.arrow_forward,
        ),
        if (!compact) ...[
          const SizedBox(height: 14),
          const Divider(color: siteBorder),
          const SizedBox(height: 8),
          for (final (icon, title, description, color) in [
            (
              Icons.monitor_heart_outlined,
              'Healthcare Technology',
              'ECG, multi-parameter monitoring, digital stethoscopes and telemetry.',
              sitePrimary,
            ),
            (
              Icons.favorite_border,
              'IoT Applications',
              'Connected medical and real-time smart sensory devices.',
              const Color(0xff008869),
            ),
            (
              Icons.memory,
              'AI Model Development',
              'Domain-specific workflows and automation.',
              const Color(0xff6349db),
            ),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  IconTile(icon, color, size: 35),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr(title),
                          style: siteText(13, weight: FontWeight.w800),
                        ),
                        Text(
                          context.tr(description),
                          style: siteText(12, color: siteMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    ),
  );
}

class _HealthcareCard extends StatelessWidget {
  const _HealthcareCard({
    super.key,
    required this.compact,
    required this.onHealthcare,
  });

  final bool compact;
  final VoidCallback onHealthcare;

  Widget _capabilities(BuildContext context, List<String> entries) => Column(
    spacing: 7,
    children: [
      for (final entry in entries)
        Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xff58e0ff),
              size: 17,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                context.tr(entry),
                style: siteText(
                  12,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    const capabilities = [
      'ECG Applications & Live Telemetry',
      'Digital Weighing Scales',
      'ELR Holter Diagnostic Applications',
      'Multi-Parameter Vital Signs Monitors',
      'Digital Stethoscopes',
    ];
    return Container(
      padding: EdgeInsets.all(compact ? 18 : 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xff091426),
            compact ? const Color(0xff172348) : const Color(0xff0757bd),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2804143c),
            blurRadius: 20,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!compact) ...[
            siteEyebrow(
              context.tr('Domain Expertise Focus'),
              color: const Color(0xff65e7ff),
            ),
            const SizedBox(height: 13),
          ],
          Semantics(
            header: true,
            child: Text(
              compact
                  ? context.tr('Healthcare & IoT Domain Focus')
                  : context.tr('Healthcare & IoT Domain Expertise'),
              style: siteText(
                compact ? 18 : 26,
                weight: FontWeight.w800,
                height: 1.15,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 11),
          Text(
            context.tr(
              'Specialized engineering for medical-grade connectivity, embedded monitoring and clinical device integrations.',
            ),
            style: siteText(13, color: const Color(0xffc2d3ed)),
          ),
          if (!compact) ...[const SizedBox(height: 16), const _Monitor()],
          const SizedBox(height: 17),
          if (compact)
            _capabilities(context, capabilities)
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 13,
              children: [
                Expanded(
                  child: _capabilities(context, capabilities.take(3).toList()),
                ),
                Expanded(
                  child: _capabilities(context, capabilities.skip(3).toList()),
                ),
              ],
            ),
          const SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xff75e9ff),
              padding: EdgeInsets.zero,
            ),
            onPressed: onHealthcare,
            child: Text(context.tr('Discuss a healthcare project')),
          ),
        ],
      ),
    );
  }
}

class _Monitor extends StatelessWidget {
  const _Monitor();

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xff06172b),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xff126082)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr('ECG MONITOR · LEAD II'),
                style: siteText(10, color: const Color(0xff51e2ff), spacing: 1),
              ),
              Text(
                context.tr('HR · 74 BPM'),
                style: siteText(10, color: const Color(0xff52f0c4), spacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SizedBox(
            height: 56,
            width: double.infinity,
            child: CustomPaint(painter: _Waveform()),
          ),
        ],
      ),
    ),
  );
}

class _Waveform extends CustomPainter {
  const _Waveform();

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = const Color(0xff112d44)
      ..strokeWidth = .8;
    for (var x = 0.0; x < size.width; x += 16) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (var y = 0.0; y < size.height; y += 14) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final wave = Path()..moveTo(size.width * .13, size.height * .55);
    for (final (x, y) in [
      (.34, .55),
      (.38, .37),
      (.41, .67),
      (.46, .16),
      (.49, .86),
      (.53, .48),
      (.61, .51),
      (.65, .34),
      (.69, .65),
      (.76, .54),
      (.86, .54),
    ]) {
      wave.lineTo(x * size.width, y * size.height);
    }
    canvas.drawPath(
      wave,
      Paint()
        ..color = const Color(0xff48e9ff)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(_Waveform oldDelegate) => false;
}
