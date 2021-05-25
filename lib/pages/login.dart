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
    return Scaffold(body: loginView());
  }

  Widget loginView() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/originals/88/58/03/8858035f8643b1f2d213ac3b2fd522ae.png"),
                fit: BoxFit.cover)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginTitle(),
            userField(),
            passwordField(),
            SizedBox(
              height: 10.0,
            ),
            loginButton()
          ],
        )));
  }

  Widget loginTitle() {
    return Text(
      "Inicia Sesión",
      style: TextStyle(
        color: Colors.black,
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget userField() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextField(
          decoration: InputDecoration(
              hintText: "Usuario", fillColor: Colors.white, filled: true),
        ));
  }

  Widget passwordField() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Contraseña", fillColor: Colors.white, filled: true),
        ));
  }

  Widget loginButton() {
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
