import 'dart:convert';

import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/models/productmodel.dart';
import 'package:fcfreshfoods/screens/product_detailed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingleCartItem extends StatefulWidget {
  const SingleCartItem(
      {super.key, required this.product_id, required this.qty, required this.onpressed});
  final int product_id;
  final int qty;
  final VoidCallback onpressed;

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
   ProductModel? product;

  loaddata() async {
    try {
      Map<String, dynamic> data = {"product_id": this.widget.product_id};

      var resp =
          await http.post(Uri.parse(Constants.host + "product/product_details"),
              headers: {
                'Content-type': 'application/json',
              },
              body: json.encode(data));

      var jsondata = json.decode(resp.body);
      product = ProductModel.fromJson(jsondata);
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 130,
              width: 150,
              decoration: BoxDecoration(
                  color: product == null?Colors.grey:Colors.white, borderRadius: BorderRadius.circular(17)),
              child: product != null
                  ? InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailedView(id: this.widget.product_id),));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17) ,
                        child: Image.network(
                            Constants.host + "media/" + product!.productImg1!)),
                  )
                  : SizedBox(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product != null?product!.productName.toString():"",
                    softWrap: true,
                    textScaleFactor: 1.2,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        color: Colors.blue,
                      ),
                      Text(
                        "" + "165.00",
                        textScaleFactor: 1.4,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: this.widget.onpressed,
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        " Qty ",
                        textScaleFactor: 1.4,
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      InkWell(child: Icon(Icons.remove)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        this.widget.qty.toString(),
                        textScaleFactor: 1.4,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(child: Icon(Icons.add)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
