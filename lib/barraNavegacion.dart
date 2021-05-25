import 'package:flutter/material.dart';
import 'package:socialcraft/editar.dart';
import 'package:socialcraft/tienda.dart';
//import 'package:socialcraft/prueba.dart';
import 'home.dart';
import 'post.dart';
import 'package:socialcraft/register.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'perfil.dart';
import 'perfil2.dart';
import 'buscar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class barra extends StatefulWidget {
  static String tag = '/EGNavigationScreen';

  @override
  barraState createState() => barraState();
}

/// This is the private State class that goes with MyStatefulWidget.
class barraState extends State<barra> {
  var _selectedIndex = 0;
  var _pages = [Home(), Search(), Tienda(), Perfil()];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _pages.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
            //backgroundColor: Colors.grey[200],
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppLocalizations.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: AppLocalizations.of(context).buscar,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: AppLocalizations.of(context).tienda,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: AppLocalizations.of(context).perfil,
              ),
            ],
            fixedColor: azul_logo,
            onTap: (int inIndex) {
              setState(() {
                _selectedIndex = inIndex;
              });
            }));
  }
}
