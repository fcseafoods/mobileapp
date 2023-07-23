import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isloggedin = false;
  String token = "";

  checklogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey("token")) {
      isloggedin = true;
      token = pref.getString("token")!;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.1,
        title: Text("Welcome Back !"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Text(
              "Welcome to Licious. Manage your orders, rewards, addresses & other details.",
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 13),
            ),
            SizedBox(
              height: 8,
            ),
            !isloggedin
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/loginpage");
                    },
                    child: Text("Login/Sign Up"),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 17)),
                  )
                : Container(
                    child: Column(
                      children: [
                       
                        SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/orders");

                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.cube_box,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "  Orders",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ]),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/favorites");
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.heart,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "  Favorites",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ]),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.gift,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "  Coupons",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ]),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.headphones,
                                        size: 25,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "  Help Center",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ]),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ListTile(
                          leading: Icon(CupertinoIcons.person_solid, color: Colors.blue,),
                          title: Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Text(">"),
                        ),
                        ListTile(
                          leading: Icon(CupertinoIcons.location_solid,color: Colors.blue),
                          title: Text("Saved Addresses",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Text(">"),
                        ),
                        ListTile(
                          leading: Icon(CupertinoIcons.ticket,color: Colors.blue),
                          title: Text("Support Tickets",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Text(">"),
                        ), 
                        
                      ],
                    ),
                  ),
            SizedBox(
              height: 28,
            ),
            Text(
              "FCFood Zone",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            ListTile(
              leading: Icon(CupertinoIcons.square_list),
              title: Text("Blogs"),
              trailing: Icon(
                CupertinoIcons.greaterthan,
                size: 18,
              ),
              onTap: () {},
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(CupertinoIcons.doc_plaintext),
              title: Text("Terms & Conditions"),
              trailing: Icon(
                CupertinoIcons.greaterthan,
                size: 18,
              ),
              onTap: () {},
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(CupertinoIcons.question_circle),
              title: Text("FAQs"),
              trailing: Icon(
                CupertinoIcons.greaterthan,
                size: 18,
              ),
              onTap: () {},
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(CupertinoIcons.lock_circle),
              title: Text("Privacy Policy"),
              trailing: Icon(
                CupertinoIcons.greaterthan,
                size: 18,
              ),
              onTap: () {},
            ),
            Divider(
              height: 1,
            ), 
            isloggedin?ListTile(leading: Icon(CupertinoIcons.power), title: Text("Logout"),onTap: () async{
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              isloggedin=false;
              setState(() {
                
              });
              
            },):SizedBox()
          ],
        ),
      ),
    );
  }
}
