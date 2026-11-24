import 'package:flutter/material.dart';

import '../../../../../app/localization/site_language.dart';

import '../site_content.dart';
import '../site_theme.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    super.key,
    required this.compact,
    required this.onService,
  });

  final bool compact;
  final ValueChanged<String> onService;

  @override
  Widget build(BuildContext context) {
    final description = context.tr(
      'A complete range of digital solutions to help your business grow, operate efficiently and stay ahead.',
    );
    final heading = SectionHeading(
      context.tr('Our Services'),
      context.tr('End-to-End Technology Services'),
      compact: compact,
      description: compact ? description : null,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (compact)
          heading
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: heading),
              const SizedBox(width: 30),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Text(description, style: siteText(14, color: siteMuted)),
              ),
            ],
          ),
        SizedBox(height: compact ? 22 : 42),
        LayoutBuilder(
          builder: (context, bounds) {
            final columns = bounds.maxWidth < 250
                ? 1
                : compact
                ? 2
                : 3;
            return _CardRows(
              columns: columns,
              gap: compact ? 12 : 17,
              cards: [
                for (final service in siteServices)
                  SitePanel(
                    color: compact ? siteWash : Colors.white,
                    padding: EdgeInsets.all(compact ? 14 : 19),
                    onTap: () => onService(service.title),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: compact ? 142 : 182,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconTile(service.icon, service.color),
                          const SizedBox(height: 12),
                          Text(
                            context.tr(
                              compact ? service.shortTitle : service.title,
                            ),
                            style: siteText(
                              15,
                              weight: FontWeight.w800,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            context.tr(service.description),
                            style: siteText(13, color: siteMuted),
                          ),
                          const Spacer(),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _RoundArrow(
                              color: sitePrimary,
                              size: compact ? 23 : 29,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key, required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          context.tr('Our Process'),
          context.tr('From Idea to Deployment'),
          compact: compact,
          description: context.tr(
            'A transparent, agile lifecycle to turn your idea into a reliable product.',
          ),
        ),
        SizedBox(height: compact ? 20 : 40),
        _CardRows(
          columns: compact ? 1 : 5,
          gap: compact ? 8 : 14,
          cards: [
            for (final (index, (title, description, icon, color))
                in processSteps.indexed)
              SitePanel(
                color: siteWash,
                padding: const EdgeInsets.all(14),
                radius: 13,
                child: compact
                    ? Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: .11),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: siteText(
                                14,
                                weight: FontWeight.w800,
                                color: color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 11),
                          Expanded(
                            child: _StepCopy(
                              context.tr(title),
                              context.tr(description),
                              compact: true,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: color),
                            ),
                            child: Icon(icon, size: 22, color: color),
                          ),
                          const SizedBox(height: 11),
                          _StepCopy(
                            '${index + 1}. ${context.tr(title)}',
                            context.tr(description),
                            compact: false,
                          ),
                        ],
                      ),
              ),
          ],
        ),
      ],
    );
  }
}

class _StepCopy extends StatelessWidget {
  const _StepCopy(this.title, this.description, {required this.compact});

  final String title;
  final String description;
  final bool compact;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: compact
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center,
    children: [
      Text(
        title,
        textAlign: compact ? TextAlign.start : TextAlign.center,
        style: siteText(14, weight: FontWeight.w800),
      ),
      const SizedBox(height: 3),
      Text(
        description,
        textAlign: compact ? TextAlign.start : TextAlign.center,
        style: siteText(12, color: siteMuted),
      ),
    ],
  );
}

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key, required this.compact});

  final bool compact;

  void _showConcept(BuildContext context, int index) {
    final (title, category, description, platform, illustration) =
        projectConcepts[index];
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          dialogContext.tr(title),
          style: siteText(21, weight: FontWeight.w800),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 420,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    illustration,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 14),
                siteEyebrow(dialogContext.tr(category)),
                const SizedBox(height: 8),
                Text(
                  dialogContext.tr(description),
                  style: siteText(15, color: siteMuted),
                ),
                const SizedBox(height: 8),
                Text(
                  dialogContext.tr('Illustrative concept · {platform}', {
                    'platform': platform,
                  }),
                  style: siteText(13, weight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(dialogContext.tr('Close')),
          ),
        ],
      ),
    );
  }

  void _showAll(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(
          context.tr('Project Concepts'),
          style: siteText(21, weight: FontWeight.w800),
        ),
        children: [
          for (final (index, concept) in projectConcepts.indexed)
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showConcept(context, index);
              },
              child: Text(dialogContext.tr(concept.$1), style: siteText(15)),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      for (final (index, (title, category, description, platform, illustration))
          in projectConcepts.indexed)
        SitePanel(
          padding: EdgeInsets.zero,
          onTap: () => _showConcept(context, index),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  AspectRatio(
                    aspectRatio: compact ? 2.05 : 2,
                    child: Image.asset(illustration, fit: BoxFit.cover),
                  ),
                  if (compact)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              siteNight.withValues(alpha: .95),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (compact)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        context.tr(title),
                        style: siteText(
                          15,
                          weight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!compact)
                      Text(
                        context.tr(title),
                        style: siteText(16, weight: FontWeight.w800),
                      ),
                    const SizedBox(height: 3),
                    Text(
                      context.tr(compact ? description : category),
                      style: siteText(13, color: siteMuted),
                    ),
                    if (compact) ...[
                      const SizedBox(height: 7),
                      Text(
                        platform,
                        style: siteText(
                          11,
                          weight: FontWeight.w800,
                          color: sitePrimary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
    ];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SectionHeading(
                context.tr('Portfolio (Illustrative)'),
                context.tr('Project Concepts'),
                compact: compact,
              ),
            ),
            TextButton(
              onPressed: () => _showAll(context),
              child: Text(context.tr('View All')),
            ),
          ],
        ),
        SizedBox(height: compact ? 17 : 36),
        if (compact)
          LayoutBuilder(
            builder: (context, bounds) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  for (final card in cards)
                    SizedBox(
                      width: (bounds.maxWidth * .77).clamp(190.0, 330.0),
                      child: card,
                    ),
                ],
              ),
            ),
          )
        else
          _CardRows(columns: 3, gap: 20, cards: cards),
      ],
    );
  }
}

class _CardRows extends StatelessWidget {
  const _CardRows({
    required this.columns,
    required this.gap,
    required this.cards,
  });

  final int columns;
  final double gap;
  final List<Widget> cards;

  @override
  Widget build(BuildContext context) => Column(
    spacing: gap,
    children: [
      for (var offset = 0; offset < cards.length; offset += columns)
        IntrinsicHeight(
          child: Row(
            spacing: gap,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var column = 0; column < columns; column++)
                Expanded(
                  child: offset + column < cards.length
                      ? cards[offset + column]
                      : const SizedBox.shrink(),
                ),
            ],
          ),
        ),
    ],
  );
}

class _RoundArrow extends StatelessWidget {
  const _RoundArrow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(color: siteBorder),
    ),
    child: Icon(Icons.arrow_forward_rounded, color: color, size: size * .55),
  );
}
