import 'package:base_frame/imports/core_imports.dart';


class AppResumedBusEvent extends BusEvent {
  @override
  // ignore: hash_and_equals, avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    return other is AppResumedBusEvent;
  }
}

class ChangeCareProviderBusEvent extends BusEvent {
  @override
  // ignore: hash_and_equals, avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    return other is ChangeCareProviderBusEvent;
  }
}

class CancelBiometricSetupBusEvent extends BusEvent {
  @override
  // ignore: hash_and_equals, avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    return other is CancelBiometricSetupBusEvent;
  }
}
