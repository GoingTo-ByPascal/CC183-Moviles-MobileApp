import 'package:flutter/material.dart';
import '../home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _registerView());
  }

  Widget _registerView() {
    return Container(
      color: Color(0xff3490de),
      child: Column(
        children: [
          // Primer hijo:imagen de GoingTo
          Expanded(
            flex: 18,
            child: Center(
              child: Container(
                  child: Image(image: AssetImage('assets/logotrans.png'))),
            ),
          ),
          Expanded(
            flex: 90,
            child: Center(
              child: Container(
                // Diseño del rectángulo blanco
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Widgets dentro del rectangulo blanco
                  children: [
                    Expanded(
                      flex: 90,
                      child: Container(
                        child: Column(
                          children: [
                            _userField('Correo'),
                            SizedBox(height: 30.0),
                            _passwordField('Contraseña'),
                            SizedBox(height: 30.0),
                            _passwordField('Confirmar Contraseña'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: _registerButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userField(String hint) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          decoration: InputDecoration(
              hintText: hint, fillColor: Colors.white, filled: true),
        ));
  }

  Widget _passwordField(String hint) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: hint, fillColor: Colors.white, filled: true),
        ));
  }

  Widget _registerButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Color(0xffFF5757),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onPressed: () => {
              print('Presionaste Iniciar Sesión'),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()))
            },
        child: SizedBox(
          width: 200.0,
          height: 50.0,
          child: Center(
            child: Text(
              'REGISTRARME',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ));
  }
}
