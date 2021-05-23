import 'package:flutter/material.dart';
import 'package:socialcraft/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _localee;
  Locale get localee => _localee;
  void setLocale(Locale localee){
    if (!L10n.all.contains(localee)) return;
    _localee = localee;
    notifyListeners();
  }
  void clearLocale(){
    _localee = null;
    notifyListeners();
  }
}