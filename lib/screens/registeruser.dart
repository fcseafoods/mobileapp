import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  const Register({super.key, required this.phone});

  final String phone;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Color.fromARGB(255, 4, 109, 179), leading: IconButton(
    icon: Icon(CupertinoIcons.back, ),
    onPressed: () => Navigator.of(context).pop(),
  )),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 87,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:17.0),
                  child: Text("Hello VIP Guest! Please", textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 4, 109, 179)),),
                ),
                SizedBox(height: 8,),
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:17.0),
                  child: Text("Enter Your Good Name ", textScaleFactor: 1.5, style:
                   TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 109, 179),

                    ),),
                ),
            Form(
              key: _formkey,
              child: Center(
              child: Column(children: [
                
                Container(
                  margin: EdgeInsets.all(17),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      label: Text("Enter Your Name")
                      ),)),



                      SizedBox(height: 17,),
                      Container(
                  margin: EdgeInsets.all(17),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      label: Text("Enter Your Email (optional)")
                      ),
                      keyboardType: TextInputType.emailAddress,)),
                      SizedBox(height: 17),

                      ElevatedButton(onPressed: (){}, child: Text("Save"), style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 97, vertical: 8)),)
                    
              ],
              crossAxisAlignment: CrossAxisAlignment.center,),
            )
            )
          ],
        ),
      ),
    );
  }
}