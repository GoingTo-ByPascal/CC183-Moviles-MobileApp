import 'package:flutter/material.dart';
import 'package:goingto_app/pages/home.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loginView());
  }

  Widget _loginView() {
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
                  _userField(),
                  _passwordField(),
                  _separator(),
                  _fbButton(),
                  _googleButton(),
                  _loginButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userField() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          decoration: InputDecoration(
              hintText: "Correo", fillColor: Colors.white, filled: true),
        ));
  }

  Widget _passwordField() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Contraseña", fillColor: Colors.white, filled: true),
        ));
  }

  Widget _separator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 220,
          child: Divider(
            color: Colors.black38,
            height: 25,
            indent: 5,
            endIndent: 5,
          ),
        ),
        Text("O", style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          width: 220,
          child: Divider(
            color: Colors.black38,
            height: 25,
            indent: 5,
            endIndent: 5,
          ),
        ),
      ],
    );
  }

  Widget _fbButton() {
    return ElevatedButton(
      style: ButtonStyle(),
      onPressed: () {},
      child: Text("CONTINUAR CON FACEBOOK"),
    );
  }

  Widget _googleButton() {
    return OutlinedButton(
      onPressed: () {},
      child: Text("CONTINUAR CON GOOGLE"),
    );
  }

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: TextButton(
          onPressed: () => {
                print("Presionaste el boton"),
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()))
              },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}
