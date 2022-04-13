import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class firebasesignin extends StatefulWidget {
  const firebasesignin({Key? key}) : super(key: key);

  @override
  State<firebasesignin> createState() => _firebasesigninState();
}

final _auth = FirebaseAuth.instance;

class _firebasesigninState extends State<firebasesignin> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void signIn(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: "Login Sucessful"),
            })
        .catchError((e) {
      print(e);
    });
  }
}
