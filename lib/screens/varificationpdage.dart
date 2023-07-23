import 'dart:convert';
import 'package:fcfreshfoods/screens/registeruser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/static.dart';

class Varificationpage extends StatefulWidget {
  const Varificationpage(
      {super.key, required this.sessionkey, required this.phone});
  final String sessionkey;
  final String phone;

  @override
  State<Varificationpage> createState() => _VarificationpageState();
}

class _VarificationpageState extends State<Varificationpage> {
  String otp = "";
  bool incorrectotp = false;
  @override
  Widget build(BuildContext context) {
    print(this.widget.phone);
    print(this.widget.sessionkey);
    return Scaffold(
      appBar: AppBar(
          title: Text("Verify Your Mobile"),
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verification Code",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                textScaleFactor: 1.7,
              ),
              SizedBox(
                height: 27,
              ),
              Text(
                "Please enter the verification code sent",
                style: TextStyle(),
                textScaleFactor: 1.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "To ",
                    style: TextStyle(),
                    textScaleFactor: 1.1,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "+91 ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.1,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    this.widget.phone,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.1,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 47,
              ),
              incorrectotp
                  ? Text(
                      "Incorrect Otp ",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.red),
                    )
                  : SizedBox(height: 8),
              Center(
                  child: Pinput(
                onCompleted: (value) {
                  verifyotp(value);
                },
                onChanged: (value) {
                  setState(() {
                    otp = value;
                  });
                },
              )),
              SizedBox(
                height: 47,
              ),
              Text(
                "Didn't Recieve an OTP ?",
                style: TextStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Text(
                  "Resend OTP ?",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  resendotp();
                },
              ),
              SizedBox(
                height: 17,
              ),
              ElevatedButton(
                onPressed: () {
                  if (otp.length == 4) {
                    verifyotp(otp);
                  }
                },
                child: Text("Verify"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 150)),
              )
            ],
          ),
        ),
      ),
    );
  }

  resendotp() {}
  verifyotp(value) async {
    print(value);
    try {
      Map<String, String> data = {
        "phone": this.widget.phone,
        "sessionkey": this.widget.sessionkey,
        "otp": value
      };
      var resp = await http.post(Uri.parse(Constants.host + "customer/verifyotp"),
          headers: {
            'Content-type': 'application/json',
          },
          body: json.encode(data));
      Map<String, dynamic> respdata = jsonDecode(resp.body);
      print(respdata);
      if (respdata["status"] == 0) {
        final SharedPreferences pref =await SharedPreferences.getInstance();
        await pref.setBool('logged_in', true);
        await pref.setString('token', respdata["token"]);
        Navigator.pushReplacementNamed(context, "/home");
      } else if (respdata["status"] == 5) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(phone: this.widget.phone),
            ));
      } else if (respdata["status"] == 4) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User May be blocked")));
      } else {
        setState(() {
          incorrectotp = true;
        });
      }
    } catch (e) {
      print("error" + e.toString());
    }
  }
}
