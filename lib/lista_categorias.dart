import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';
List categories = [
  {
    "id" : 1,
    "name": "Covid-19"
  },
  {
    "id" : 2,
    "name": "Patchwork"
  },
  {
    "id" : 3,
    "name": "Scrapbooking"
  },
  {
    "id" : 4,
    "name": "Pintura"
  },
  {
    "id" : 5,
    "name": "Escultura"
  },
  {
    "id" : 6,
    "name": "Bisutería"
  },
  {
    "id" : 7,
    "name": "Mercería"
  },
  {
    "id" : 8,
    "name": "Papelería"
  },
  {
    "id" : 9,
    "name": "Decoupage"
  }
];

class ListaCategorias extends StatelessWidget {
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
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width:3.0,
                    color:azul_logo
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                    categories[index]["name"],
                    style: TextStyle(
                      color:black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold))
              ),
            ],
          ));}
          )
        )
    );

  }

}