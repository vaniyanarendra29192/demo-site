// ignore: avoid_classes_with_only_static_members
abstract class RegExps {
  static final RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp phoneNumber = RegExp(r'(^[0-9]{6,14}$)');
  static final RegExp password = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z].*[a-z].*[a-z])(?=.*[0-9].*[0-9].*[0-9])(?=.*[$&+,:;=?@#|_<>.\-^*()%!]).{8,}$');

  static final RegExp dob = RegExp(r'\s*\*.*');
  static final RegExp age = RegExp(r'^.*\* |Age : ');
  static final RegExp addWalletAmount = RegExp(r'^\d+\.?\d{0,1}');

  static final RegExp vitalsSelectedData = RegExp(r'[\[\]]');

  static final RegExp ecgImageConvert = RegExp(r'\s+');

  static final RegExp dateFormat =
      RegExp(r'^\d{2}-[A-Za-z]{3}-\d{4} \d{2}:\d{2}$');

  static final RegExp commonDateFormat = RegExp(r'^\d{2}-[A-Za-z]{3}-\d{4}$');

  static final RegExp formatTime =
      RegExp(r'(\d{2}):(\d{2})', caseSensitive: false);

  static final RegExp extractDate = RegExp(r'(\d{1,2}):(\d{2})');

  static final RegExp extractTime = RegExp(r'^\d{1,2}:\d{2}$');

  static final RegExp extractDateTime = RegExp(r'^\d{1,2}:\d{2}\s*(AM|PM)$');

  static final RegExp extractAndFormatTime = RegExp(r'(\d{2}):(\d{2}):(\d{2})');
  static final RegExp dosageQuantityFormat = RegExp(r'^\d{0,2}(\.\d{0,2})?$');
}
