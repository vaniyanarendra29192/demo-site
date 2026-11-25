import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'site_content.dart';

part 'heritage_pages.dart';

enum HeritagePage {
  home('/', 'Overview', 'Home', Icons.home_outlined),
  plans('/floor-plans', 'Floor Plans', 'Plans', Icons.architecture),
  amenities('/amenities', 'Amenities', 'Amenities', Icons.park_outlined),
  location('/location', 'Connectivity', 'Location', Icons.place_outlined),
  specs(
    '/specifications',
    'Specifications',
    'Specs',
    Icons.fact_check_outlined,
  );

  const HeritagePage(this.path, this.label, this.shortLabel, this.icon);

  final String path;
  final String label;
  final String shortLabel;
  final IconData icon;
}

const _cream = Color(0xfffaf5ef);
const _paper = Color(0xfffffcf8);
const _terracotta = Color(0xff762c1b);
const _ink = Color(0xff30241e);
const _muted = Color(0xff65554a);
const _line = Color(0xffe9dfd5);
const _gold = Color(0xfff2d69c);
const _address =
    'Behind Pooja Farm, 100 Ft Road, near Karnavati Parishar Banglows, '
    'Narol, Ahmedabad 382405';
const _phones = [
  ('+91 89805 05256', '+918980505256'),
  ('+91 84016 75256', '+918401675256'),
];

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.initialSection});

  final SiteSection? initialSection;

  @override
  Widget build(BuildContext context) => HeritageSite(
    page: switch (initialSection) {
      SiteSection.about => HeritagePage.amenities,
      SiteSection.services => HeritagePage.plans,
      SiteSection.contact => HeritagePage.location,
      _ => HeritagePage.home,
    },
    showContact: initialSection == SiteSection.contact,
  );
}

class HeritageSite extends StatefulWidget {
  const HeritageSite({super.key, required this.page, this.showContact = false});

  final HeritagePage page;
  final bool showContact;

  @override
  State<HeritageSite> createState() => _HeritageSiteState();
}

class _HeritageSiteState extends State<HeritageSite> {
  void _navigate(HeritagePage page, {String? plan}) {
    if (page == widget.page) return;
    final path = Uri(
      path: page.path,
      queryParameters: plan == null ? null : {'unit': plan},
    );
    AutoRouter.of(context).navigatePath(path.toString());
  }

  @override
  void initState() {
    super.initState();
    if (widget.showContact) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _visit(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = widget.page == HeritagePage.plans
        ? RouteData.of(context).queryParams.optString('unit')
        : null;
    return Theme(
      data: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
        scaffoldBackgroundColor: _cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _terracotta,
          primary: _terracotta,
          surface: _paper,
          onSurface: _ink,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 48),
            side: const BorderSide(color: _line),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
      child: Builder(
        builder: (context) => LayoutBuilder(
          builder: (context, bounds) {
            final wide =
                bounds.maxWidth >=
                1060 * (MediaQuery.textScalerOf(context).scale(14) / 14);
            final phone = bounds.maxWidth < 600;
            return Scaffold(
              bottomNavigationBar: wide
                  ? null
                  : _MobileNavigation(page: widget.page, navigate: _navigate),
              body: SafeArea(
                bottom: wide,
                child: Column(
                  children: [
                    _header(context, wide, phone),
                    Expanded(
                      child: SingleChildScrollView(
                        key: PageStorageKey(widget.page),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ...switch (widget.page) {
                              HeritagePage.home => _overview(
                                context,
                                phone,
                                _navigate,
                              ),
                              HeritagePage.plans => _floorPlans(
                                context,
                                _plans
                                    .indexWhere((plan) => plan.id == unit)
                                    .clamp(0, _plans.length - 1),
                                (index) => AutoRouter.of(context).replacePath(
                                  '/floor-plans?unit=${_plans[index].id}',
                                ),
                              ),
                              HeritagePage.amenities => _amenities(context),
                              HeritagePage.location => _location(context),
                              HeritagePage.specs => _specifications(context),
                            },
                            _section(
                              color: _terracotta,
                              child: _contact(context),
                            ),
                            _section(
                              compact: true,
                              child: _columns(2, [
                                _title('The Neelkanth Heritage', size: 18),
                                const Text(
                                  'A project by Nivaan Infra · Narol, Ahmedabad',
                                ),
                              ], minWidth: 320),
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
      ),
    );
  }

  Widget _header(BuildContext context, bool wide, bool phone) => Material(
    color: _paper,
    child: Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _line)),
      ),
      padding: EdgeInsets.symmetric(horizontal: phone ? 14 : 26, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => _navigate(HeritagePage.home),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_balance_outlined, size: 22),
                    const SizedBox(width: 8),
                    Flexible(
                      child: _title(
                        'The Neelkanth Heritage',
                        size: phone ? 16 : 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (wide) ...[
            for (final page in HeritagePage.values)
              TextButton(
                onPressed: () => _navigate(page),
                child: Semantics(
                  selected: page == widget.page,
                  child: Text(
                    page.label,
                    style: TextStyle(
                      color: page == widget.page ? _terracotta : _ink,
                      decoration: page == widget.page
                          ? TextDecoration.underline
                          : null,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 20),
          ],
          FilledButton(
            onPressed: () => _visit(context),
            child: Text(phone ? 'Inquire' : 'Book a Site Visit'),
          ),
        ],
      ),
    ),
  );
}

class _MobileNavigation extends StatelessWidget {
  const _MobileNavigation({required this.page, required this.navigate});

  final HeritagePage page;
  final ValueChanged<HeritagePage> navigate;

  @override
  Widget build(BuildContext context) => Material(
    color: _paper,
    elevation: 3,
    child: SafeArea(
      top: false,
      child: Row(
        children: [
          for (final target in HeritagePage.values)
            Expanded(
              child: Semantics(
                selected: page == target,
                button: true,
                child: InkWell(
                  onTap: () => navigate(target),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          target.icon,
                          color: target == page ? _terracotta : _muted,
                        ),
                        const SizedBox(height: 3),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              target.shortLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: target == page
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: target == page ? _terracotta : _muted,
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
        ],
      ),
    ),
  );
}

Widget _title(String text, {double size = 32, Color color = _terracotta}) =>
    Semantics(
      header: true,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: size,
          fontWeight: FontWeight.w700,
          height: 1.13,
          color: color,
        ),
      ),
    );

Widget _copy(String text, {Color color = _muted}) =>
    Text(text, style: TextStyle(fontSize: 16, height: 1.55, color: color));

Widget _heading(String label, String title, String copy, {double size = 36}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: _terracotta,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        _title(title, size: size),
        const SizedBox(height: 12),
        _copy(copy),
      ],
    );

Widget _section({required Widget child, Color? color, bool compact = false}) =>
    ColoredBox(
      color: color ?? _cream,
      child: LayoutBuilder(
        builder: (_, bounds) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1250),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: bounds.maxWidth < 600 ? 18 : 38,
                vertical: compact ? 22 : (bounds.maxWidth < 600 ? 28 : 52),
              ),
              child: SizedBox(width: double.infinity, child: child),
            ),
          ),
        ),
      ),
    );

Widget _columns(
  int maxColumns,
  List<Widget> children, {
  double minWidth = 240,
  double gap = 18,
}) => LayoutBuilder(
  builder: (_, bounds) {
    final columns = ((bounds.maxWidth + gap) / (minWidth + gap)).floor().clamp(
      1,
      maxColumns,
    );
    final width = (bounds.maxWidth - gap * (columns - 1)) / columns;
    return Wrap(
      spacing: gap,
      runSpacing: gap,
      children: [
        for (final child in children) SizedBox(width: width, child: child),
      ],
    );
  },
);

Widget _card(Widget child, {Color color = _paper, double padding = 18}) =>
    Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _line),
      ),
      child: child,
    );

Widget _photo(
  String asset,
  String description, {
  double ratio = 1.65,
  BoxFit fit = BoxFit.cover,
}) => ClipRRect(
  borderRadius: BorderRadius.circular(7),
  child: AspectRatio(
    aspectRatio: ratio,
    child: Image.asset(
      'assets/heritage/$asset',
      fit: fit,
      semanticLabel: description,
    ),
  ),
);

String _brochure(int number) =>
    'brochure-${number.toString().padLeft(2, '0')}.jpg';

Future<void> _openLink(BuildContext context, Uri uri) async {
  try {
    if (await launchUrl(uri)) return;
  } on Exception {
    // Offer visible feedback when the device has no matching app.
  }
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          uri.scheme == 'tel'
              ? 'Call ${uri.path} from your phone to arrange a visit.'
              : 'Could not open the directions link.',
        ),
      ),
    );
  }
}

Widget _call(BuildContext context, (String, String) phone) =>
    OutlinedButton.icon(
      onPressed: () => _openLink(context, Uri(scheme: 'tel', path: phone.$2)),
      icon: const Icon(Icons.call_outlined, size: 18),
      label: Text(phone.$1),
    );

Widget _directions(BuildContext context) => FilledButton.icon(
  onPressed: () => _openLink(
    context,
    Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': 'The Neelkanth Heritage, $_address',
    }),
  ),
  icon: const Icon(Icons.map_outlined, size: 18),
  label: const Text('Get Directions'),
);

void _visit(BuildContext context) => showDialog<void>(
  context: context,
  builder: (context) => AlertDialog(
    title: _title('Book a Site Visit', size: 26),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _copy(
            'Call the site office to arrange your visit or ask about pricing and availability.',
          ),
          const SizedBox(height: 12),
          _copy(_address),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final phone in _phones) _call(context, phone),
              _directions(context),
            ],
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Close'),
      ),
    ],
  ),
);

Widget _contact(BuildContext context) => _columns(
  2,
  [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(
          'Experience The Neelkanth Heritage',
          size: 33,
          color: Colors.white,
        ),
        const SizedBox(height: 12),
        _copy(
          'Visit the site to explore the residences and commercial spaces in person.',
          color: Colors.white,
        ),
      ],
    ),
    _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Nivaan Infra · Site Office', size: 21),
          const SizedBox(height: 8),
          _copy(_address),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final phone in _phones) _call(context, phone),
              _directions(context),
            ],
          ),
        ],
      ),
    ),
  ],
  minWidth: 365,
  gap: 32,
);

Future<void> _viewImages(
  BuildContext context,
  String title,
  List<String> images,
) => showDialog<void>(
  context: context,
  builder: (context) => _ImageViewer(title: title, images: images),
);

class _ImageViewer extends StatefulWidget {
  const _ImageViewer({required this.title, required this.images});

  final String title;
  final List<String> images;

  @override
  State<_ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<_ImageViewer> {
  int _index = 0;
  final _transformation = TransformationController();
  final _viewport = GlobalKey();
  static const _maxZoom = 5.0;
  static const _zoomStep = 1.5;

  void _zoom(double factor) {
    final size = _viewport.currentContext?.size;
    if (size == null) return;
    final center = size.center(Offset.zero);
    final anchor = _transformation.toScene(center);
    final scale = (_transformation.value.getMaxScaleOnAxis() * factor).clamp(
      1.0,
      _maxZoom,
    );
    final offset = center - anchor * scale;
    _transformation.value = Matrix4.diagonal3Values(scale, scale, 1)
      ..setTranslationRaw(
        offset.dx.clamp(size.width * (1 - scale), 0.0),
        offset.dy.clamp(size.height * (1 - scale), 0.0),
        0,
      );
  }

  @override
  void dispose() {
    _transformation.dispose();
    super.dispose();
  }

  void _show(int index) {
    setState(() {
      _index = index;
      _transformation.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) => Dialog.fullscreen(
    child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          tooltip: 'Close',
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          ListenableBuilder(
            listenable: _transformation,
            builder: (context, _) {
              final scale = _transformation.value.getMaxScaleOnAxis();
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Zoom out',
                    icon: const Icon(Icons.zoom_out),
                    onPressed: scale > 1 ? () => _zoom(1 / _zoomStep) : null,
                  ),
                  IconButton(
                    tooltip: 'Zoom in',
                    icon: const Icon(Icons.zoom_in),
                    onPressed: scale < _maxZoom ? () => _zoom(_zoomStep) : null,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox.expand(
                child: InteractiveViewer(
                  key: _viewport,
                  transformationController: _transformation,
                  minScale: 1,
                  maxScale: _maxZoom,
                  child: Image.asset(
                    'assets/heritage/${widget.images[_index]}',
                    fit: BoxFit.contain,
                    semanticLabel: '${widget.title}, image ${_index + 1}',
                  ),
                ),
              ),
            ),
            if (widget.images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _index == 0 ? null : () => _show(_index - 1),
                    tooltip: 'Previous page',
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text('${_index + 1} / ${widget.images.length}'),
                  IconButton(
                    onPressed: _index == widget.images.length - 1
                        ? null
                        : () => _show(_index + 1),
                    tooltip: 'Next page',
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}
