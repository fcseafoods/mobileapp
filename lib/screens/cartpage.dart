import 'dart:convert';

import 'package:fcfreshfoods/components/singlecartitem.dart';
import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/models/CartItem.dart';
import 'package:fcfreshfoods/screens/checkout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  double _total = 0;
  int itemcount = 15;
  String token = "";
  List<CartItem> items = [];

  loaddata() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      token = pref.getString("token")!;
      var resp = await http
          .post(Uri.parse(Constants.host + "product/getcartitem"), headers: {
        'Content-type': 'application/json',
        'token': token,
      });
      var data = json.decode(resp.body);
      _total = data["total"];

      items = (data["data"] as List).map((i) => CartItem.fromJson(i)).toList();

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("My Cart"),
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Container(
        child: items.length != 0
            ? Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: itemcount > 0
                        ? ListView.builder(
                            itemBuilder: (context, index) => SingleCartItem(
                                product_id: items[index].productIdId!,
                                qty: items[index].qty!, onpressed: () async{
                                  try{
                                      Map<String, dynamic> data ={
                                        "cart_id":items[index].cartId,
                                        "product_id":items[index].productIdId
                                      };
                                      http.post(Uri.parse(Constants.host+"product/deletecartitem"), 
                                      headers: {"content-type":"application/json"}, body: json.encode(data));
                                      items.remove(items[index]);
                                      setState(() {
                                        
                                      });
                                  }
                                  catch (e){

                                  }
                                },),
                            itemCount: items.length,
                          )
                        : Center(
                            child: Column(
                              children: [],
                            ),
                          ),
                  ),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height / 1.2),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Row(
                            children: [
                              Text(
                                "Total Amount",
                                textScaleFactor: 1.3,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Rs. ",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _total.toString(),
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (items.length > 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckOut(
                                      cartid: items[0].cartId!,
                                    ),
                                  ));
                            }
                          },
                          child: Text("CheckOut"),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 130,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/emptycart.json'),
                    Text(
                      "Cart is Empty",
                      textScaleFactor: 1.4,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
