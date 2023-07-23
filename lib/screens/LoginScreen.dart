import 'dart:convert';

import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/screens/varificationpdage.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phone = "";
  bool isloading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkloginstatus();
  }

  checkloginstatus()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("logged_in")){
      bool? logged_in = await prefs.getBool("logged_in");
      if(logged_in!){
        Navigator.pushReplacementNamed(context, "/home");

      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/loginbackground.jpg",
              ),
              fit: BoxFit.fill)),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            height: MediaQuery.of(context).size.height / 2.1,
            width: MediaQuery.of(context).size.width - 17,
            child: ListView(
              children: [
                Text(
                  "   Sign Up / Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5,
                ),
                Divider(),
                Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: TextFormField(
                        decoration: InputDecoration(label: Text("Mobile No")),
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: Text("Login Via OTP"),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 117, vertical: 17)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("by signing in you agree to our"),
                        SizedBox(
                          width: 4,
                        ),
                        InkWell(
                          child: Text(
                            "terms & conditions",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () async {
                            await launchUrl(Uri.parse("https://google.com"));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/home");
                      },
                      child: Text(
                        "Skip",
                        textScaleFactor: 1.4,
                      ),
                    )
                  ],
                )),
              ],
            )),
      ),
    ));
  }

  login() async {
    if (phone.length == 10) {
      try {
        String sessionkey = randomString(10);
        Map<String, String> data = {"phone": phone, "sessionkey": sessionkey};
        var resp = await http.post(
          
            Uri.parse(Constants.host + "customer/getotp"),
            headers: {
              'Content-type': 'application/json',
            },
            body: json.encode(data));
        Map<String, dynamic> respdata = jsonDecode(resp.body);
        if (respdata["status"] == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Varificationpage(
                  sessionkey: sessionkey,
                  phone: phone,
                ),
              ));
        }
      } catch (e) {
        print("error");
      }
    }
  }
}
