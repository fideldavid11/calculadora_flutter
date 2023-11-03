import 'package:flutter/material.dart';
import 'dart:math';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculadoraCientificaApp());
}

class CalculadoraCientificaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculadoraCientifica(),
    );
  }
}

class CalculadoraCientifica extends StatefulWidget {
  @override
  _CalculadoraCientificaState createState() => _CalculadoraCientificaState();
}

class _CalculadoraCientificaState extends State<CalculadoraCientifica> {
  String displayText = '';
  String equation = '';
  bool isResult = false;

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        displayText = '';
        equation = '';
      } else if (buttonText == '=') {
        try {
          equation = displayText;
          displayText = calculate(equation).toString();
          isResult = true;
        } catch (e) {
          displayText = 'Error';
          equation = '';
        }
      } else if (buttonText == '√') {
        if (isResult) {
          displayText = '';
          equation = '';
          isResult = false;
        }
        displayText += 'sqrt(';
        equation += 'sqrt(';
      } else if (buttonText == 'log') {
        if (isResult) {
          displayText = '';
          equation = '';
          isResult = false;
        }
        displayText += 'log(';
        equation += 'log(';
      } else {
        if (isResult) {
          displayText = '';
          equation = '';
          isResult = false;
        }
        displayText += buttonText;
        equation += buttonText;
      }
    });
  }

  double calculate(String expression) {
    expression = expression.replaceAll('x', '*');
    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('sqrt', 'sqrt');
    expression = expression.replaceAll('log', 'log');
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    cm.bindVariable(Variable('log'), Number(e));
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Científica'),
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centra el contenido verticalmente
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra las filas de botones verticalmente
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los botones horizontalmente
                  children: <Widget>[
                    buildButton('sin'),
                    buildButton('cos'),
                    buildButton('tan'),
                    buildButton('√'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los botones horizontalmente
                  children: <Widget>[
                    buildButton('ln'),
                    buildButton('log'),
                    buildButton('C'),
                    buildButton('÷'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los botones horizontalmente
                  children: <Widget>[
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('x'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los botones horizontalmente
                  children: <Widget>[
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los botones horizontalmente
                  children: <Widget>[
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('+'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los botones horizontalmente
                  children: <Widget>[
                    buildButton('0'),
                    buildButton('='),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return Container(
      margin:
          EdgeInsets.all(4.0), // Agrega un pequeño margen alrededor del botón
      child: ElevatedButton(
        onPressed: () => onButtonPressed(buttonText),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.all(8.0)), // Ajusta el espacio interno del botón
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 16.0), // Ajusta el tamaño del texto
        ),
      ),
    );
  }
}
