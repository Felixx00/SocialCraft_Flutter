import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:socialcraft/provider/locale_provider.dart';
import 'package:socialcraft/l10n/l10n.dart';
import 'l10n/l10n.dart';

class Settings extends StatefulWidget {
  static String tag = '/settings';

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
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
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);
    final provider = Provider.of<LocaleProvider>(context);
    final localee = provider.localee;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text( AppLocalizations.of(context).configuracion ),
          backgroundColor: azul_logo,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              30.height,
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: Text(AppLocalizations.of(context).cerrarSesion),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 40),
                      primary: Colors.red[400],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    icon: Icon(Icons.exit_to_app_rounded, size: 18),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  )).paddingTop(10),
              20.height,
              Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: Colors.black38,
              ),
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: Text(AppLocalizations.of(context).eliminarCuenta),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 40),
                      primary: Colors.red[400],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    icon: Icon(Icons.close, size: 18),
                    onPressed: () {
                      showAlertDialogEliminar(context);
                    },
                  )).paddingTop(10),
              20.height,
              Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: Colors.black38,
              ),
              DropdownButton(
                icon: Icon(Icons.language),
                value: localee,
                items: L10n.all.map(
                      (localee){
                    final flag = L10n.getFlag(localee.languageCode);
                    return DropdownMenuItem(
                      child: Center(
                        child: Text(
                          flag,
                          style:TextStyle(fontSize: 32),
                        ),
                      ),
                      value: localee,
                      onTap:() {
                        final provider = Provider.of<LocaleProvider>(context,listen:false);
                        provider.setLocale(localee);
                      },
                    );

                  },).toList(),
                onChanged: (_) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Sí"),
    onPressed: () async {
      final storage = new FlutterSecureStorage();
      await storage.deleteAll();
      String token = await storage.read(key: 'jwt');
      print(token);
      Navigator.pushNamedAndRemoveUntil(
          context, 'login', (Route<dynamic> route) => false);
    },
  );
  Widget continueButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    content: Text("¿Estas seguro que deseas cerrar sesión?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogEliminar(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Sí"),
    onPressed: () async {
      final storage = new FlutterSecureStorage();
      String token = await storage.read(key: 'jwt');

      print(token);
      final response = await http.post(
        Uri.https('api.socialcraft.club', 'users/deleteAccount'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        await storage.deleteAll();
        print(response.body);
        Navigator.pushNamedAndRemoveUntil(
            context, 'login', (Route<dynamic> route) => false);
      } else {
        Navigator.pop(context);
        throw Exception('Failed to load response');
      }
    },
  );
  Widget continueButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    content: Text("¿Estas seguro que deseas eliminar tu cuenta?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
