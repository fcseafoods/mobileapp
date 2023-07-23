import 'dart:convert';

import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/screens/orderplaced_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckOut extends StatefulWidget {
  const CheckOut({
    super.key,
    required this.cartid,
  });
  final int cartid;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

enum payment_methods { cod, online }

class _CheckOutState extends State<CheckOut> {
  payment_methods? methods = payment_methods.cod;
  String _name ="";
  String _addressline1="";
  String _addressline2="";
  String _pincode ="";
  String _phone="";
  String _address =
      ""; //  ="Ajoy Mondal , f6 prantik, asdas daisdi asdj aisd asid jias adjia";
  double _totalbill = 100;
  List<int> product_ids = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  loaddata() async {
    try {
      Map<String, dynamic> data = {"cartid": this.widget.cartid};
      var resp = await http.post(
          Uri.parse(Constants.host + "product/checkout_preview"),
          headers: {
            'Content-type': 'application/json',
          },
          body: json.encode(data));

      var respdata = json.decode(resp.body);
      _totalbill = respdata["total"];
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text("Back"),
        leadingWidth: 27,
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 207, 128, 122),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(CupertinoIcons.check_mark_circled),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Shipping")
                    ],
                  ),
                  SizedBox(
                      width: 80,
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 14),
                        color: Colors.black,
                        height: 2,
                      ))),
                  Column(
                    children: [
                      Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Payment",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                      width: 80,
                      child: Container(
                        margin: EdgeInsets.only(top: 14),
                        color: Colors.black,
                        height: 2,
                      )),
                  Column(
                    children: [
                      Icon(CupertinoIcons.check_mark_circled),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Review")
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Shipping Address",
                textScaleFactor: 1.3,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(17)),
              child: Container(
                child: _address != ""
                    ? InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "SHIPPING TO :",
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0, ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 28,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.25,
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(
                                      _address,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                    ),
                                  )
                                ],
                              ),
                            ), SizedBox(height: 4,)
                          ],
                        ),
                      )
                    : ListTile(
                        title: Text("Add Address"),
                        leading: Icon(CupertinoIcons.add),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:17.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                label: Text("Name "),
                                                prefixIcon:
                                                    Icon(CupertinoIcons.person),border: OutlineInputBorder()),
                                                    validator: (value) {
                                                      if(_name.length!=0){
                                                        return null;
                                                      }
                                                      else{
                                                        return "name is Required";
                                                      }
                                                    },
                                                    onChanged: (value) => setState(() {
                                                      _name=value;
                                                    }),
                                                    keyboardType: TextInputType.name,
                                          ),
                                        ), 
                                        SizedBox(height: 15,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:17.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                label: Text("Phone "),
                                                prefixIcon:
                                                    Icon(CupertinoIcons.phone),border: OutlineInputBorder(),counter: Offstage()),
                                                    validator: (value) {
                                                      if(_phone.length==10){
                                                        return null;
                                                      }
                                                      else{
                                                        return "Phone no must be 10 characters long";
                                                      }
                                                    },
                                                    onChanged: (value) => setState(() {
                                                      _phone=value;
                                                    }),
                                                    maxLength: 10,
                                                    keyboardType: TextInputType.phone,
                                          ),
                                        ),
                                        SizedBox(height: 15,),






                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:17.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                label: Text("Address Line 1 "),
                                                prefixIcon:
                                                    Icon(CupertinoIcons.person),border: OutlineInputBorder()),
                                                    validator: (value) {
                                                      if(_addressline1.length==0){
                                                        return "Addressline 1 is Required";
                                                      }
                                                      else{
                                                        return null;
                                                      }
                                                    },
                                                    onChanged: (value) => setState(() {
                                                      _addressline1=value;
                                                    }),
                                                    keyboardType: TextInputType.text,
                                          ),
                                        ),

                                        SizedBox(height: 17,),


                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:17.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                label: Text("Address Line 2 "),
                                                prefixIcon:
                                                    Icon(CupertinoIcons.person),border: OutlineInputBorder()),
                                                    
                                                    onChanged: (value) => setState(() {
                                                      _addressline2=value;
                                                    }),
                                                    keyboardType: TextInputType.text,
                                          ),
                                        ),
                                        SizedBox(height: 17,),


                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:17.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                label: Text("Pincode "),
                                                prefixIcon:
                                                    Icon(CupertinoIcons.person),border: OutlineInputBorder(),counter: Offstage()),
                                                    validator: (value) {
                                                      if(_pincode.length==6){
                                                        return null;
                                                      }
                                                      else{
                                                        return "pincode must be 6 digit ";
                                                      }
                                                    },
                                                    maxLength: 6,
                                                    onChanged: (value) => setState(() {
                                                      _pincode=value;
                                                    }),
                                                    keyboardType: TextInputType.number,
                                          ),
                                        ), 
                                        SizedBox(height: 17,),
                                        ElevatedButton(onPressed: (){
                                          print(_name);
                                          print(_phone);
                                          print(_addressline1);
                                          print(_addressline2);
                                          print(_pincode);
                                          if(_formKey.currentState!.validate()){
                                            _address =_name+","+_phone+","+_addressline1+","+_addressline2+","+_pincode;
                                            setState(() {
                                              
                                            });
                                            Navigator.pop(context);

                                          }
                                          else{

                                          }
                                          

                                        }, child: Text("Save Address"))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Payment Methods",
                textScaleFactor: 1.3,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('COD'),
              leading: Radio<payment_methods>(
                value: payment_methods.cod,
                groupValue: methods,
                onChanged: (payment_methods? value) {
                  setState(() {
                    methods = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Pay Online'),
              leading: Radio<payment_methods>(
                value: payment_methods.online,
                groupValue: methods,
                onChanged: (payment_methods? value) {
                  setState(() {
                    methods = value;
                    print(value);
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Order Summary",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.3,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        "Total Amount :",
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "Rs. " + _totalbill.toString(),
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        "Taxes(18%)     :",
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "Rs. " + (_totalbill * 0.18).toString(),
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        "Delivery Fees  :",
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "Rs. " + 100.toString(),
                        textScaleFactor: 1.3,
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                      Text(
                        "  Free",
                        textScaleFactor: 1.3,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        "Total Payable  :",
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "Rs. " + _totalbill.toString(),
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                order();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(8),
                height: 55,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 41, 149, 236),
                    borderRadius: BorderRadius.circular(4)),
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Text(
                  "Pay & Place Order",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  order() async {
    if(_address.length !=0){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPlacedpage(),
        ));
    }
    
    
  }
}
