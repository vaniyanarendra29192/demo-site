import 'base_localization.dart';

class EnglishLocalization extends AppLocalization {
  EnglishLocalization() : super(code: 'en', name: 'English');

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get noInternetSubtitle =>
      'It looks like you\'re offline. Connect to the internet to continue using the app.';

  @override
  String get connectionLostTitle => 'Oops! Connection Lost';

  @override
  String get somethingWentWrongDescription =>
      'We\'re experiencing a technical issue. Please try again later.';


  @override
  String get cancelApiRequestError => 'Request to API server was cancelled';

  @override
  String get connectionTimeoutApiRequestError =>
      'Connection timeout with API server';

  @override
  String get invalidStatusApiRequestError => 'Received invalid status code %s';

  @override
  String get somethingWentWrong => 'Something went wrong...';

  @override
  String get sessionExpired => 'Session Expired. Please login again.';

  @override
  String get somethingWentWrongPleaseTryAgain =>
      'Something went wrong. Please try again.';

  @override
  String get receiveTimeoutApiRequestError =>
      'Receive timeout in connection with API server';

  @override
  String get companyName => 'Karnavati Builder';

  @override
  String get retry => 'Retry';

  @override
  String get ok => 'Ok';

  @override
  String get done => 'Done';

  @override
  String get connectionError => 'Connection Error';
}
