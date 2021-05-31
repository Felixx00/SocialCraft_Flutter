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

  init() async {
    setState(() {});
    Location loc = Location();

    await loc.serviceEnabled();
    await loc.requestService();
    await loc.hasPermission();
    await loc.requestPermission();
    loc2 = await loc.getLocation();

    print('aaaaaaaaaaaaaa');
    print(loc2.latitude + loc2.longitude);
    setState(() {});
    final Marker marker = Marker(
      markerId: MarkerId('a'),
      position: LatLng(41.3055106, 2.0003913),
      infoWindow: InfoWindow(
          title: 'Botiga 1', snippet: 'Botiga de productes per crafts'),
      onTap: () {},
    );
    markers[MarkerId('a')] = marker;
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
