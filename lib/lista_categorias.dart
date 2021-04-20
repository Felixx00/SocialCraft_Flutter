import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/buscar.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'dart:async';
import 'dart:convert';

List categories = [
  {
    "id" : 1,
    "name": "Covid-19",
    "follow": false
  },
  {
    "id" : 2,
    "name": "Patchwork",
    "follow": false
  },
  {
    "id" : 3,
    "name": "Scrapbooking",
    "follow": false
  },
  {
    "id" : 4,
    "name": "Pintura",
    "follow": false
  },
  {
    "id" : 5,
    "name": "Escultura",
    "follow": false
  },
  {
    "id" : 6,
    "name": "Bisutería",
    "follow": false
  },
  {
    "id" : 7,
    "name": "Mercería",
    "follow": false
  },
  {
    "id" : 8,
    "name": "Papelería",
    "follow": false
  },
  {
    "id" : 9,
    "name": "Decoupage",
    "follow": false
  }
];

void main() => runApp(Categoriaas());
FocusNode nameNode;

class Categoriaas extends StatefulWidget {
  @override
  ListaCategorias createState() => ListaCategorias();
}

class ListaCategorias extends  State<Search>{
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {

  }
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: List.generate(categories.length, (index){
        return Padding(
          padding: const EdgeInsets.only(right:1,
          bottom:1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              ListTile(
                title: Text(categories[index]["name"],
                    style: TextStyle(
                        color:black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                leading: CircleAvatar(
                  child: Text(categories[index]["name"][0]),
                ),
                trailing: ElevatedButton.icon(
                  label: Text(categories[index]["follow"] ? 'Follow': 'Unfollow'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50,40),
                    primary: categories[index]["follow"] ? Color.fromRGBO(68,102,216,1.0) : Colors.redAccent[200],
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  icon: Icon(categories[index]["follow"] ? Icons.person_add : Icons.person_add_disabled, size: 18),
                  onPressed: () {
                    categories[index]["follow"] =!categories[index]["follow"];
                    //setState((){});
                  },
                )
              ),
            ],
          ));}
          )
        )
    );

  }

}