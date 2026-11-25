# the_neelkanth_heritage

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Raghav Restaurant & Banquet

The Raghav portal uses `lib/raghav_main.dart`. Run it in Chrome and resize
the browser or use Chrome's device toolbar to preview the mobile layout.
The desktop portal starts at 960 logical pixels.

```sh
flutter run -d chrome -t lib/raghav_main.dart
flutter build web -t lib/raghav_main.dart --output build/raghav
```

On a hosted site, each table QR opens the menu with its table number. The
portal uses the current hosted address by default. To use a specific public
address, add `--dart-define=RAGHAV_PUBLIC_URL=https://your-domain.example/`
when building. Localhost previews can open the digital menu directly from the
QR screen.

Bookings and orders open a prefilled WhatsApp message addressed to the
number on the Stitch booking screen, +91 91721 57111.

### Firebase Hosting

Raghav has a dedicated Hosting site in Firebase project
`your-business-name-e8ad6`. To rebuild and deploy it, run:

```sh
firebase deploy --only hosting --project your-business-name-e8ad6
```
