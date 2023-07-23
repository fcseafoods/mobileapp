import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/models/productmodel.dart';
import 'package:fcfreshfoods/screens/product_detailed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product extends StatefulWidget {
  const Product(
      {super.key, required this.product,
      });


  final ProductModel product;
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool cart_adding = false;
  
  @override
  Widget build(BuildContext context) {
    print("ajay");
    print(this.widget.product);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailedView(id:this.widget.product.id! ),));
      },
      child: Container(
          padding: EdgeInsets.all(4),
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width/2.1,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.network(Constants.host+"media/"+this.widget.product.productImg1!),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  this.widget.product.productName.toString(),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.1,
                  maxLines: 2,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(widget.product.productWeight!.toString()+" gm"),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    Text(
                      "Rs. " + widget.product.productMrp!.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () async {

                            final SharedPreferences pref = await SharedPreferences.getInstance();
                            if(pref.containsKey("token")){
                              Constants.addtocart(pref.getString("token")!,this.widget.product.id!);

                            }
                            else{
                              Navigator.pushNamed(context,"/loginpage");
                            }
                          setState(() {
                            cart_adding = true;
                          });
                          
                          await Future.delayed(Duration(seconds: 1));
                          setState(() {
                            cart_adding = false;
                          });
                        },
                        child: cart_adding
                            ? Icon(
                                CupertinoIcons.checkmark_alt,
                                size: 37,
                                color: Colors.blue,
                              )
                            : Icon(
                                CupertinoIcons.cart_badge_plus,
                                size: 37,
                                color: Colors.deepOrange,
                              ))
                  ],
                ),
              ),
            ],
          )),
    );
  }

  addtocart( int product_id) async{
    
  }
}
