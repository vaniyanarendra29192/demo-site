import 'dart:js_interop';

import 'package:flutter/widgets.dart';

@JS('requestSoftLanceFrame')
external set _requestSoftLanceFrame(JSFunction callback);

void registerBrowserResume() {
  _requestSoftLanceFrame = ((JSFunction complete) {
    final binding = WidgetsBinding.instance;
    binding.addPostFrameCallback((_) => complete.callAsFunction());
    binding.scheduleForcedFrame();
  }).toJS;
}
