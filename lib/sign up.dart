import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loginscreen.dart';

final _auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController numbercontroller = new TextEditingController();
    double height = MediaQuery.of(context).size.height * 0.4;
    TextEditingController passwordController = new TextEditingController();
    String _password = '';
    final TextEditingController fullnamecontroller =
        new TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 90),
              child: Text(
                "Sign up ",
                style: GoogleFonts.outfit(
                  textStyle:
                      TextStyle(fontSize: 60, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
                height: height,
                width: 300,
                margin: EdgeInsets.only(top: 100, left: 50),
                child: Image.asset(
                  "img/signup.png",
                  fit: BoxFit.contain,
                )),
            Container(
              margin: EdgeInsets.only(top: 410, left: 0),
              child: TextFormField(
                controller: fullnamecontroller,
                decoration: InputDecoration(
                  labelText: "Full name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 510, left: 0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 610),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field is required';
                  }
                  if (value.trim().length < 8) {
                    return 'Password must be at least 8 characters in length';
                  }
                  // Return null if the entered password is valid
                  return 'lolol';
                },
                onChanged: (value) => _password = value,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 700,
              ),
              child: FlatButton(
                  child: Text("Submit"),
                  textColor: Colors.white,
                  color: const Color(0xffFCA82F),
                  height: 50,
                  minWidth: 400,
                  onPressed: () {
                    Register(emailController.text, _password);
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 800, left: 100),
              child: RichText(
                text: TextSpan(
                  text: "Already registered ? Log in",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => loginscreen(),
                          ));
                    },
                  style: GoogleFonts.outfit(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void Register(String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: "Registred Sucessfuly"),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => loginscreen(),
                  ))
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
