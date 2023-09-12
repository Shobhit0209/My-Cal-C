import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

var input = '';
var output = '';
bool hideinput = false;
var outputsize = 25.0;

class _CalculatorState extends State<Calculator> {
  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == '') {
      if (input.isNotEmpty) {
        output = '';
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("÷", "/");
        userinput = input.replaceAll('x2', '^2');
        // userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var result = expression.evaluate(EvaluationType.REAL, cm);
        output = result.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = false;
        outputsize = 52;
      }
    } else {
      hideinput = false;
      outputsize = 25.0;
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideinput ? '' : input,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    output,
                    style: TextStyle(fontSize: outputsize, color: Colors.white),
                  ),
                ]),
          )),
          Row(
            children: [
              Reusablerow('C',
                  tcolor: Colors.white, bcolor: Colors.amber.shade500),
              Reusablerow('x2', issuperscript: true),
              Reusablerow('', isicon: true),
              Reusablerow('÷'),
            ],
          ),
          Row(
            children: [
              Reusablerow('7'),
              Reusablerow('8'),
              Reusablerow('9'),
              Reusablerow('*'),
            ],
          ),
          Row(
            children: [
              Reusablerow('4'),
              Reusablerow('5'),
              Reusablerow('6'),
              Reusablerow('-'),
            ],
          ),
          Row(
            children: [
              Reusablerow('1'),
              Reusablerow('2'),
              Reusablerow('3'),
              Reusablerow('+'),
            ],
          ),
          Row(
            children: [
              Reusablerow('00'),
              Reusablerow('0'),
              Reusablerow('.'),
              Reusablerow('=',
                  tcolor: Colors.white, bcolor: Colors.amber.shade500),
            ],
          )
        ],
      ),
    );
  }

  Widget Reusablerow(
    String title, {
    bool issuperscript = false,
    Icon icon = const Icon(
      Icons.backspace_outlined,
      color: Colors.amber,
      size: 29,
    ),
    bool isicon = false,
    var tcolor = Colors.amber,
    var bcolor = Colors.black,
  }) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => onButtonClick(title),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: bcolor,
            padding: EdgeInsets.all(18)),
        child: isicon
            ? icon
            : Text(title,
                style: issuperscript
                    ? TextStyle(
                        color: tcolor,
                        fontSize: 22,
                        fontFeatures: <FontFeature>[FontFeature.superscripts()])
                    : TextStyle(color: tcolor, fontSize: 22)),
      ),
    ));
  }
}
