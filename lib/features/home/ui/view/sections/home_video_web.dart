import 'dart:js_interop';

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

class HomeVideo extends StatefulWidget {
  const HomeVideo({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<HomeVideo> createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  web.HTMLDivElement? _background;
  web.HTMLVideoElement? _video;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updatePlayback);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final video = web.HTMLVideoElement()
        ..defaultMuted = true
        ..muted = true
        ..loop = true
        ..playsInline = true
        ..preload = 'none';
      final background = web.HTMLDivElement()
        ..className = 'site-home-background'
        ..setAttribute('aria-hidden', 'true')
        ..append(video);
      _background = background;
      _video = video;
      web.document.body?.prepend(background);
      _updatePlayback();
    });
  }

  @override
  void didUpdateWidget(HomeVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController == widget.scrollController) return;
    oldWidget.scrollController.removeListener(_updatePlayback);
    widget.scrollController.addListener(_updatePlayback);
    _updatePlayback();
  }

  void _updatePlayback() {
    final video = _video;
    if (video == null) return;
    final scroll = widget.scrollController;
    final visible =
        !scroll.hasClients ||
        !scroll.position.hasViewportDimension ||
        scroll.offset < scroll.position.viewportDimension;
    if (visible == _playing) return;
    _playing = visible;
    if (visible) {
      _play(video);
    } else {
      video.pause();
    }
  }

  Future<void> _play(web.HTMLVideoElement video) async {
    if (!video.hasAttribute('src')) {
      video.src = 'media/home-background.mp4';
    }
    try {
      await video.play().toDart;
    } catch (_) {
      // Autoplay may be blocked, or scrolling or navigation may cancel play.
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updatePlayback);
    final video = _video;
    video?.pause();
    video?.removeAttribute('src');
    video?.load();
    _background?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}
