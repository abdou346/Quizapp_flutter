import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizappcontr/question4.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Question_model.dart';
import 'Resultat.dart';
import 'loginscreen.dart';

int _counter = 0;

class question3 extends StatefulWidget {
  const question3({Key? key}) : super(key: key);

  @override
  State<question3> createState() => _question3State();
}

class _question3State extends State<question3> {
  @override
  String? answer;
  QuestionModel? a;
  String? choix1;
  String? choix2;
  String? choix3;
  String? enonce;
  String? reponse;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    bool? vchoix1 = false;
    bool? vchoix2 = false;
    bool? vchoix3 = false;
    bool? venonce = false;
    bool? vreponse = false;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 80),
              child: Text(
                'Question 3',
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 130, left: 70),
              child: Text(
                '$enonce',
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
                height: height,
                width: 400,
                margin: EdgeInsets.only(
                  top: 150,
                ),
                child: Image.asset(
                  "img/ney.png",
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                )),
            Container(
                width: 200,
                margin: EdgeInsets.only(top: 500, left: 100),
                child: RaisedButton(
                  child: Text(
                    "$choix1",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => question4())));
                    answer = choix1;
                  },
                  color: Color.fromARGB(255, 236, 237, 243),
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )),
            Container(
                width: 200,
                margin: EdgeInsets.only(top: 600, left: 100),
                child: RaisedButton(
                  child: Text(
                    "$choix2",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => question4())));
                    answer = choix2;
                    addIntToSF();
                  },
                  color: Color.fromARGB(255, 236, 237, 243),
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )),
            Container(
                width: 200,
                margin: EdgeInsets.only(top: 700, left: 100),
                child: RaisedButton(
                  child: Text(
                    "$choix3",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => question4())));
                    answer = choix3;
                  },
                  color: Color.fromARGB(255, 236, 237, 243),
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )),
          ],
        ));
  }

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('quiz1')
        .doc('question3')
        .get()
        .then((value) {
      this.a = QuestionModel.fromMap(value.data());
      choix1 = a?.choix1;
      choix2 = a?.choix2;
      choix3 = a?.choix3;
      enonce = a?.enonce;
      reponse = a?.reponse;
      setState(() {});
      _loadCounter();
    });
  }

  void checkanswer() {
    if (answer == reponse) {
      addIntToSF();
    }
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('intValue') ?? 0);
    });
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', _counter + 1);
  }
}
