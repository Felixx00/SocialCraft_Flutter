import 'package:flutter/material.dart';
import 'package:socialcraft/editar.dart';
//import 'package:socialcraft/prueba.dart';
import 'post.dart';
import 'package:socialcraft/register.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'perfil.dart';
import 'perfil2.dart';
import 'buscar.dart';
//import 'prueba.dart';

class barra extends StatefulWidget {
  static String tag = '/EGNavigationScreen';

  @override
  barraState createState() => barraState();
}

/// This is the private State class that goes with MyStatefulWidget.
class barraState extends State<barra> {
  var _selectedIndex = 0;
  var _pages = [Perfil(), Search(), Post(), Perfil2()];
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Buscar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop),
                label: 'Tienda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Perfil',
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
