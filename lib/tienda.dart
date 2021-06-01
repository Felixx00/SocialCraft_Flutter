import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Tienda extends StatefulWidget {
  @override
  TiendaState createState() => TiendaState();
}

class TiendaState extends State<Tienda> {
  bool showPassword = false;
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  String user = "";
  String pass = "";
  double lat;
  double lon;
  bool correct = true;
  bool fet = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var loc2;

  @override
  void initState() {
    super.initState();
    init();
    setState(() {});
  }

  Future<Resp> tiendas() async {
    var map = new Map<String, dynamic>();
    map['lat'] = lat.toString();
    map['lon'] = lon.toString();
    final response = await http.get(
      Uri.https('api.socialcraft.club', 'stores/getStoresNearby', map),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  init() async {
    setState(() {});
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    Location loc = Location();

    await loc.serviceEnabled();
    await loc.requestService();
    await loc.hasPermission();
    await loc.requestPermission();
    loc2 = await loc.getLocation();
    lat = loc2.latitude;
    lon = loc2.longitude;

    await tiendas().then((respuesta) async {
      print(respuesta.list.length);
      for (int i = 0; i < respuesta.list.length; ++i) {
        print('---------------');
        Marker marker = Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(double.parse(respuesta.list[i]['longitud']),
              double.parse(respuesta.list[i]['latitud'])),
          infoWindow: InfoWindow(
              title: respuesta.list[i]['nombre'],
              snippet: respuesta.list[i]['descripcion']),
          onTap: () {},
        );
        markers[MarkerId(i.toString())] = marker;
        print(respuesta.list[i]['latitud'] +
            ' ' +
            respuesta.list[i]['longitud'] +
            ' ' +
            respuesta.list[i]['nombre']);
        print('---------------');
      }
    });

    print(markers);
    print('aaaaaaaaaaaaaa');
    print(loc2.latitude + loc2.longitude);
    setState(() {});

    /*
    Marker marker = Marker(
      markerId: MarkerId('a'),
      position: LatLng(41.30, 2.00696),
      infoWindow: InfoWindow(
        title: 'a',
        snippet: 'bsasd',
      ),
      onTap: () {},
    );
    markers[MarkerId('a')] = marker;

    Marker marker2 = Marker(
      markerId: MarkerId('b'),
      position: LatLng(41.30, 2.10696),
      infoWindow: InfoWindow(
        title: 'a',
        snippet: 'bsasd',
      ),
      onTap: () {},
    );
    markers[MarkerId('b')] = marker2;
    */

    fet = true;

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return !fet
        ? Container()
        : Scaffold(
            body: GoogleMap(
              mapToolbarEnabled: false,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      fet ? loc2.latitude : 41.68, fet ? loc2.longitude : 2.17),
                  zoom: fet ? 14.5 : 10),
              markers: Set<Marker>.of(markers.values),
              myLocationEnabled: true,
            ),
          );
  }
}

/*
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
            target: LatLng(41.386737531762506, 2.171121952500942), zoom: 10.5),
        markers: Set<Marker>.of(markers.values),
        myLocationEnabled: true,
      ),
    );
  }
}
*/
