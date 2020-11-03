import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFild() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculoImc() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double result = weight / (height * height);

      if (result < 18.5) {
        _infoText = "Ta na magreza! (${result.toStringAsPrecision(3)})";
      } else if (result >= 18.5 && result <= 24.9) {
        _infoText = "Peso Normal amigo! (${result.toStringAsPrecision(3)})";
      } else if (result >= 25 && result <= 29.9) {
        _infoText =
            "Ta Começando a ficar gordito (${result.toStringAsPrecision(3)})";
      } else if (result >= 30 && result <= 39.9) {
        _infoText = "ta gordo amigo! (${result.toStringAsPrecision(3)})";
      } else {
        _infoText = "OBESIDADE GRAVE!!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFild,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.green,
                    size: 150.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, color: Colors.green),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, color: Colors.green),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "insira sua Altura!";
                      }
                    },
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculoImc();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        textColor: Colors.white,
                        color: Colors.green,
                      )),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                    ),
                  )
                ],
              ),
            )));
  }
}
