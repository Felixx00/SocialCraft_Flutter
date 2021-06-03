import 'package:flutter/material.dart';
import 'package:socialcraft/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _localee;
  Locale get localee => _localee;
  void setLocale(String l){
    Locale localee;
    switch (l) {
      case 'es':
        localee = Locale('es');
        break;
      case 'ca':
        localee = Locale('ca');
        break;
      case 'en':
        localee = Locale('en');
        break;
      default:
        localee = Locale('en');
        break;
    }
    if (!L10n.all.contains(localee)) return;
    _localee = localee;
    notifyListeners();
  }
  void clearLocale(){
    _localee = null;
    notifyListeners();
  }
}