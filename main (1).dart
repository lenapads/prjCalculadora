import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '0';
  String opr = '';
  String preOpr = '';

  Widget calcButton(String btnText, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () => calculation(btnText),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
      backgroundColor: btnColor,
      padding: const EdgeInsets.all(20),
      minimumSize: const Size(80, 80),
      ),
      child: Text(
        btnText,
        style: TextStyle(
          fontSize: 30,
          color: txtColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void calculation(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        text = '0';
        numOne = 0;
        numTwo = 0;
        result = '';
        finalResult = '0';
        opr = '';
        preOpr = '';
      } else if (btnText == '=' && opr.isNotEmpty) {
        if (result.isNotEmpty) {
          // Tentando converter o resultado em número apenas se for válido
          try {
            numTwo = double.parse(result);
          } catch (e) {
            finalResult = 'Erro';
            text = finalResult;
            return;
          }
        }

        if (opr == '+') {
          finalResult = (numOne + numTwo).toString();
        } else if (opr == '-') {
          finalResult = (numOne - numTwo).toString();
        } else if (opr == 'x') {
          finalResult = (numOne * numTwo).toString();
        } else if (opr == '/') {
          finalResult = numTwo == 0 ? 'Erro' : (numOne / numTwo).toString();
        } else if (opr == '^') {
          // Aqui é onde lidamos com a potência
          finalResult =
              (pow(numOne, numTwo)).toString(); // Utiliza a função pow
        }

        preOpr = opr;
        opr = '';
        result = finalResult;
        numOne = double.parse(finalResult);
      } else if (btnText == '+' ||
          btnText == '-' ||
          btnText == 'x' ||
          btnText == '/' ||
          btnText == '^') {
        // Adicionando a operação de potência
        if (result.isNotEmpty) {
          numOne = double.parse(result);
        }
        opr = btnText;
        result = '';
      } else if (btnText == '.') {
        if (!result.contains('.')) {
          result += '.';
        }
        finalResult = result;
      } else if (btnText == '+/-') {
        result = result.startsWith('-') ? result.substring(1) : '-$result';
        finalResult = result;
      } else {
        result += btnText;
        finalResult = result;
      }

      text = finalResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 80),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('^', Colors.grey, Colors.black), // Botão de potência
                calcButton('/', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.grey, Colors.white),
                calcButton('8', Colors.grey, Colors.white),
                calcButton('9', Colors.grey, Colors.white),
                calcButton('x', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.grey, Colors.white),
                calcButton('5', Colors.grey, Colors.white),
                calcButton('6', Colors.grey, Colors.white),
                calcButton('-', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.grey, Colors.white),
                calcButton('2', Colors.grey, Colors.white),
                calcButton('3', Colors.grey, Colors.white),
                calcButton('+', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => calculation('0'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                calcButton('.', Colors.grey, Colors.white),
                calcButton('=', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
