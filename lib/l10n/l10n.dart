import 'package:flutter/material.dart';

class L10n{
  static final all = [
    const Locale('en'),
    const Locale('es'),
    const Locale('ca'),
  ];

  static String getFlag(String code){
    switch (code) {
      case 'es':
        return 'Español';
      case 'ca':
        return 'Català';
      case 'en':
        return 'English';
      default:
        return '🇺🇸';
    }
  }
}