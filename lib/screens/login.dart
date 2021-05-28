import 'package:flutter/material.dart';
import 'package:goingto_app/screens/home.dart';
import 'package:goingto_app/screens/register.dart';

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
      height: MediaQuery.of(context).size.height,
      color: Color(0xff3490de),
      child: Column(
        children: [
          Expanded(
            flex: 20,
            child: Center(
              child: Container(
                  child: Image(image: AssetImage('assets/logotrans.png'))),
            ),
          ),
          Expanded(
            flex: 80,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(50),
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
                    SizedBox(height: 5.0),
                    _googleButton(),
                    SizedBox(height: 20.0),
                    _loginButton(),
                    SizedBox(height: 40.0),
                    Text(
                      "¿Aún no tienes una cuenta en GoingTo?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 20.0),
                    _registerNavButton(),
                  ],
                ),
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
      style: ElevatedButton.styleFrom(
          primary: Color(0xff4267B2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      onPressed: () {},
      child: SizedBox(
        width: 400.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
              height: 30.0,
            ),
            SizedBox(width: 7.0),
            Text('CONTINUAR CON FACEBOOK'),
          ],
        ),
      ),
    );
  }

  Widget _googleButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
      onPressed: () {},
      child: SizedBox(
        width: 400.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://i.imgur.com/cYIloHu.png',
              height: 30.0,
            ),
            SizedBox(width: 7.0),
            Text('CONTINUAR CON GOOGLE'),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
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
              "INICIAR SESIÓN",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ));
  }

  Widget _registerNavButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onPressed: () => {
              print('Presionaste Registrarme'),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()))
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
