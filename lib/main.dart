import 'package:flutter/material.dart';
//import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _input = '';
  String _output = '0';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _output = '0';
      } else if (value == '=') {
        try {
          _output = _evaluateExpression(_input);
        } catch (e) {
          _output = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  String _evaluateExpression(String input) {
    double result = 0.0;

    try {
      result = _calculate(input);
      return result.toStringAsFixed(2).replaceAll('.00', '');
    } catch (e) {
      return 'Error';
    }
  }

  double _calculate(String input) {
    List<String> tokens = _tokenize(input);
    List<double> numbers = [];
    List<String> operators = [];

    for (var token in tokens) {
      if (_isOperator(token)) {
        while (operators.isNotEmpty &&
            _precedence(operators.last) >= _precedence(token)) {
          _compute(numbers, operators.removeLast());
        }
        operators.add(token);
      } else {
        numbers.add(double.parse(token));
      }
    }

    while (operators.isNotEmpty) {
      _compute(numbers, operators.removeLast());
    }

    return numbers.last;
  }

  List<String> _tokenize(String input) {
    final regex = RegExp(r'(\d+\.?\d*|\+|\-|\*|\/)');
    return regex.allMatches(input).map((m) => m.group(0)!).toList();
  }

  bool _isOperator(String token) => ['+', '-', '*', '/'].contains(token);

  int _precedence(String operator) {
    if (operator == '+' || operator == '-') return 1;
    if (operator == '*' || operator == '/') return 2;
    return 0;
  }

  void _compute(List<double> numbers, String operator) {
    final b = numbers.removeLast();
    final a = numbers.removeLast();

    switch (operator) {
      case '+':
        numbers.add(a + b);
        break;
      case '-':
        numbers.add(a - b);
        break;
      case '*':
        numbers.add(a * b);
        break;
      case '/':
        numbers.add(a / b);
        break;
    }
  }

  Widget _buildButton(String value, {Color? color}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(value),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: color ?? Colors.blue,
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Calculadora'),
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250.0,
                      width: 400.0,
                      child: Image.asset('assets/casio.jpg'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _input,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Text(
                  _output,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildButton('7'),
                        _buildButton('8'),
                        _buildButton('9'),
                        _buildButton('/', color: Colors.orange),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('4'),
                        _buildButton('5'),
                        _buildButton('6'),
                        _buildButton('*', color: Colors.orange),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('1'),
                        _buildButton('2'),
                        _buildButton('3'),
                        _buildButton('-', color: Colors.orange),
                      ],
                    ),
                    Row(
                      children: [
                        _buildButton('C', color: Colors.red),
                        _buildButton('0'),
                        _buildButton('='),
                        _buildButton('+', color: Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
