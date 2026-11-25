// Keep the Material import consistent with the existing Flutter app.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu.dart';

const _cream = Color(0xfffdf9f1);
const _saffron = Color(0xffb45309);
const _emerald = Color(0xff064e3b);
const _gold = Color(0xfffde68a);
const _ink = Color(0xff1c1c17);
const _muted = Color(0xff564338);
const _phone = '919172157111';
const _displayPhone = '+91 91721 57111';
const _address =
    'Adarsh Tulip Sky View, 101 to 106, Pooja Farm Road, near Karnavati-6, '
    'New Narolgam, Ahmedabad, Gujarat 382405';
const _publicUrl = String.fromEnvironment('RAGHAV_PUBLIC_URL');
final _map = Uri.https('www.google.com', '/maps/search/', {
  'api': '1',
  'query': 'Raghav Restaurant & Banquet, $_address',
});
final _call = Uri(scheme: 'tel', path: '+$_phone');
Uri _chat([String? message]) =>
    Uri.https('wa.me', '/$_phone', message == null ? null : {'text': message});

Future<void> _open(BuildContext context, Uri uri) async {
  try {
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) return;
  } on Exception catch (error) {
    debugPrint('Could not open ${uri.scheme} link: $error');
  }
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open the link. Please try again.'),
      ),
    );
  }
}

enum _Page {
  home('Home', Icons.home_outlined),
  menu('Menu', Icons.menu_book_outlined),
  booking('Booking', Icons.calendar_month_outlined),
  banquet('Banquet', Icons.celebration_outlined),
  qr('QR', Icons.qr_code_scanner),
  contact('Contact', Icons.location_on_outlined);

  const _Page(this.label, this.icon);
  final String label;
  final IconData icon;
}

class RaghavApp extends StatelessWidget {
  const RaghavApp({super.key});

  static Route<void> _portalRoute(RouteSettings settings) =>
      MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => const _Portal(),
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Raghav Restaurant & Banquet',
    debugShowCheckedModeBanner: false,
    onGenerateRoute: _portalRoute,
    onGenerateInitialRoutes: (route) => [
      _portalRoute(RouteSettings(name: route)),
    ],
    theme: ThemeData(
      fontFamily: 'Plus Jakarta Sans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: _saffron,
        primary: _saffron,
        secondary: _emerald,
        surface: _cream,
      ),
      scaffoldBackgroundColor: _cream,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
  );
}

class _Portal extends StatefulWidget {
  const _Portal();

  @override
  State<_Portal> createState() => _PortalState();
}

class _PortalState extends State<_Portal> {
  static const _mobilePages = [
    _Page.home,
    _Page.menu,
    _Page.booking,
    _Page.banquet,
    _Page.qr,
  ];
  final _scroll = ScrollController();
  final _anchors = {for (final page in _Page.values) page: GlobalKey()};
  String? _table = Uri.tryParse(Uri.base.fragment)?.queryParameters['table'];
  late _Page _page = Uri.base.fragment.split('?').first == '/menu'
      ? _Page.menu
      : _Page.home;
  bool _wide = false;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _select(_Page page) {
    setState(() => _page = page);
    if (!_wide) {
      if (_scroll.hasClients) _scroll.jumpTo(0);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = _anchors[page]?.currentContext;
      if (mounted && target != null) {
        Scrollable.ensureVisible(
          target,
          duration: const Duration(milliseconds: 350),
        );
      }
    });
  }

  void _openTableMenu(String table) {
    _table = table;
    _select(_Page.menu);
  }

  Widget _section(_Page page, Widget child) =>
      KeyedSubtree(key: _anchors[page], child: child);

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 960;
    final changedToWide = wide && !_wide;
    _wide = wide;
    if (changedToWide && _page != _Page.home) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final target = _anchors[_page]?.currentContext;
        if (mounted && target != null) Scrollable.ensureVisible(target);
      });
    }

    final content = switch (_page) {
      _Page.home => _overview(false),
      _Page.menu => _MenuPanel(table: _table),
      _Page.booking => const _Booking(),
      _Page.banquet => const _Banquet(),
      _Page.qr => _QrPanel(openMenu: _openTableMenu),
      _Page.contact => const _Contact(),
    };

    return Scaffold(
      body: SafeArea(
        bottom: wide,
        child: Column(
          children: [
            _header(wide),
            Expanded(
              child: SingleChildScrollView(
                controller: _scroll,
                child: wide
                    ? Column(
                        children: [
                          _section(_Page.home, _overview(true)),
                          _section(
                            _Page.menu,
                            _MenuPanel(wide: true, table: _table),
                          ),
                          _section(_Page.booking, const _Booking(wide: true)),
                          _section(_Page.banquet, const _Banquet(wide: true)),
                          _section(
                            _Page.qr,
                            _QrPanel(wide: true, openMenu: _openTableMenu),
                          ),
                          _section(_Page.contact, const _Contact(wide: true)),
                          Container(
                            color: const Color(0xfff1ede6),
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            child: const Text(
                              'Raghav Restaurant & Banquet · Ahmedabad',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : content,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              height: 66,
              backgroundColor: _cream,
              selectedIndex: _page == _Page.contact
                  ? 4
                  : _mobilePages.indexOf(_page),
              onDestinationSelected: (index) => _select(_mobilePages[index]),
              destinations: [
                for (final page in _mobilePages)
                  NavigationDestination(
                    icon: Icon(page.icon),
                    label: page.label,
                  ),
              ],
            ),
    );
  }

  Widget _header(bool wide) => Material(
    color: _cream,
    elevation: 1,
    child: _Frame(
      padding: EdgeInsets.symmetric(horizontal: wide ? 28 : 14, vertical: 9),
      child: Column(
        children: [
          if (wide)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _address,
                      style: const TextStyle(color: _muted, fontSize: 12),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _select(_Page.qr),
                    icon: const Icon(Icons.qr_code, size: 16),
                    label: const Text('Tabletop QR'),
                  ),
                  TextButton.icon(
                    onPressed: () => _open(context, _chat()),
                    icon: const Icon(Icons.chat_outlined, size: 16),
                    label: const Text('WhatsApp'),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              InkWell(
                onTap: () => _select(_Page.home),
                borderRadius: BorderRadius.circular(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: _image('logo', width: 39, height: 39),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raghav Restaurant & Banquet',
                      maxLines: wide ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: wide ? 15 : 13,
                      ),
                    ),
                    const Text(
                      'FINE DINING & REGAL BANQUETS',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: .6,
                        color: _saffron,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              if (wide)
                for (final page in [
                  _Page.home,
                  _Page.menu,
                  _Page.banquet,
                  _Page.booking,
                  _Page.contact,
                ])
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: page == _page ? _saffron : null,
                      foregroundColor: page == _page ? Colors.white : _muted,
                    ),
                    onPressed: () => _select(page),
                    child: Text(switch (page) {
                      _Page.menu => 'Royal Menu',
                      _Page.banquet => 'Banquets & Events',
                      _Page.booking => 'Table Booking',
                      _Page.contact => 'Contact & Location',
                      _ => page.label,
                    }),
                  )
              else ...[
                IconButton(
                  tooltip: 'Tabletop QR',
                  onPressed: () => _select(_Page.qr),
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    color: _saffron,
                    size: 20,
                  ),
                ),
                IconButton(
                  tooltip: 'Call restaurant',
                  onPressed: () => _open(context, _call),
                  icon: const Icon(
                    Icons.call_outlined,
                    color: _emerald,
                    size: 20,
                  ),
                ),
                IconButton(
                  tooltip: 'WhatsApp',
                  onPressed: () => _open(context, _chat()),
                  icon: const Icon(
                    Icons.chat_outlined,
                    color: _emerald,
                    size: 20,
                  ),
                ),
              ],
            ],
          ),
          if (!wide)
            Container(
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: const Color(0xfff1ede6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: _saffron,
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Adarsh Tulip Sky View, Narolgam, Ahmedabad',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _open(context, _map),
                    child: const Text('Directions'),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );

  Widget _overview(bool wide) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if (!wide)
        _Frame(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: _Surface(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heading('Landmark Dining · Narolgam', size: 20),
                  const SizedBox(height: 6),
                  const Text(
                    _address,
                    style: TextStyle(fontSize: 12, color: _muted),
                  ),
                  Wrap(
                    spacing: 4,
                    children: [
                      TextButton.icon(
                        onPressed: () => _open(context, _map),
                        icon: const Icon(Icons.directions_outlined, size: 17),
                        label: const Text('Get Directions'),
                      ),
                      TextButton.icon(
                        onPressed: () => _open(context, _call),
                        icon: const Icon(Icons.call_outlined, size: 17),
                        label: const Text('Call Restaurant'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      _PhotoPanel(
        asset: wide ? 'hero' : 'mobile_hero',
        child: _Frame(
          padding: EdgeInsets.symmetric(
            horizontal: wide ? 36 : 20,
            vertical: wide ? 85 : 32,
          ),
          child: wide
              ? Row(
                  children: [
                    Expanded(flex: 7, child: _heroCopy(true)),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 3,
                      child: _PhotoPanel(
                        asset: 'banquet',
                        radius: 16,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 104, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _heading(
                                'Regal Banquet Hall',
                                size: 25,
                                color: Colors.white,
                              ),
                              const Text(
                                '500+ guest capacity',
                                style: TextStyle(color: _gold),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () => _select(_Page.banquet),
                                child: const Text('Explore the venue →'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : _heroCopy(false),
        ),
      ),
      _Frame(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ResponsiveCards(
              columns: wide ? 4 : 2,
              children: [
                for (final (label, icon, page)
                    in wide
                        ? [
                            ('100% Shuddh Veg', Icons.eco_outlined, _Page.menu),
                            (
                              '500+ Pax Banquet',
                              Icons.celebration_outlined,
                              _Page.banquet,
                            ),
                            (
                              'Valet Parking',
                              Icons.local_parking,
                              _Page.contact,
                            ),
                            ('Contactless QR', Icons.qr_code_scanner, _Page.qr),
                          ]
                        : [
                            (
                              'Digital Menu',
                              Icons.menu_book_outlined,
                              _Page.menu,
                            ),
                            (
                              'Reserve Table',
                              Icons.calendar_month_outlined,
                              _Page.booking,
                            ),
                            (
                              'Banquet Halls',
                              Icons.celebration_outlined,
                              _Page.banquet,
                            ),
                            ('Scan QR', Icons.qr_code_scanner, _Page.qr),
                          ])
                  _Surface(
                    child: InkWell(
                      onTap: () => _select(page),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(icon, color: _saffron),
                            const SizedBox(height: 9),
                            Text(
                              label,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Expanded(
                  child: _heading(
                    wide ? "Chef's Signature Showcase" : "Chef's Signatures",
                    size: wide ? 38 : 27,
                  ),
                ),
                TextButton(
                  onPressed: () => _select(_Page.menu),
                  child: Text(wide ? 'Explore Royal Menu →' : 'Full menu →'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _ResponsiveCards(
              columns: wide ? 3 : 1,
              children: [
                for (final (asset, name) in [
                  ('paneer', 'Raghav Special Paneer'),
                  ('sizzler', 'Raghav Special Sizzler'),
                  ('dum', 'Dum Biryani'),
                  ('tikka', 'Paneer Tikka Biryani'),
                  ('elixir', 'Raghav Royal Elixir'),
                  if (wide) ('cheese', 'Cheese Burst Paneer Sizzler'),
                ])
                  _DishCard(
                    dish: menu.values
                        .expand((dishes) => dishes)
                        .firstWhere((dish) => dish.name == name),
                    asset: asset,
                    stacked: wide,
                  ),
              ],
            ),
            if (!wide) ...[
              const SizedBox(height: 28),
              _PhotoPanel(
                asset: 'banquet',
                radius: 16,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _heading(
                        'Raghav Royal Banquet Hall',
                        size: 25,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      _action(
                        'Explore banquet',
                        Icons.celebration_outlined,
                        () => _select(_Page.banquet),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 25),
            TextButton.icon(
              onPressed: () => _select(_Page.contact),
              icon: const Icon(Icons.location_on_outlined),
              label: const Text('Visit Raghav Restaurant'),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _heroCopy(bool wide) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '●  100% SHUDDH SHAKAHARI · JAIN FRIENDLY',
        style: TextStyle(
          color: _gold,
          letterSpacing: 1,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 15),
      Text(
        'Atithi Devo Bhava',
        style: TextStyle(
          color: _gold,
          fontFamily: 'Playfair Display',
          fontStyle: FontStyle.italic,
          fontSize: wide ? 24 : 18,
        ),
      ),
      const SizedBox(height: 8),
      _heading(
        'Authentic Pure Vegetarian',
        size: wide ? 53 : 36,
        color: Colors.white,
      ),
      _heading(
        wide ? 'Fine Dine & Regal Banquets' : 'Fine Dine & Grand Celebrations',
        size: wide ? 38 : 24,
        color: _gold,
      ),
      const SizedBox(height: 14),
      const Text(
        'Savor artisanal paneer delicacies, hand-pounded spices and stately celebrations in Narolgam, Ahmedabad.',
        style: TextStyle(color: Colors.white, height: 1.6),
      ),
      const SizedBox(height: 20),
      Wrap(
        spacing: 9,
        runSpacing: 9,
        children: [
          _action(
            wide ? 'Reserve Table' : 'Book WhatsApp',
            Icons.calendar_month_outlined,
            () => _select(_Page.booking),
            color: wide ? _saffron : _emerald,
          ),
          _action(
            wide ? 'Explore Royal Menu' : 'Scan Table QR',
            wide ? Icons.menu_book_outlined : Icons.qr_code_scanner,
            () => _select(wide ? _Page.menu : _Page.qr),
            color: wide ? const Color(0xff51433a) : _saffron,
          ),
          if (wide)
            _action(
              'Tabletop QR',
              Icons.qr_code_scanner,
              () => _select(_Page.qr),
              color: _emerald,
            ),
        ],
      ),
      const SizedBox(height: 18),
      const Text(
        'Lunch 11:30 AM–3:30 PM  ·  Dinner 7–11 PM',
        style: TextStyle(color: _gold, fontSize: 12),
      ),
    ],
  );
}

Text _heading(String value, {double size = 30, Color color = _ink}) => Text(
  value,
  style: TextStyle(
    fontFamily: 'Playfair Display',
    fontSize: size,
    color: color,
    height: 1.12,
    fontWeight: FontWeight.w600,
  ),
);

Widget _image(String asset, {double? width, double? height}) => Image.asset(
  'assets/raghav/$asset.jpg',
  width: width,
  height: height,
  fit: BoxFit.cover,
);

Widget _action(
  String label,
  IconData icon,
  VoidCallback onPressed, {
  Color color = _saffron,
}) => FilledButton.icon(
  style: FilledButton.styleFrom(
    backgroundColor: color,
    foregroundColor: Colors.white,
  ),
  onPressed: onPressed,
  icon: Icon(icon, size: 18),
  label: Text(label),
);

class _Frame extends StatelessWidget {
  const _Frame({
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1280),
      child: Padding(padding: padding, child: child),
    ),
  );
}

class _Surface extends StatelessWidget {
  const _Surface({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    elevation: 1,
    shadowColor: const Color(0x22563b22),
    borderRadius: BorderRadius.circular(12),
    clipBehavior: Clip.antiAlias,
    child: child,
  );
}

class _PhotoPanel extends StatelessWidget {
  const _PhotoPanel({
    required this.asset,
    required this.child,
    this.radius = 0,
  });
  final String asset;
  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: Stack(
      children: [
        Positioned.fill(child: _image(asset)),
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xe51c1712), Color(0x882b1c13)],
              ),
            ),
          ),
        ),
        child,
      ],
    ),
  );
}

class _ResponsiveCards extends StatelessWidget {
  const _ResponsiveCards({required this.columns, required this.children});
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      const gap = 12.0;
      final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final child in children) SizedBox(width: width, child: child),
        ],
      );
    },
  );
}

class _DishCard extends StatelessWidget {
  const _DishCard({
    required this.dish,
    this.asset,
    this.stacked = false,
    this.table,
  });
  final Dish dish;
  final String? asset, table;
  final bool stacked;

  @override
  Widget build(BuildContext context) {
    final details = Padding(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heading(dish.name, size: 19),
          const SizedBox(height: 4),
          Text(
            dish.description,
            style: const TextStyle(color: _muted, fontSize: 12, height: 1.45),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: Text(
                  '₹${dish.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _saffron,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: _emerald),
                onPressed: () => _open(
                  context,
                  _chat(
                    'Hello Raghav Restaurant, I would like to order ${dish.name} (₹${dish.price}).'
                    '${table == null ? '' : ' Table: $table.'}',
                  ),
                ),
                icon: const Icon(Icons.chat_outlined, size: 15),
                label: const Text('Order'),
              ),
            ],
          ),
        ],
      ),
    );
    return _Surface(
      child: switch (asset) {
        null => details,
        final name when stacked => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_image(name, height: 188), details],
        ),
        final name => Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _image(name, width: 84, height: 92),
              ),
            ),
            Expanded(child: details),
          ],
        ),
      },
    );
  }
}

class _MenuPanel extends StatefulWidget {
  const _MenuPanel({this.wide = false, this.table});
  final bool wide;
  final String? table;

  @override
  State<_MenuPanel> createState() => _MenuPanelState();
}

class _MenuPanelState extends State<_MenuPanel> {
  String _query = '';
  String? _category;
  String? _spice;
  bool _signatures = false;

  @override
  Widget build(BuildContext context) {
    final results = {
      for (final entry in menu.entries)
        if (_category == null || _category == entry.key)
          entry.key: entry.value.where((dish) {
            final searchable = '${dish.name} ${dish.description}'.toLowerCase();
            return searchable.contains(_query) &&
                (_spice == null || dish.spice == _spice) &&
                (!_signatures || dish.signature);
          }).toList(),
    }..removeWhere((_, dishes) => dishes.isEmpty);

    return _Frame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heading('Royal Pure Vegetarian Menu', size: widget.wide ? 40 : 30),
          const SizedBox(height: 8),
          Text(
            widget.table == null
                ? 'Explore our kitchen’s specialties and order through WhatsApp.'
                : '${widget.table} · Your table is included when you order.',
          ),
          const SizedBox(height: 18),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search dishes',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) =>
                setState(() => _query = value.trim().toLowerCase()),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final category in <String?>[null, ...menu.keys])
                ChoiceChip(
                  label: Text(category ?? 'All categories'),
                  selected: _category == category,
                  onSelected: (selected) =>
                      setState(() => _category = selected ? category : null),
                ),
            ],
          ),
          const Divider(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              FilterChip(
                label: const Text('Signatures'),
                selected: _signatures,
                onSelected: (value) => setState(() => _signatures = value),
              ),
              for (final (label, value) in [
                ('Mild', 'mild'),
                ('Medium', 'medium'),
                ('Spicy', 'spicy'),
              ])
                FilterChip(
                  label: Text(label),
                  selected: _spice == value,
                  onSelected: (selected) =>
                      setState(() => _spice = selected ? value : null),
                ),
            ],
          ),
          if (results.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'No dishes match your search. Try another dish or filter.',
              ),
            ),
          for (final entry in results.entries) ...[
            const SizedBox(height: 24),
            _heading(entry.key, size: 24, color: _emerald),
            const SizedBox(height: 10),
            _ResponsiveCards(
              columns: widget.wide ? 3 : 1,
              children: [
                for (final dish in entry.value)
                  _DishCard(dish: dish, table: widget.table),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Booking extends StatefulWidget {
  const _Booking({this.wide = false});
  final bool wide;

  @override
  State<_Booking> createState() => _BookingState();
}

class _BookingState extends State<_Booking> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _notes = TextEditingController();
  DateTime _date = DateUtils.dateOnly(DateTime.now());
  bool _banquet = false;
  String? _time;
  String? _guests;
  String? _occasion;

  @override
  void dispose() {
    _name.dispose();
    _phoneNumber.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    final date = MaterialLocalizations.of(context).formatFullDate(_date);
    _open(
      context,
      _chat(
        [
          'Hello Raghav Restaurant, I would like to request a ${_banquet ? 'banquet' : 'table'} booking.',
          'Name: ${_name.text.trim()}',
          'Phone: ${_phoneNumber.text.trim()}',
          'Date: $date',
          'Time: $_time',
          'Guests: $_guests',
          if (_occasion != null) 'Occasion: $_occasion',
          if (_notes.text.trim().isNotEmpty)
            'Preferences: ${_notes.text.trim()}',
        ].join('\n'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final form = _Surface(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: false,
                    label: Text('Table'),
                    icon: Icon(Icons.restaurant_outlined),
                  ),
                  ButtonSegment(
                    value: true,
                    label: Text('Banquet'),
                    icon: Icon(Icons.celebration_outlined),
                  ),
                ],
                selected: {_banquet},
                onSelectionChanged: (selection) => setState(() {
                  _banquet = selection.first;
                  _time = null;
                  _guests = null;
                }),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter your name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneNumber,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone number'),
                validator: (value) {
                  final digits = (value ?? '').replaceAll(
                    RegExp(r'[^0-9]'),
                    '',
                  );
                  return digits.length < 10 || digits.length > 15
                      ? 'Enter a valid phone number'
                      : null;
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  final today = DateUtils.dateOnly(DateTime.now());
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _date.isBefore(today) ? today : _date,
                    firstDate: today,
                    lastDate: DateTime(today.year + 2, today.month, today.day),
                  );
                  if (mounted && date != null) setState(() => _date = date);
                },
                icon: const Icon(Icons.calendar_month_outlined),
                label: Text(
                  MaterialLocalizations.of(context).formatMediumDate(_date),
                ),
              ),
              const SizedBox(height: 12),
              _picker(
                'Time slot',
                _time,
                _banquet
                    ? ['Full day', 'Evening']
                    : [
                        '11:30 AM',
                        '12:30 PM',
                        '1:30 PM',
                        '7:00 PM',
                        '7:30 PM',
                        '8:30 PM',
                        '9:30 PM',
                      ],
                (value) => _time = value,
                required: true,
              ),
              const SizedBox(height: 12),
              _picker(
                'Guest count',
                _guests,
                _banquet
                    ? ['50–100', '150–250', '300–500', '500+']
                    : ['2', '4', '6', '8', '12', '20+'],
                (value) => _guests = value,
                required: true,
              ),
              const SizedBox(height: 12),
              _picker('Occasion (optional)', _occasion, [
                'Family gathering',
                'Birthday',
                'Anniversary',
                'Engagement',
                'Wedding',
                'Corporate event',
              ], (value) => _occasion = value),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notes,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Seating or dietary preferences (optional)',
                ),
              ),
              const SizedBox(height: 14),
              _action(
                'Send on WhatsApp',
                Icons.chat_outlined,
                _submit,
                color: _emerald,
              ),
            ],
          ),
        ),
      ),
    );
    final help = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _emerald,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heading('Raghav WhatsApp Desk', size: 24, color: Colors.white),
          const SizedBox(height: 8),
          const Text(
            'Send your preferred date and time. The restaurant will confirm availability over WhatsApp.',
            style: TextStyle(color: Colors.white, height: 1.5),
          ),
          const SizedBox(height: 12),
          _action(
            _displayPhone,
            Icons.call_outlined,
            () => _open(context, _call),
          ),
        ],
      ),
    );
    return _Frame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heading(
            widget.wide
                ? 'Book Your Royal Table or Banquet'
                : 'Instant WhatsApp Booking',
            size: widget.wide ? 40 : 30,
          ),
          const SizedBox(height: 16),
          if (widget.wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: form),
                const SizedBox(width: 22),
                Expanded(flex: 2, child: help),
              ],
            )
          else ...[
            form,
            const SizedBox(height: 12),
            help,
          ],
        ],
      ),
    );
  }

  Widget _picker(
    String label,
    String? current,
    List<String> values,
    ValueChanged<String?> update, {
    bool required = false,
  }) => DropdownButtonFormField<String>(
    key: ValueKey((label, required && _banquet)),
    initialValue: current,
    isExpanded: true,
    decoration: InputDecoration(labelText: label),
    items: [
      for (final value in values)
        DropdownMenuItem(value: value, child: Text(value)),
    ],
    onChanged: (value) => setState(() => update(value)),
    validator: required
        ? (value) => value == null ? 'Choose a ${label.toLowerCase()}' : null
        : null,
  );
}

class _Banquet extends StatelessWidget {
  const _Banquet({this.wide = false});
  final bool wide;

  @override
  Widget build(BuildContext context) => _Frame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _heading(
          wide ? 'Stately Banquet Facilities' : 'Grand Banquet Hall',
          size: wide ? 40 : 30,
        ),
        const SizedBox(height: 8),
        const Text('500+ guests · Pure vegetarian catering · Valet parking'),
        const SizedBox(height: 16),
        _PhotoPanel(
          asset: 'banquet',
          radius: 16,
          child: Padding(
            padding: EdgeInsets.fromLTRB(22, wide ? 160 : 120, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heading(
                  'Pillarless Grand Ballroom',
                  color: Colors.white,
                  size: wide ? 34 : 26,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Weddings, receptions, family celebrations and corporate gatherings.',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                _action(
                  'Enquire on WhatsApp',
                  Icons.chat_outlined,
                  () => _open(
                    context,
                    _chat(
                      'Hello Raghav Banquet, I would like to inquire about hall availability and packages.',
                    ),
                  ),
                  color: _emerald,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        _ResponsiveCards(
          columns: wide ? 2 : 1,
          children: [
            for (final (title, description, icon) in [
              (
                'Weddings & Sagai',
                'Host your ceremony or reception with a curated vegetarian banquet menu.',
                Icons.favorite_border,
              ),
              (
                'Corporate Galas & AGMs',
                'Arrange an event with seating, catering and space for your guests.',
                Icons.groups_outlined,
              ),
            ])
              _Surface(
                child: ListTile(
                  leading: Icon(icon, color: _saffron),
                  title: Text(title),
                  subtitle: Text(description),
                  onTap: () => _open(
                    context,
                    _chat(
                      'Hello Raghav Banquet, I would like to enquire about $title.',
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_outward),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

class _QrPanel extends StatefulWidget {
  const _QrPanel({required this.openMenu, this.wide = false});
  final ValueChanged<String> openMenu;
  final bool wide;

  @override
  State<_QrPanel> createState() => _QrPanelState();
}

class _QrPanelState extends State<_QrPanel> {
  static final _tableLabels = [
    for (final number in [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      14,
      15,
      16,
      17,
      18,
    ])
      'Table ${number.toString().padLeft(2, '0')}',
    'Banquet VIP Lounge',
  ];
  String _table = 'Table 03';

  Uri? get _menuUrl {
    final base = Uri.tryParse(
      _publicUrl.isEmpty ? Uri.base.toString() : _publicUrl,
    );
    if (base == null ||
        !['http', 'https'].contains(base.scheme) ||
        base.host.isEmpty ||
        ['localhost', '127.0.0.1', '::1'].contains(base.host)) {
      return null;
    }
    return base.replace(
      fragment: '/menu?table=${Uri.encodeQueryComponent(_table)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final url = _menuUrl;
    final code = _Surface(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            _heading('Digital Table QR', size: 25),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _table,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Select your table'),
              items: [
                for (final table in _tableLabels)
                  DropdownMenuItem(value: table, child: Text(table)),
              ],
              onChanged: (table) {
                if (table != null) setState(() => _table = table);
              },
            ),
            const SizedBox(height: 12),
            if (url != null)
              Semantics(
                label: 'Menu QR code for $_table',
                child: QrImageView(
                  data: url.toString(),
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              )
            else
              const Text(
                'Table QR codes are available on the hosted portal.',
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 12),
            _action(
              'Open Digital Menu',
              Icons.menu_book_outlined,
              () => widget.openMenu(_table),
            ),
          ],
        ),
      ),
    );
    final instructions = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(
          widget.wide
              ? 'Contactless Tabletop QR Dining System'
              : 'Tabletop Concierge',
          size: widget.wide ? 40 : 30,
          color: _gold,
        ),
        const SizedBox(height: 12),
        const Text(
          'Scan the tabletop code with your phone camera, browse the digital menu, then place your order on WhatsApp.',
          style: TextStyle(color: Colors.white, height: 1.6),
        ),
        const SizedBox(height: 16),
        _action(
          'Call restaurant',
          Icons.call_outlined,
          () => _open(context, _call),
        ),
        const SizedBox(height: 12),
        _action(
          'Get directions',
          Icons.directions_outlined,
          () => _open(context, _map),
          color: const Color(0xff006c4e),
        ),
      ],
    );
    return ColoredBox(
      color: _emerald,
      child: _Frame(
        child: widget.wide
            ? Row(
                children: [
                  Expanded(child: instructions),
                  const SizedBox(width: 32),
                  Expanded(child: code),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [instructions, const SizedBox(height: 18), code],
              ),
      ),
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact({this.wide = false});
  final bool wide;

  @override
  Widget build(BuildContext context) => _Frame(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _heading(
          wide ? 'Visit Us or Plan Route' : 'Find Raghav Restaurant',
          size: wide ? 40 : 30,
        ),
        const SizedBox(height: 16),
        _ResponsiveCards(
          columns: wide ? 2 : 1,
          children: [
            _Surface(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading('Exact Address', size: 23),
                    const SizedBox(height: 8),
                    const Text(_address),
                    const SizedBox(height: 16),
                    _heading('Operating Hours', size: 23),
                    const SizedBox(height: 8),
                    const Text(
                      'Lunch 11:30 AM–3:30 PM\nDinner 7:00 PM–11:00 PM',
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _action(
                          _displayPhone,
                          Icons.call_outlined,
                          () => _open(context, _call),
                        ),
                        _action(
                          'WhatsApp',
                          Icons.chat_outlined,
                          () => _open(context, _chat()),
                          color: _emerald,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _PhotoPanel(
              asset: 'map',
              radius: 12,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 135, 18, 18),
                child: _action(
                  'Open in Google Maps',
                  Icons.directions_outlined,
                  () => _open(context, _map),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
