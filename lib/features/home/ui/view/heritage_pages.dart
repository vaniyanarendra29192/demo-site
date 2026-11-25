part of 'home_screen.dart';

List<Widget> _overview(
  BuildContext context,
  bool phone,
  void Function(HeritagePage, {String? plan}) navigate,
) {
  final actions = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      FilledButton.icon(
        onPressed: () => _visit(context),
        icon: const Icon(Icons.calendar_month_outlined, size: 18),
        label: Text(phone ? 'Book a Visit' : 'Schedule a Site Visit'),
      ),
      OutlinedButton.icon(
        style: phone ? OutlinedButton.styleFrom(backgroundColor: _paper) : null,
        onPressed: () => _viewImages(context, 'Project Brochure', [
          for (var page = 1; page <= 12; page++) _brochure(page),
        ]),
        icon: const Icon(Icons.menu_book_outlined, size: 18),
        label: const Text('View Brochure'),
      ),
    ],
  );
  return [
    _section(
      compact: phone,
      child: phone
          ? _mobileHero(actions)
          : _split(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heading(
                    '2 & 3 BHK residences · Narol, Ahmedabad',
                    'The Divine\nElegance',
                    'Heritage-inspired residences and high-street shops, with private balconies and a landscaped central courtyard.',
                    size: 61,
                  ),
                  const SizedBox(height: 22),
                  actions,
                ],
              ),
              _photo(
                'entrance.jpg',
                'Architectural render of the entrance gate',
                ratio: 1.43,
              ),
              firstFlex: 4,
              secondFlex: 6,
            ),
    ),
    _section(
      compact: true,
      child: _stats(const [
        ('4', 'Residential blocks'),
        ('11', 'Storeys'),
        ('161', 'Homes'),
        ('35', 'Commercial shops'),
      ]),
    ),
    _section(
      color: _paper,
      child: phone
          ? _mobileHighlights()
          : _split(
              _photo('courtyard.jpg', 'Landscaped courtyard and clubhouse'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heading(
                    'Architecture & lifestyle',
                    'Crafted for Everyday Living',
                    'Terracotta details, balconies and a landscaped courtyard bring character and open space to the development.',
                  ),
                  const SizedBox(height: 20),
                  _columns(2, [
                    _feature(
                      Icons.apartment,
                      'Heritage Elevation',
                      'A terracotta-inspired architectural façade.',
                    ),
                    _feature(
                      Icons.balcony_outlined,
                      'Balcony in Every Flat',
                      'Private outdoor space in every residence.',
                    ),
                    _feature(
                      Icons.explore_outlined,
                      'Vastu Compliant',
                      'Vastu-aligned residences and site layout.',
                    ),
                    _feature(
                      Icons.videocam_outlined,
                      '24×7 CCTV',
                      'A monitored entry with a security cabin.',
                    ),
                  ], minWidth: 138),
                ],
              ),
            ),
    ),
    _section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heading(
            'Residences & commercial',
            'Find Your Floor Plan',
            'Explore the 2 BHK and 3 BHK homes and the ground-floor shops.',
          ),
          const SizedBox(height: 22),
          _columns(3, [
            _overviewPlan(
              '2 BHK Residences',
              'Blocks A, B, C & D',
              'Two-bedroom homes with a private balcony.',
              () => navigate(HeritagePage.plans, plan: '2bhk-ab'),
            ),
            _overviewPlan(
              '3 BHK Residences',
              'Blocks A & B',
              'Three bedrooms with a dedicated living and dining layout.',
              () => navigate(HeritagePage.plans, plan: '3bhk'),
            ),
            _overviewPlan(
              '35 Commercial Shops',
              'Ground floor',
              'Street-facing retail on the development’s frontage.',
              () => navigate(HeritagePage.plans, plan: 'commercial'),
            ),
          ]),
        ],
      ),
    ),
    _section(
      color: _paper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Everything Within Reach'),
          const SizedBox(height: 16),
          _stats(const [
            ('0.5 km', 'Hospital'),
            ('1 km', 'Education campus'),
            ('2 km', 'S.P. Ring Road approach'),
            ('3.5 km', 'Maninagar railway station'),
          ]),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => navigate(HeritagePage.location),
            child: const Text('Explore the Location'),
          ),
        ],
      ),
    ),
  ];
}

Widget _mobileHero(Widget actions) => LayoutBuilder(
  builder: (context, bounds) {
    final textScale = MediaQuery.textScalerOf(context).scale(32) / 32;
    final showFullPhoto =
        Theme.of(context).platform == TargetPlatform.android &&
        bounds.maxWidth < 360 * textScale;
    final content = Padding(
      padding: EdgeInsets.fromLTRB(16, showFullPhoto ? 16 : 118, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _badge('2 & 3 BHK flats & shops · Narol'),
          const SizedBox(height: 12),
          _title(
            'The Divine Elegance of Modern Heritage Living',
            size: 32,
            color: showFullPhoto ? _terracotta : Colors.white,
          ),
          const SizedBox(height: 18),
          actions,
        ],
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: showFullPhoto
          ? ColoredBox(
              color: _paper,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1632 / 861,
                    child: Image.asset(
                      'assets/heritage/entrance.jpg',
                      fit: BoxFit.contain,
                      semanticLabel:
                          'Architectural render of the entrance gate',
                    ),
                  ),
                  content,
                ],
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/heritage/entrance.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                    semanticLabel: 'Architectural render of the entrance gate',
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: .9),
                        ],
                      ),
                    ),
                  ),
                ),
                content,
              ],
            ),
    );
  },
);

Widget _mobileHighlights() => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    _title('Architectural Highlights', size: 27),
    const SizedBox(height: 16),
    LayoutBuilder(
      builder: (_, bounds) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (asset, title, description) in const [
              (
                'entrance.jpg',
                'Grand Entrance Gate',
                'A dedicated entrance with a security cabin and CCTV.',
              ),
              (
                'elevation.jpg',
                'Heritage Elevation',
                'A terracotta-inspired architectural façade.',
              ),
              (
                'balconies.jpg',
                'Balcony in Every Flat',
                'Private outdoor space in every residence.',
              ),
              (
                'courtyard.jpg',
                'Clubhouse & Garden',
                'A landscaped courtyard for residents.',
              ),
            ])
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  width: (bounds.maxWidth * .78).clamp(0, 280).toDouble(),
                  child: _card(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _photo(asset, title),
                        const SizedBox(height: 12),
                        _title(title, size: 19),
                        const SizedBox(height: 6),
                        _copy(description),
                      ],
                    ),
                    padding: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  ],
);

Widget _split(
  Widget first,
  Widget second, {
  int firstFlex = 1,
  int secondFlex = 1,
}) => LayoutBuilder(
  builder: (_, bounds) => bounds.maxWidth < 735
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [first, const SizedBox(height: 22), second],
        )
      : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: firstFlex, child: first),
            const SizedBox(width: 30),
            Expanded(flex: secondFlex, child: second),
          ],
        ),
);

Widget _badge(String text) => DecoratedBox(
  decoration: BoxDecoration(
    color: _gold,
    borderRadius: BorderRadius.circular(4),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    child: Text(
      text,
      style: const TextStyle(
        color: _ink,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);

Widget _stats(List<(String, String)> stats) => _columns(
  4,
  [
    for (final (value, label) in stats)
      _card(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(value, size: 25),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontSize: 14, color: _muted)),
          ],
        ),
        padding: 14,
      ),
  ],
  minWidth: 120,
  gap: 10,
);

Widget _feature(IconData icon, String title, String description) => _card(
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: _terracotta),
      const SizedBox(height: 8),
      _title(title, size: 19),
      const SizedBox(height: 6),
      _copy(description),
    ],
  ),
  padding: 14,
);

Widget _overviewPlan(
  String title,
  String badge,
  String description,
  VoidCallback open,
) => _card(
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _badge(badge),
      const SizedBox(height: 12),
      _title(title, size: 22),
      const SizedBox(height: 8),
      _copy(description),
      const SizedBox(height: 14),
      OutlinedButton(onPressed: open, child: const Text('View Floor Plan')),
    ],
  ),
);

const _plans = [
  (
    id: '3bhk',
    title: '3 BHK Grand Residence',
    group: '3 BHK · Blocks A & B',
    pages: [8],
    dimensions: [
      ('Drawing room', '10′ × 16′'),
      ('Kitchen / dining', '9′ × 15′ 1½″'),
      ('Bedroom 1', '10′ × 10′'),
      ('Bedroom 2', '12′ × 10′'),
      ('Bedroom 3', '14′ × 10′'),
      ('Balcony', '10′ × 3′ 4½″'),
    ],
  ),
  (
    id: '2bhk-ab',
    title: '2 BHK Residence',
    group: '2 BHK · Blocks A & B',
    pages: [9],
    dimensions: [
      ('Drawing room', '10′ × 16′'),
      ('Kitchen / dining', '8′ × 15′ 1½″'),
      ('Bedroom 1', '10′ × 10′'),
      ('Bedroom 2', '10′ × 13′ 6″'),
      ('Balcony', '10′ × 3′ 4½″'),
    ],
  ),
  (
    id: '2bhk-cd',
    title: '2 BHK Residence',
    group: '2 BHK · Blocks C & D',
    pages: [10],
    dimensions: [
      ('Drawing room', '15′ 3″ × 10′'),
      ('Kitchen / dining', '12′ 7½″ × 8′'),
      ('Bedroom 1', '10′ × 10′'),
      ('Bedroom 2', '13′ 4½″ × 10′'),
    ],
  ),
  (
    id: 'typical',
    title: 'Typical Floor Layout',
    group: 'Typical floor',
    pages: [7],
    dimensions: <(String, String)>[],
  ),
  (
    id: 'commercial',
    title: 'Commercial & Site Layout',
    group: 'Commercial',
    pages: [5, 6],
    dimensions: <(String, String)>[],
  ),
];

List<Widget> _floorPlans(
  BuildContext context,
  int selected,
  ValueChanged<int> select,
) {
  final plan = _plans[selected];
  final images = plan.pages.map(_brochure).toList();
  void open() => _viewImages(context, plan.title, images);
  return [
    _section(
      child: _heading(
        'Residences & commercial',
        'Architectural Layouts & Floor Plans',
        'Compare unit plans and furnished section views, or explore the typical floor and commercial layouts.',
      ),
    ),
    _section(
      compact: true,
      color: _paper,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 9,
            runSpacing: 8,
            children: [
              for (final (index, item) in _plans.indexed)
                ChoiceChip(
                  showCheckmark: false,
                  selected: index == selected,
                  selectedColor: _gold,
                  label: Text(item.group),
                  onSelected: (_) {
                    if (index != selected) select(index);
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          _badge(plan.group),
          const SizedBox(height: 10),
          _title(plan.title),
          const SizedBox(height: 20),
          _split(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _planImage(images.first, plan.title, open),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: open,
                  icon: const Icon(Icons.zoom_in),
                  label: const Text('Open Full-size Plan'),
                ),
              ],
            ),
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(
                    plan.dimensions.isEmpty
                        ? 'Layout Details'
                        : 'Room Dimensions',
                    size: 23,
                  ),
                  const SizedBox(height: 10),
                  if (plan.dimensions.isEmpty)
                    _copy(
                      plan.id == 'commercial'
                          ? 'Compare the ground-floor and first-floor layouts. Open the plan to zoom in and switch between levels.'
                          : 'Open the plan to review the typical arrangement of homes across all four blocks.',
                    )
                  else
                    for (final (room, dimensions) in plan.dimensions)
                      _detailRow(room, dimensions),
                  const SizedBox(height: 14),
                  FilledButton(
                    onPressed: () => _visit(context),
                    child: const Text('Book a Site Visit'),
                  ),
                ],
              ),
            ),
            firstFlex: 6,
            secondFlex: 4,
          ),
        ],
      ),
    ),
    _section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Explore Other Layouts'),
          const SizedBox(height: 18),
          _columns(4, [
            for (final (index, item) in _plans.indexed)
              if (index != selected)
                _card(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _planImage(
                        _brochure(item.pages.first),
                        item.group,
                        () => _viewImages(
                          context,
                          item.title,
                          item.pages.map(_brochure).toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _title(item.group, size: 18),
                      TextButton(
                        onPressed: () => _viewImages(
                          context,
                          item.title,
                          item.pages.map(_brochure).toList(),
                        ),
                        child: const Text('Preview Layout'),
                      ),
                    ],
                  ),
                ),
          ], minWidth: 185),
        ],
      ),
    ),
  ];
}

Widget _planImage(String asset, String title, VoidCallback open) => ClipRRect(
  borderRadius: BorderRadius.circular(7),
  child: Stack(
    children: [
      _photo(asset, title, ratio: 1.34, fit: BoxFit.contain),
      Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: Tooltip(
            message: 'Zoom in on $title',
            child: InkWell(onTap: open),
          ),
        ),
      ),
    ],
  ),
);

Widget _detailRow(String title, String value) => Container(
  decoration: const BoxDecoration(
    border: Border(bottom: BorderSide(color: _line)),
  ),
  padding: const EdgeInsets.symmetric(vertical: 11),
  child: Row(
    children: [
      Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
      const SizedBox(width: 10),
      Flexible(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: const TextStyle(
            color: _terracotta,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  ),
);

const _amenityItems = [
  (Icons.fence, 'Entrance Gate', 'A dedicated entry into the development.'),
  (
    Icons.videocam_outlined,
    '24×7 CCTV',
    'Camera surveillance for shared spaces.',
  ),
  (
    Icons.security_outlined,
    'Security Cabin',
    'A staffed point for entry management.',
  ),
  (
    Icons.self_improvement,
    'Meditation Area',
    'A quiet outdoor space for relaxation.',
  ),
  (
    Icons.groups_outlined,
    'Clubhouse & Society Office',
    'Common spaces for residents and the society.',
  ),
  (
    Icons.event_seat_outlined,
    'Senior Citizen Sit-outs',
    'Seating areas for older residents.',
  ),
  (
    Icons.explore_outlined,
    'Vastu-compliant Flats',
    'Homes arranged with Vastu guidelines in mind.',
  ),
  (Icons.child_care, 'Children’s Play Area', 'A dedicated space for play.'),
  (
    Icons.elevator_outlined,
    'Two Lifts per Block',
    'Lift access in each residential block.',
  ),
  (Icons.solar_power_outlined, 'Solar System', 'On-site solar provision.'),
  (Icons.wc, 'Common Toilets', 'Shared facilities within the development.'),
  (
    Icons.local_fire_department_outlined,
    'Fire Safety',
    'Fire-safety provision.',
  ),
  (
    Icons.local_parking,
    'Allotted Car Parking',
    'Basement and allotted parking.',
  ),
  (
    Icons.grid_view_outlined,
    'Vastu-compliant Layout',
    'A Vastu-aligned development layout.',
  ),
  (
    Icons.chair_outlined,
    'Sit-outs with Planters',
    'Seating integrated with landscaping.',
  ),
  (
    Icons.park_outlined,
    'Landscaped Garden',
    'A green courtyard at the center of the site.',
  ),
  (
    Icons.directions_bus_outlined,
    'Pick-up & Drop-off Zone',
    'A designated arrival and departure area.',
  ),
  (
    Icons.directions_run,
    'Jogging & Walking Track',
    'A route for daily walks and runs.',
  ),
  (
    Icons.local_gas_station_outlined,
    'Adani Gas Provision',
    'Provision for piped gas.',
  ),
  (Icons.two_wheeler, 'Two-wheeler Parking', 'Dedicated two-wheeler spaces.'),
  (Icons.accessible, 'Accessible Ramp', 'Ramp access at the development.'),
];

List<Widget> _amenities(BuildContext context) => [
  _section(
    child: _heading(
      'Amenities & lifestyle',
      'Spaces for Everyday Living',
      'A landscaped courtyard, clubhouse and shared outdoor spaces sit at the heart of The Neelkanth Heritage.',
    ),
  ),
  _section(
    compact: true,
    child: _split(
      _photo(
        'courtyard.jpg',
        'The landscaped courtyard and clubhouse',
        ratio: 1.62,
      ),
      _card(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _photo('clubhouse.jpg', 'The clubhouse pavilion', ratio: 1.85),
            const SizedBox(height: 12),
            _title('The Clubhouse Pavilion', size: 24),
            const SizedBox(height: 8),
            _copy(
              'A gathering space for residents, opening onto the central garden.',
            ),
          ],
        ),
      ),
      firstFlex: 6,
      secondFlex: 4,
    ),
  ),
  _section(
    color: _paper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('All Amenities'),
        const SizedBox(height: 18),
        _columns(
          4,
          [
            for (final (icon, title, description) in _amenityItems)
              _feature(icon, title, description),
          ],
          minWidth: 142,
          gap: 12,
        ),
      ],
    ),
  ),
  _section(
    child: _split(
      _photo('elevation.jpg', 'Residential elevation and street-facing shops'),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('35 High-street Shops'),
          const SizedBox(height: 10),
          _copy(
            'Street-facing commercial spaces bring shopping and daily needs to the ground floor.',
          ),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: () =>
                AutoRouter.of(context)
                    .navigatePath('/floor-plans?unit=commercial'),
            child: const Text('View Commercial Layout'),
          ),
        ],
      ),
    ),
  ),
];

const _distances = [
  ('Hospital', '0.5 km'),
  ('Education campus', '1 km'),
  ('D-Mart', '2 km'),
  ('S.P. Ring Road approach', '2 km'),
  ('Lambha Temple', '2.5 km'),
  ('Maninagar railway station', '3.5 km'),
  ('Metro station', '5.5 km'),
  ('Baroda Express Highway', '7 km'),
  ('International airport', '11 km'),
];

List<Widget> _location(BuildContext context) => [
  _section(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading(
          'Narol, Ahmedabad',
          'Effortlessly Connected',
          'On the 100 Ft Road behind Pooja Farm, close to schools, shopping and major roads connecting Narol to the rest of Ahmedabad.',
        ),
        const SizedBox(height: 20),
        _stats(const [
          ('0.5 km', 'Hospital'),
          ('2 km', 'S.P. Ring Road approach'),
          ('11 km', 'International airport'),
          ('100 ft', 'Frontage road'),
        ]),
      ],
    ),
  ),
  _section(
    color: _paper,
    child: _split(
      _card(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Project Location Map', size: 24),
            const SizedBox(height: 14),
            _photo(
              'location.png',
              'Site map from the project brochure',
              ratio: 1.16,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _directions(context),
                OutlinedButton.icon(
                  onPressed: () => _viewImages(
                    context,
                    'Project Location Map',
                    ['location.png'],
                  ),
                  icon: const Icon(Icons.zoom_in),
                  label: const Text('Enlarge Map'),
                ),
              ],
            ),
          ],
        ),
      ),
      _card(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Connectivity & Landmarks', size: 24),
            const SizedBox(height: 12),
            for (final (name, distance) in _distances)
              _detailRow(name, distance),
            const SizedBox(height: 10),
            _copy('Approximate distances from the project brochure.'),
          ],
        ),
      ),
    ),
  ),
  _section(
    child: _columns(3, [
      _feature(
        Icons.school_outlined,
        'Education',
        'An education campus is listed 1 km from the project.',
      ),
      _feature(
        Icons.shopping_bag_outlined,
        'Shopping',
        'D-Mart and the project’s own shops serve daily needs.',
      ),
      _feature(
        Icons.train_outlined,
        'Transit',
        'The project is near Maninagar railway station, a metro station and major road links.',
      ),
    ]),
  ),
];

const _specItems = [
  (
    Icons.foundation,
    'Structure & Foundation',
    'Earthquake-resistant reinforced concrete frame, as specified in the brochure.',
  ),
  (
    Icons.grid_on,
    'Vitrified Flooring',
    'Vitrified tiles throughout the apartments.',
  ),
  (
    Icons.format_paint_outlined,
    'Wall Finish & Elevation',
    'Internal plaster with white finish putty and double-coat sand-face plaster on the exterior.',
  ),
  (
    Icons.window_outlined,
    'Doors & Windows',
    'Decorative main door, flush internal doors and aluminum windows with granite frames.',
  ),
  (
    Icons.countertops_outlined,
    'Granite Platform Kitchen',
    'Mirror-polished granite platform, stainless steel sink and glazed wall tiles to lintel level.',
  ),
  (
    Icons.electrical_services,
    'Electrification',
    'Branded ISI modular switches, concealed copper wiring and an MCB distribution panel.',
  ),
  (
    Icons.plumbing,
    'Plumbing & Drainage',
    'ISI CPVC and UPVC pipes for water supply, with PVC and SWR pipes for waste and drainage.',
  ),
  (
    Icons.bathtub_outlined,
    'Bathrooms & Toilets',
    'Designer tiles to lintel level, with branded sanitaryware and bath fittings.',
  ),
  (
    Icons.roofing,
    'Terrace Thermal Protection',
    'Brick-bat concrete with china mosaic for heat reflection and thermal insulation.',
  ),
];

List<Widget> _specifications(BuildContext context) => [
  _section(
    child: _split(
      _heading(
        'Building standards',
        'Architectural Specifications & Material Quality',
        'Review the finishes, fixtures and construction features listed in the project brochure.',
      ),
      _photo(
        'balconies.jpg',
        'Heritage façade and apartment balconies at dusk',
        ratio: 1.8,
      ),
    ),
  ),
  _section(
    color: _paper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Standard Specifications'),
        const SizedBox(height: 18),
        _columns(3, [
          for (final (icon, title, description) in _specItems)
            _feature(icon, title, description),
        ], minWidth: 220),
      ],
    ),
  ),
  _section(
    child: _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Architectural & Legal Advisory', size: 27),
          const SizedBox(height: 10),
          _copy(
            'Refer to the project brochure for the developer’s specifications and terms. Contact the site office for the current project documents.',
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _viewImages(
              context,
              'Specifications & Brochure Terms',
              [_brochure(12)],
            ),
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('View Brochure Terms'),
          ),
        ],
      ),
    ),
  ),
];
