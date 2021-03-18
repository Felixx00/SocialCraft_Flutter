import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
            Stack(
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.lightBlue,
                    child: Text("?",
                        style: boldTextStyle(size: 20, color: white))),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: lightBlue,
                    radius: 15,
                    child: Icon(Icons.camera_alt_rounded,
                        size: 20, color: blueColor),
                  ).onTap(() async {
                    //ImagePicker().getImage(source: ImageSource.gallery);
                  }),
                ),
              ],
            ).center(),
            16.height,
            Text("Username", style: boldTextStyle(size: 20)).center(),
            2.height,
            Text("Descripción", style: secondaryTextStyle(size: 14)).center(),
            15.height,
            new Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.person_outline_sharp, size: 18),
                label: Text('Editar Perfil'),
              ),
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
