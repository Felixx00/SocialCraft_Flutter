import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

class Logros extends StatefulWidget {
  static String tag = '/logros';

  @override
  LogrosState createState() => LogrosState();
}

class LogrosState extends State<Logros> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Desafíos'),
          backgroundColor: azul_logo,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(fondo),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                20.height,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: 300,
                    height: 405,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: azul_logo,
                            radius: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/c7/80/5e/c7805ee9aa1a16baaa33a7b1be2f220e.png'),
                              radius: 60,
                            ),
                          ),
                          10.height,
                          Text(
                            'Desafío Semanal',
                            style: TextStyle(
                              fontSize: 25,
                              color: azul_logo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.height,
                          Text(
                            'Publica 5 posts',
                            style: TextStyle(
                              fontSize: 15,
                              color: azul_logo,
                            ),
                          ),
                          20.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              new CircularPercentIndicator(
                                radius: 100.0,
                                lineWidth: 10.0,
                                animation: true,
                                percent: 0.6,
                                center: new Text(
                                  "60.0%",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                footer: new Text(
                                  "3/5",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ).paddingTop(8),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: azul_logo,
                              ),
                              ElevatedButton.icon(
                                label: Text(
                                  'Claim',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(70, 45),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  primary: Colors.grey[600],
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                ),
                                icon:
                                    Icon(Icons.attach_money_outlined, size: 20),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),
                30.height,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: azul_logo,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://i.pinimg.com/originals/c7/80/5e/c7805ee9aa1a16baaa33a7b1be2f220e.png'),
                                  radius: 45,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Likes',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: azul_logo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Da 10 likes',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: azul_logo,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: new LinearPercentIndicator(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  animation: true,
                                  lineHeight: 20.0,
                                  animationDuration: 2000,
                                  percent: 1.0,
                                  center: Text("100.0%"),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Colors.green,
                                ),
                              ),
                              ElevatedButton.icon(
                                label: Text(
                                  'Claim',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  //minimumSize: Size(60, 45),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  primary: azul_logo,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                ),
                                icon:
                                    Icon(Icons.attach_money_outlined, size: 20),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),
                30.height,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: azul_logo,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(trophy2),
                                  radius: 45,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Posts',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: azul_logo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Publica 15 posts',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: azul_logo,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: new LinearPercentIndicator(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  animation: true,
                                  lineHeight: 20.0,
                                  animationDuration: 2000,
                                  percent: 0.45,
                                  center: Text("46.67%"),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: Colors.green,
                                ),
                              ),
                              ElevatedButton.icon(
                                label: Text(
                                  'Claim',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  //minimumSize: Size(60, 45),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  primary: Colors.grey[600],
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                ),
                                icon:
                                    Icon(Icons.attach_money_outlined, size: 20),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),
                30.height,
                Stack(alignment: Alignment.topRight, children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 25,
                    shadowColor: Colors.black,
                    color: Colors.blue[100],
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundColor: azul_logo,
                                  radius: 55,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(tick),
                                    radius: 45,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Comenta',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: azul_logo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    10.height,
                                    Text(
                                      'Haz 20 comentarios',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: azul_logo,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2000,
                                    percent: 1.0,
                                    center: Text("100.00%"),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.green,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  label: Text(
                                    'Claimed',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    //minimumSize: Size(60, 45),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    primary: Colors.grey[600],
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                  ),
                                  icon: Icon(Icons.check, size: 20),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).center(),
                  Icon(
                    Icons.info_outline_rounded,
                    color: azul_logo,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ).paddingOnly(top: 10, right: 30),
                ]),
                30.height,
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 1, bottom: 1),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: ElevatedButton(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
