import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Calculator",
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String displayText = '0'; //defult value
  double firstNum = 0; //first number
  double secoundNum = 0; //secound number
  String result = '0'; //first result
  String finalResult = '0'; //final result

  String opr = '';
  String prevOpr = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    displayText,
                    style: TextStyle(color: Colors.white, fontSize: 60),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("C", Color(0xFFB9B6B3), 1),
                button("+/-", Color(0xFFB9B6B3), 1),
                button("%", Color(0xFFB9B6B3), 1),
                button("/", Color(0xFFF09A37), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("7", Color(0xFF494949), 1),
                button("8", Color(0xFF494949), 1),
                button("9", Color(0xFF494949), 1),
                button("x", Color(0xFFF09A37), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("4", Color(0xFF494949), 1),
                button("5", Color(0xFF494949), 1),
                button("6", Color(0xFF494949), 1),
                button("-", Color(0xFFF09A37), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("1", Color(0xFF494949), 1),
                button("2", Color(0xFF494949), 1),
                button("3", Color(0xFF494949), 1),
                button("+", Color(0xFFF09A37), 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                button("0", Color(0xFF494949), 0),
                button(".", Color(0xFF494949), 1),
                button("=", Color(0xFFF09A37), 1)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String text, Color color, int i) {
    Container? container = null;

    if (i == 0) {
      container = Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 10, left: 20),
        child: RaisedButton(
          onPressed: () {
            calculate(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          color: color,
          padding: EdgeInsets.only(right: 120, left: 40, top: 20, bottom: 20),
          shape: StadiumBorder(),
        ),
      );
    } else {
      container = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          onPressed: () {
            calculate(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          color: color,
          padding: EdgeInsets.all(20),
          shape: CircleBorder(),
        ),
      );
    }
    return container;
  }

  void calculate(textB) {
    if (textB == 'C') {
      displayText = '0';
      firstNum = 0;
      secoundNum = 0;
      result = '';
      finalResult = '0';
      opr = '';
      prevOpr = '';
    } else if (opr == '=' && textB == '=') {
      switch (prevOpr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'x':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }
    } else if (textB == '+' ||
        textB == '-' ||
        textB == 'x' ||
        textB == '/' ||
        textB == '=') {
      if (firstNum == 0) {
        firstNum = double.parse(result);
      } else {
        secoundNum = double.parse(result);
      }

      switch (opr) {
        case '+':
          finalResult = add();
          break;
        case '-':
          finalResult = sub();
          break;
        case 'x':
          finalResult = mul();
          break;
        case '/':
          finalResult = div();
          break;
      }

      prevOpr = opr;
      opr = textB;
      result = '';
    } else if (textB == '%') {
      result = (firstNum / 100).toString();
      finalResult = result;
    } else if (textB == '.') {
      if (!result.contains('.')) {
        result += '.';
      }
    } else if (textB == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;
      finalResult = result;
    } else {
      if (result == '0') {
        result = textB;
      } else {
        result = result + textB;
      }

      finalResult = result;
    }
    setState(() {
      displayText = finalResult;
    });
  }

  String add() {
    result = (firstNum + secoundNum).toString();
    firstNum = double.parse(result);

    return result;
  }

  String sub() {
    result = (firstNum - secoundNum).toString();
    firstNum = double.parse(result);

    return result;
  }

  String mul() {
    result = (firstNum * secoundNum).toString();
    firstNum = double.parse(result);

    return result;
  }

  String div() {
    result = (firstNum / secoundNum).toString();
    firstNum = double.parse(result);

    return result;
  }
}
