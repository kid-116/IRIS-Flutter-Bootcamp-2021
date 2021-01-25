import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  String activeOperand = "";
  List<String> naturals = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
  List<String> wholes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  List<String> operators = ["÷", "x", "-", "+"];
  bool present(String element, List<String> list) {
    for(int i = 0; i < list.length; ++ i) {
      if(list[i] == element) {
        return true;
      }
    }
    return false;
  }
  buttonPressed(String buttonText) {
    //YOU WILL HAVE TO IMPLEMENT THIS METHOD
    if(buttonText == "AC") {
      setState(() {
        equation = "0";
        result = "0";
        expression = "";
      });
    }
    else if(buttonText == "C") {
      equation = equation.substring(0, equation.length - 1);
      setState(() {
        equation = equation == "" ? "0" : equation;
      });
    }
    else if(buttonText == "=") {
      //Calculate the equation
      expression = equation;
      expression = expression.replaceAll("x", "*");
      expression = expression.replaceAll("÷", "/");
      print(expression);
      try {
        Parser p = Parser();
        ContextModel cm = ContextModel();
        Expression exp = p.parse(expression);
        result = "${exp.evaluate(EvaluationType.REAL, cm)}";
      } catch(error) {

      }
      setState(() {});
    }
    else if(present(buttonText, operators)) {
      if(present(equation[equation.length - 1], wholes) && equation != "0") {
          equation = equation + buttonText;
          setState(() {});
        }
    }
    else if(buttonText == ".") {
      setState(() {
        if (present(equation[equation.length - 1], wholes)) {
          int i;
          for(i = equation.length - 1; i >= 0; -- i) {
            if (present(equation[i], operators)) {
              equation = equation + buttonText;
              break;
            }
            else if (equation[i] == ".") {
              break;
            }
          }
          if(i < 0) {
            equation += buttonText;
          }
        }
      });
    }
    else if(present(buttonText, ["0", "00"])) {
      if((equation != "0") && (!present(equation[equation.length - 1], operators))) {
        setState(() {
          equation = equation + buttonText;
        });
      }
    }
    else {
      setState(() {
        if(equation == "0") {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      });
    }
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 40, color: Colors.black54),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: 50),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("AC", 1, Colors.redAccent, context),
                      buildButton("C", 1, Colors.blue, context),
                      buildButton("÷", 1, Colors.blue, context),
                    ]),
                    for (int i = 9; i > 0; i = i - 3)
                      TableRow(children: [
                        buildButton(
                            (i - 2).toString(), 1, Colors.black54, context),
                        buildButton(
                            (i - 1).toString(), 1, Colors.black54, context),
                        buildButton((i).toString(), 1, Colors.black54, context),
                      ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.black54, context),
                      buildButton("0", 1, Colors.black54, context),
                      buildButton("00", 1, Colors.black54, context),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("x", 1, Colors.blue, context),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blue, context),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blue, context),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.redAccent, context),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
