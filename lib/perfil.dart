import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';

class Perfil extends StatefulWidget {
  static String tag = '/EGProfileScreen';

  @override
  PerfilState createState() => PerfilState();
}

class PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SocialCraft'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Hola')));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Stack(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Text("?",
                          style: boldTextStyle(size: 20, color: white))),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent[100],
                      radius: 15,
                      child: Icon(Icons.camera_alt_rounded,
                          size: 20, color: Colors.blue[800]),
                    ).onTap(() async {
                      //ImagePicker().getImage(source: ImageSource.gallery);
                    }),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "64",
                    style: boldTextStyle(size: 16, color: black),
                  ),
                  Text("Posts", style: boldTextStyle(size: 12, color: black))
                ],
              ),
              Column(
                children: [
                  Text("124", style: boldTextStyle(size: 16, color: black)),
                  Text("Seguidores",
                      style: boldTextStyle(size: 12, color: black))
                ],
              ),
              Column(
                children: [
                  Text("212", style: boldTextStyle(size: 16, color: black)),
                  Text("Seguidos", style: boldTextStyle(size: 12, color: black))
                ],
              ),
            ]),
            12.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Username", style: boldTextStyle(size: 20))
                        .paddingLeft(12),
                    2.height,
                    Text("Descripción", style: secondaryTextStyle(size: 14))
                        .paddingLeft(12),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(insignia, width: 90, height: 90),
                  ],
                ),
              ],
            ),
            10.height,
            ElevatedButton.icon(
              label: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(180, 30),
                //primary: Colors.lightBlueAccent[200],
                primary: Color.fromRGBO(68, 102, 216, 1.0),
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              icon: Icon(Icons.person_outline_sharp, size: 18),
              onPressed: () {
                print('Pressed');
              },
            ).center(),
            Divider(
              height: 30,
              thickness: 3,
              color: Colors.grey[650],
            ),
          ],
        ).paddingAll(16),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.lightBlueAccent,
      ),
    );
  }
}
