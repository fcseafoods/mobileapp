import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/models/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailedView extends StatefulWidget {
  const ProductDetailedView({super.key, required this.id});
  final int id;

  @override
  State<ProductDetailedView> createState() => _ProductDetailedViewState();
}

class _ProductDetailedViewState extends State<ProductDetailedView> {
   ProductModel? product;
  List productimg = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String _pincode = "";
  int _checkstatus =0;
  String _pincode_check_msg="";
  String authtoken ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    try {
      Map<String, dynamic> data = {"product_id": this.widget.id};

      var resp =
          await http.post(Uri.parse(Constants.host + "product/product_details"),
              headers: {
                'Content-type': 'application/json',
              },
              body: json.encode(data));

      var jsondata = json.decode(resp.body);
      product = ProductModel.fromJson(jsondata);
      if(product!=null){
        if (product!.productImg1!= "") {
        productimg.add(product!.productImg1);
      }
      if (product!.productImg2 != "") {
        productimg.add(product!.productImg2);
      }
      if (product!.productImg3 != "") {
        productimg.add(product!.productImg3);
      }
      if (product!.productImg4 != "") {
        productimg.add(product!.productImg4);
      }
      }
      setState(() {
        print(productimg);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: product != null
              ? ListView(children: [
                  Container(
                    height: MediaQuery.of(context).size.height -200,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            product!.productName!,
                            textScaleFactor: 1.5,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 250,
                          child: CarouselSlider(
                            items: productimg
                                .map((e) => Image.network(
                                      Constants.host + "media/" + e,
                                      fit: BoxFit.contain,
                                    ))
                                .toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 1.05,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: productimg.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17),
                          child: Text(product!.productShortdesc!),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 10),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.utensils),
                                    SizedBox(
                                      width: 17,
                                    ),
                                    Text("No. of Pieces " +
                                        product!.productPiece.toString())
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                child: Divider(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 10),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.scaleBalanced),
                                    SizedBox(
                                      width: 17,
                                    ),
                                    Text("Weight " +
                                        product!.productWeight.toString() +
                                        " gm")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Text(
                            "SKU CODE : " + product!.productSku.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17.0, vertical: 8),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 17.0),
                                        child: Text("Delivery"),
                                      ),
                                      SizedBox(
                                        width: 17,
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: TextFormField(
                                            textAlignVertical:TextAlignVertical.bottom ,
                                            onChanged: (value) =>
                                                _pincode = value,
                                                
                                            decoration: InputDecoration(
                                        
                                              prefixIcon: Icon(CupertinoIcons
                                                  .location_solid),
                                              counter: Offstage(),
                                            ),
                                            keyboardType: TextInputType.number,
                                            maxLength: 6,
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 17.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              Map<String, String> data = {
                                                "pincode": _pincode
                                              };
                                              var resp = await http.post(
                                                  Uri.parse(Constants.host +
                                                      "customer/check_pincode"),
                                                  headers: {
                                                    'Content-type': 'application/json',
                                                  },
                                                  body: json.encode(data));

                                                  var jsondata = json.decode(resp.body);
                                                  setState(() {
                                                    _pincode_check_msg=jsondata["msg"];
                                                    _checkstatus=jsondata["status"];
                                                    
                                                  });
                                            } catch (e) {
                                              print("error");
                                            }
                                          },
                                          child: Text(
                                            "Check",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text(_pincode_check_msg, style: TextStyle(color: _checkstatus==1?Colors.red:Colors.green),),
                                )
                              ],
                            )),
                        Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17),
                          child: HtmlWidget(
                            product!.productLongdesc!,
                          ),
                        )
                      ],
                    ),
                  ),

                  //This is part of button section
                  Container(
                   
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.2)),
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 17,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.red,
                              size: 30,
                              weight: 1500,
                            ),
                            Text(
                              " " + product!.productMrp.toString(),
                              textScaleFactor: 1.7,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                "MRP : " +
                                    (product!.productMrp! + 100).toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                                textScaleFactor: 1.4),
                            Spacer(),
                            ElevatedButton(
                              onPressed: ()async {
                                 final SharedPreferences pref = await SharedPreferences.getInstance();
                            if(pref.containsKey("token")){
                              Constants.addtocart(pref.getString("token")!,this.widget.id);

                            }
                            else{
                              Navigator.pushNamed(context,"/loginpage");
                            }
                            Navigator.pushNamed(context,"/cart");

                              },
                              child: Text("ADD TO CART"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 92, 12, 7),
                                  foregroundColor: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.shippingFast,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Delivers Today 9 PM  ",
                              textScaleFactor: 1.4,
                              style: TextStyle(),
                            )
                            
                          ],
                        )
                        , SizedBox(height: 8,)
                      ],
                    ),
                  ),
                ])
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
