import 'package:base_frame/core/network/network_info.dart';
import 'package:base_frame/imports/core_imports.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/routes.dart';
import 'full_screen_error_contractor.dart';

@injectable
class FullScreenErrorBloc
    extends BaseBloc<FullScreenErrorEvent, FullScreenErrorData> {
  FullScreenErrorBloc(this._networkInfoImpl) : super(initState) {
    _checkInitialConnectivity();
    _observeNetworkChange();
  }

  Future<void> _checkInitialConnectivity() async {}

  final NetworkInfoImpl _networkInfoImpl;
  NetworkInfoImpl get networkInfo => _networkInfoImpl;

  static FullScreenErrorData get initState =>
      (FullScreenErrorDataBuilder()..state = ScreenState.content).build();



  void _observeNetworkChange() {
    _networkInfoImpl.onConnectivityChanged
        .listen((_) async {
          dispatchViewEvent(NavigateScreen(AppRoutes.networkRestored));
        })
        .bindToLifecycle(this);
  }
}
