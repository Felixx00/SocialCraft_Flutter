import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/materiales.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:smart_select/smart_select.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';

class SubirPasos extends StatefulWidget {
  static String tag = '/upload';

  @override
  SubirPasosState createState() => SubirPasosState();
}

class SubirPasosState extends State<SubirPasos> {
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

  int activeStep = 0; // Initial step set to 5.

  int upperBound = 6;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Steps'),
          backgroundColor: azul_logo,
          leading: Icon(Icons.arrow_back).onTap(() {
            Navigator.pop(context);
            //finish(context);
            //Navigator
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              NumberStepper(
                numbers: [
                  1,
                  2,
                  3,
                  4,
                  5,
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              header(),
              Expanded(
                child: FittedBox(
                  child: Center(
                    child: Text((activeStep + 1).toString()),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}

var current = 1;

String value1 = 'flutter';
List<S2Choice<String>> options = [
  S2Choice<String>(value: 'a', title: 'Fácil'),
  S2Choice<String>(value: 'b', title: 'Intermedio'),
  S2Choice<String>(value: 'c', title: 'Difícil'),
];

String value2 = '0';
List<S2Choice<String>> categorias = [
  S2Choice<String>(value: 'a', title: 'Origami'),
  S2Choice<String>(value: 'b', title: 'Lifehack'),
  S2Choice<String>(value: 'c', title: 'Téxtil'),
  S2Choice<String>(value: 'd', title: 'Jardineria'),
  S2Choice<String>(value: 'e', title: 'Bricolaje'),
  S2Choice<String>(value: 'f', title: 'Electrónica'),
  S2Choice<String>(value: 'g', title: 'Pintura'),
];

List<int> value3 = [2];
List<S2Choice<int>> frameworks = [
  S2Choice<int>(value: 1, title: 'Papel'),
  S2Choice<int>(value: 2, title: 'Piedra'),
  S2Choice<int>(value: 3, title: 'Tijeras'),
];

String value4 = 'flutter';
List<S2Choice<String>> tiempos = [
  S2Choice<String>(value: 'a', title: '<10 min.'),
  S2Choice<String>(value: 'b', title: '10 min.'),
  S2Choice<String>(value: 'c', title: '20 min.'),
  S2Choice<String>(value: 'd', title: '30 min.'),
  S2Choice<String>(value: 'e', title: '40 min.'),
  S2Choice<String>(value: 'f', title: '50 min.'),
  S2Choice<String>(value: 'g', title: '60 min.'),
  S2Choice<String>(value: 'h', title: '>60 min.'),
];
