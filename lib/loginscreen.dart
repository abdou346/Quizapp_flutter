import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizappcontr/question1.dart';
import 'package:quizappcontr/sign%20up.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

final _auth = FirebaseAuth.instance;

final TextEditingController emailController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class _loginscreenState extends State<loginscreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
                height: height,
                width: 400,
                margin: EdgeInsets.only(top: 50, left: 20),
                child: Image.asset(
                  "img/home.png",
                  fit: BoxFit.contain,
                )),
            Container(
              margin: EdgeInsets.only(top: 450, left: 0),
              child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 525, left: 0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 600, left: 250),
              child: RichText(
                text: TextSpan(
                  text: "Forgot your password?",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('The button is clicked!');
                    },
                  style: GoogleFonts.outfit(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 670,
              ),
              child: FlatButton(
                  child: Text("Sign in"),
                  color: const Color(0xffFCA82F),
                  height: 50,
                  minWidth: 400,
                  onPressed: () {
                    signIn(emailController.text, passwordController.text);
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 770, left: 75),
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account ? Register",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Signup())));
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

  void signIn(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: "Login Sucessful"),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => quizz(),
                  ))
            })
        .catchError((e) {
      print(e);
    });
  }
}
