import 'package:flutter/material.dart';

const sitePrimary = Color(0xff005bff);
const siteLightBlue = Color(0xff72d8ff);
const siteInk = Color(0xff101828);
const siteMuted = Color(0xff53647a);
const siteBorder = Color(0xffdce5f1);
const siteWash = Color(0xfff5f8fc);
const siteNight = Color(0xff10192b);
const siteCanvas = Colors.white;
const siteSlate = Color(0xff214677);
const siteOnDark = Color(0xffd4e2f6);
const siteBannerGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [sitePrimary, Color(0xff163278), siteNight],
);
const siteFont = 'Plus Jakarta Sans';
const siteFontFallback = ['Noto Sans Gujarati', 'Noto Sans Devanagari'];

TextStyle siteText(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = siteInk,
  double height = 1.48,
  double? spacing,
  bool editorial = false,
}) => TextStyle(
  fontFamily: editorial ? 'Playfair Display' : siteFont,
  fontFamilyFallback: siteFontFallback,
  fontVariations: [FontVariation('wght', weight.value.toDouble())],
  fontSize: size,
  height: height,
  letterSpacing: spacing,
  color: color,
);

Widget siteEyebrow(String value, {Color color = sitePrimary}) => Text(
  value.toUpperCase(),
  style: siteText(11, weight: FontWeight.w800, color: color, spacing: 1.1),
);

class SectionHeading extends StatelessWidget {
  const SectionHeading(
    this.eyebrow,
    this.title, {
    super.key,
    this.description,
    required this.compact,
  });

  final String eyebrow;
  final String title;
  final String? description;
  final bool compact;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      siteEyebrow(eyebrow),
      const SizedBox(height: 6),
      Semantics(
        header: true,
        child: Text(
          title,
          style: siteText(
            compact ? 25 : 36,
            editorial: !compact,
            weight: FontWeight.w800,
            height: 1.2,
            spacing: -.8,
          ),
        ),
      ),
      if (description case final copy?) ...[
        const SizedBox(height: 7),
        Text(copy, style: siteText(14, color: siteMuted)),
      ],
    ],
  );
}

class SiteFrame extends StatelessWidget {
  const SiteFrame({
    super.key,
    required this.compact,
    required this.child,
    this.vertical = 0,
  });

  final bool compact;
  final Widget child;
  final double vertical;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1280),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 16 : 36,
          vertical: vertical,
        ),
        child: SizedBox(width: double.infinity, child: child),
      ),
    ),
  );
}

class SiteSectionFrame extends StatelessWidget {
  const SiteSectionFrame({
    super.key,
    required this.compact,
    required this.child,
    this.color = siteCanvas,
    this.gradient,
  });

  final bool compact;
  final Widget child;
  final Color color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: color, gradient: gradient),
    child: SiteFrame(
      compact: compact,
      vertical: compact ? 24 : 68,
      child: child,
    ),
  );
}

class SitePanel extends StatelessWidget {
  const SitePanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.color = Colors.white,
    this.onTap,
    this.radius = 10,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final VoidCallback? onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return Material(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: const BorderSide(color: siteBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}

class SiteButton extends StatelessWidget {
  const SiteButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.secondary = false,
    this.light = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool secondary;
  final bool light;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    );
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Text(label, textAlign: TextAlign.center)),
        if (icon case final trailing?) ...[
          const SizedBox(width: 8),
          Icon(trailing, size: 16),
        ],
      ],
    );
    final textStyle = siteText(14, weight: FontWeight.w800);
    const padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
    return secondary
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: siteInk,
              backgroundColor: Colors.white,
              shape: shape,
              padding: padding,
              side: const BorderSide(color: siteBorder),
              minimumSize: const Size(0, 44),
              textStyle: textStyle,
            ),
            child: content,
          )
        : FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              foregroundColor: light ? siteNight : Colors.white,
              backgroundColor: light ? siteLightBlue : sitePrimary,
              shape: shape,
              padding: padding,
              minimumSize: const Size(0, 44),
              textStyle: textStyle,
            ),
            child: content,
          );
  }
}

class IconTile extends StatelessWidget {
  const IconTile(this.icon, this.color, {super.key, this.size = 40});

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color.withValues(alpha: .09),
      borderRadius: BorderRadius.circular(size * .23),
    ),
    child: Icon(icon, size: size * .49, color: color),
  );
}
