import 'dart:convert';
import 'package:fcfreshfoods/components/single_product.dart';
import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/models/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({super.key, required this.categoryid});

  final int categoryid;

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  List<ProductModel> products = [];
  var height = 1.0;

  void getdata() async {
    try {
      Map<String, dynamic> encodedata = {"category": this.widget.categoryid};
      print(encodedata);
      var resp = await http.post(
          Uri.parse(Constants.host + "product/getcategoryproduct"),
          headers: {
            'Content-type': 'application/json',
          },
          body: json.encode(encodedata));
      products = (json.decode(resp.body) as List)
          .map((i) => ProductModel.fromJson(i))
          .toList();
    } catch (e) {
      print(e);
    }
    setState(() {});
    print(products);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 27,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    products.length.toString() + " Items",
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            color: Colors.amber,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Modal BottomSheet'),
                                  ElevatedButton(
                                    child: const Text('Close BottomSheet'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.square_fill_line_vertical_square_fill,
                          color: Colors.cyan,
                          size: 20,
                        ),
                        Text("  Filter",
                            style: TextStyle(
                              fontSize: 19,
                            ))
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: MediaQuery.of(context).size.height - 130,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.70),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.all(4),
                      height: 400,
                      width: MediaQuery.of(context).size.width / 2.1,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [Product(product: products[index])]));
                },
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final SharedPreferences pref = await SharedPreferences.getInstance();
                            if(pref.containsKey("token")){
                              Navigator.pushNamed(context,"/cart");
                            }
                            else{
                              Navigator.pushNamed(context,"/loginpage");
                            }
                          setState(() {
                          });
                          
        },
        child: Icon(FontAwesomeIcons.cartShopping),
      ),
    );
  }
}
