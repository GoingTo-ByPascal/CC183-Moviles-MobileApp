import 'package:flutter/material.dart';
import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(body: _registerView()),
    );
  }

  Widget _registerView() {
    return Container(
      color: Color(0xff3490de),
      child: Column(
        children: [
          Center(
            child: Container(
                height: 250.0,
                child: Image(image: AssetImage('assets/logotrans.png'))),
          ),
          Center(
            child: Container(
              height: 700.0,
              width: 500.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _userField('Correo'),
                  SizedBox(height: 30.0),
                  _passwordField('Contraseña'),
                  SizedBox(height: 30.0),
                  _passwordField('Confirmar Contraseña'),
                  SizedBox(height: 80.0),
                  _registerButton(),
                ],
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
