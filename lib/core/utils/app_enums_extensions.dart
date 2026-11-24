
import 'enum.dart';

extension MainMenuExtension on MainMenu {
  String get title {
    switch (this) {
      case MainMenu.dashboard:
        return 'Dashboard';
      case MainMenu.clinicalWork:
        return 'Clinical Work';
    }
  }


  bool get hasSubMenus {
    switch (this) {
      case MainMenu.clinicalWork:
        return true;
      default:
        return false;
    }
  }

  List<SubMenu>? get subMenus {
    switch (this) {
      case MainMenu.clinicalWork:
        return [SubMenu.ipdList];
      default:
        return null;
    }
  }
}

extension SubMenuExtension on SubMenu {
  String get title {
    switch (this) {
      case SubMenu.opdList:
        return 'OPD List';
      case SubMenu.ipdList:
        return 'IPD List';
    }
  }

  MainMenu get parentMenu {
    switch (this) {
      case SubMenu.opdList:
      case SubMenu.ipdList:
        return MainMenu.clinicalWork;
    }
  }
}
