import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonsList = [
    'C',
    '(',
    ')',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];

@override
Widget build(BuildContext context) {
  return SafeArea(
  child: Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            Color.fromARGB(255, 43, 47, 46), 
            Color.fromARGB(255, 23, 32, 35), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: resultWidget(),
          ),
          Expanded(
            flex: 2,
            child: buttonsWidget(),
          ),
        ],
      ),
    ),
  ),
);

  
}

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 38, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 58, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buttonsWidget() {
  return GridView.builder(
    physics: const BouncingScrollPhysics(), 
    itemCount: buttonsList.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
    ),
    itemBuilder: (BuildContext context, int index) {
      return buttons(buttonsList[index]);
    },
  );
}

  Widget buttons(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
  if (text == "AC") {
    userInput = "";
    result = "0";
    return;
  }

  if (text == "C") {
    if (userInput.isNotEmpty) {
      userInput = userInput.substring(0, userInput.length - 1);
    }
    return;
  }

  if (text == "=") {
    result = calculate();
    if (result.endsWith(".0")) result = result.replaceAll(".0", "");
    return;
  }


  userInput = userInput + text;
}

String calculate() {
  try {

    String finalInput = userInput.replaceAll('x', '*').replaceAll('÷', '/');
    
    var exp = Parser().parse(finalInput);
    var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
    
    return evaluation.toString();
  } catch (e) {
    return "Error";
  }
}


  getColor(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-" || text == "=") {
      return Colors.black;
    }

    if (text == "C" || text == "AC") {
      return Colors.black;
    }

    if (text == "(" || text == ")") {
      return Colors.black;
    }

    return Colors.black;
  }
}
