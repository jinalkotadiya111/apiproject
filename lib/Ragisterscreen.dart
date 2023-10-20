import 'dart:convert';
import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:apiproject/Currentlocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:apiproject/Loginscreen1.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/User.dart';




class Ragisterscreen extends StatefulWidget {
  const Ragisterscreen({Key? key}) : super(key: key);

  @override
  State<Ragisterscreen> createState() => _RagisterscreenState();
}

class _RagisterscreenState extends State<Ragisterscreen> {
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    // Set up a timer to update the current time every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      getCurrentTime();
    });
    getCurrentTime(); // Get the initial current time
  }

  void getCurrentTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(
        now); // Format the time as desired
    setState(() {
      currentTime = formattedTime;
    });
  }

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }



  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _conformpassword = TextEditingController();
  TextEditingController _email = TextEditingController();

  var name = "";
  var password = "";
  var conformpassword = "";
  var email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RAGISTER SCREEN"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15.0,),
              Text("NAME",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),),
              SizedBox(height: 15.0,),
              TextField(
                controller: _name,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  labelText: "ENTER NAME",
                  fillColor: Colors.green.shade900,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),

              Text("E-MAIL",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),),
              SizedBox(height: 15.0,),
              TextField(
                controller: _email,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  labelText: "ENTER E-MAIL",
                  fillColor: Colors.green.shade900,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Text("PASSWORD",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),),
              SizedBox(height: 15.0,),
              TextField(
                controller: _password,
                decoration: new InputDecoration(
                  labelText: "ENTER PASSWORD",
                  fillColor: Colors.green.shade900,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Text("CONFORM PASSWORD",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),),
              SizedBox(height: 15.0,),
              TextField(
                controller: _conformpassword,
                decoration: new InputDecoration(
                  labelText: "ENTER CONFORM PASSWORD",
                  fillColor: Colors.green.shade900,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Text(
                'Current Time: $currentTime',
                style: TextStyle(fontSize: 24),
                 ),

              SizedBox(height: 15.0,),
              Text("Current address",style: TextStyle(fontSize: 20),),
              SizedBox(height: 10.0,),
              Text('LAT: ${_currentPosition?.latitude ?? ""}',style: TextStyle(fontSize: 20),)
              , SizedBox(height: 10.0,),
              Text('LNG: ${_currentPosition?.longitude ?? ""}',style: TextStyle(fontSize: 20),),
              SizedBox(height: 10.0,),
              Text('ADDRESS: ${_currentAddress ?? ""}',style: TextStyle(fontSize: 20),),
              const SizedBox(height: 32),

              ElevatedButton(onPressed: () async {
                var name = _name.text.toString();
                var email = _email.text.toString();
                var password = _password.text.toString();
                var conformpassword = _conformpassword.text.toString();


                // show date and address

                // show date and address


                if (name == "") {
                  var snackBar = SnackBar(
                    content: Text(
                      'please enter name',
                      style: TextStyle(color: Colors.black),
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.black,
                      onPressed: () {
                        print("Undo");
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else if (email == "") {
                  var snackBar = SnackBar(
                    content: Text(
                      'please enter email',
                      style: TextStyle(color: Colors.black),
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.black,
                      onPressed: () {
                        print("Undo");
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else if (password == "") {
                  var snackBar = SnackBar(
                    content: Text(
                      'please enter password',
                      style: TextStyle(color: Colors.black),
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.black,
                      onPressed: () {
                        print("Undo");
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else if (conformpassword == "") {
                  var snackBar = SnackBar(
                    content: Text(
                      'please enter conform password',
                      style: TextStyle(color: Colors.black),
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.black,
                      onPressed: () {
                        print("Undo");
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else if (password == conformpassword) {
                  Uri url = Uri.parse("https://begratefulapp.ca/api/register");

                  var params =
                  {
                    "name": name,
                    "email": email,
                    "password": password,
                    "confirm_password": conformpassword,
                    "device_token": "12345678",
                    "device_os": "android",
                    "version_type": "openness",
                    "group": "2",
                    "version": "1",
                    "time_zone": "IST",
                    "ip_address": "103.232.125.6",

                  };

                  var hed = {
                    "Content-Type": "application/json"
                  };

                  var response = await http.post(url, body: jsonEncode(params),
                      headers: hed);
                  if (response.statusCode == 200) {
                    var json = jsonDecode(response.body);
                    if (json["result"] == "success") {
                      var message = json["message"].toString();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                            message, style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.green,)
                      );
                    }
                    else {
                      var message = json["message"].toString();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                            message, style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.red,)
                      );
                    }
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Loginscreen1())
                    );
                  }
                }
                else {
                  var snackBar = SnackBar(
                    content: Text(
                      'password or conform password dose not match',
                      style: TextStyle(color: Colors.black),
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.black,
                      onPressed: () {
                        print("Undo");
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }, child: Text("SUBMITE")),
               ElevatedButton(onPressed: (){
                 _getCurrentPosition();
              },
                child: Text("currnt location"))
            ],
          ),
        ),
      ),
    );
  }
}
