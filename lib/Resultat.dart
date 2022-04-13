import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizappcontr/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

import 'package:flutter/cupertino.dart';
import 'question1.dart';

int _email = 0;
Position? position;
double? longitude;
double? latitude;
final geolocator =
    Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
final coordinates = new Coordinates(position!.latitude, position!.longitude);

class resultat extends StatefulWidget {
  const resultat({Key? key}) : super(key: key);

  @override
  State<resultat> createState() => _resultatState();
}

class _resultatState extends State<resultat> {
  late Position? _currentPosition;
  String? Address;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    permission();
    getCurrentLocation();
    getAdressfromlatlong();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'le score est de : ',
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200, left: 100),
              child: SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: ((_email * 100) / 4) / 100,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
                  strokeWidth: 10,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 270, left: 150),
              child: Text(
                ' ${_email * 25}%',
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
                width: 200,
                margin: EdgeInsets.only(top: 700, left: 100),
                child: RaisedButton(
                  child: Text(
                    "Retry",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => quizz())));
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
                    "log out",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    _signOut();
                  },
                  color: Color.fromARGB(255, 236, 237, 243),
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 570),
                child: DelayedDisplay(
                  delay: Duration(seconds: 5),
                  child: Text(
                    "you're located in $Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ))
          ],
        ));
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getInt('intValue') ?? 0);
    });
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    latitude = lat;
    longitude = long;
  }

  permission() async {
    LocationPermission permission = await Geolocator.requestPermission();
  }

  void getAdressfromlatlong() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longitude!);
    print(placemarks);
    Placemark placemark = placemarks[0];
    setState(() {
      Address =
          '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
    });
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    runApp(new MaterialApp(
      home: new loginscreen(),
      debugShowCheckedModeBanner: false,
    ));
  }
}
