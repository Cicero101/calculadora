import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final options = [
    "AC",
    "%",
    "*",
    "/",
    "7",
    "8",
    "9",
    "-",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "=",
    "0",
    ".",
  ];

  var operation = "";
  var result = 0.0;
  var a;
  var b;
  var currentOp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 15,  left: 15, top:30, bottom: 20 ),
                child: Container(
                  decoration: BoxDecoration(
                          color:
                            Color(0xFF8B886E),
                          borderRadius: 
                             BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0,0),
                            )
                          ]
                        ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 24,  left: 24, ),
                      child: Text(
                        operation,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 70.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Calculator',

                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(10),
                  crossAxisCount: 4,
                  itemCount: 18,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      final op = options[index];
                      if (options[index] == '=') {
                        operation = separatesFunctionIntoSmallerFunctions(
                            operation, '*', '/');
                        operation = separatesFunctionIntoSmallerFunctions(
                            operation, '-', '+');
                      } else {
                        operation += options[index];
                      }

                      switch (op) {
                        case "AC":
                          {
                            a = null;
                            b = null;
                            result = 0.0;
                            operation = "";
                            break;
                          }
                        case "+":
                          {
                            currentOp = op;
                            break;
                          }
                        case "-":
                          {
                            currentOp = op;
                            break;
                          }
                        case "*":
                          {
                            currentOp = op;
                            break;
                          }
                        case "/":
                          {
                            currentOp = op;
                            break;
                          }
                        case "=":
                          {
                            break;
                          }
                      }

                      setState(() {});
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color:
                            index == 0 ? Colors.red :
                            index == 1 ? Colors.teal :
                            index == 2 ? Colors.teal :
                            index == 3 ? Colors.teal :
                            index == 7 ? Colors.teal :
                            index == 11 ? Colors.teal : 
                            index == 15 ? Colors.orange : Color(0xFF505050),
                          borderRadius: 
                            index == 0 ? BorderRadius.circular(100) :
                            index == 1 ? BorderRadius.circular(100) :
                            index == 2 ? BorderRadius.circular(100) :
                            index == 3 ? BorderRadius.circular(100) :
                            index == 7 ? BorderRadius.circular(100) :
                            index == 11 ? BorderRadius.circular(100) : 
                            index == 15 ? BorderRadius.circular(100) : BorderRadius.circular(30), 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(-3,4),
                            )
                          ]
                        ),
                        child: Center(
                          child: Text(
                            options[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                        )),
                  ),
                  staggeredTileBuilder: (int index) {
                    if (index == 15) {
                      return StaggeredTile.count(1, 2);
                    } else if (index == 16) {
                      return StaggeredTile.count(2, 1);
                    } else {
                      return StaggeredTile.count(1, 1);
                    }
                  },
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                )),
          ],
        ),
      ),
    );
  }
}

separatesFunctionIntoSmallerFunctions(text, op1, op2) {

  final onlyNumbers = RegExp('[0-9]');
  bool findOperator = false;
  bool keepLooking = true;

  while (keepLooking) {

    keepLooking = false;
    String operation = '';
    String operator = '';

    for (int i = 0; i < text.length; i++) {

      if ((text[i] == op1 || text[i] == op2) && !findOperator) {
        operation += text[i];
        keepLooking = true;
        findOperator = true;
        if (text[i] == op1) operator = op1;
        if (text[i] == op2) operator = op2;

      } else if (onlyNumbers.hasMatch(text[i])) {
        operation += text[i];

        if (findOperator &&
            ((i + 1 == text.length) || !onlyNumbers.hasMatch(text[i + 1]))) {
          text = text.replaceAll(
              operation, calculateString(operation, operator).toString());
          operation = '';
          findOperator = false;
          break;
        }
      } else {
        operation = "";
      }
    }
  }
  return text;
}

calculateString(text, op) {
  List<String> textArray = [];
  if (op == '*') {
    textArray = text.split(op);
    return int.parse(textArray[0]) * int.parse(textArray[1]);
  } else if (op == '/') {
    textArray = text.split(op);
    return int.parse(textArray[0]) / int.parse(textArray[1]);
  } else if (op == '+') {
    textArray = text.split(op);
    return int.parse(textArray[0]) + int.parse(textArray[1]);
  } else if (op == '-') {
    textArray = text.split(op);
    return int.parse(textArray[0]) - int.parse(textArray[1]);
  }
}
