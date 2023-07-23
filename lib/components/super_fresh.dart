import 'package:fcfreshfoods/components/single_product.dart';
import 'package:fcfreshfoods/models/productmodel.dart';
import 'package:flutter/material.dart';


class SuperFresh extends StatefulWidget {
  const SuperFresh({super.key, required this.bestseller});
  final List<ProductModel> bestseller;

  @override
  State<SuperFresh> createState() => _SuperFreshState();
}

class _SuperFreshState extends State<SuperFresh> {
  @override
  Widget build(BuildContext context) {
    return Container(
              height: 250,
              margin: EdgeInsets.only(bottom: 17),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,//this.widget.bestseller.length,
                itemBuilder:(context, index) => Product(product: this.widget.bestseller[0],
                      )
                //       ,
                //        [
                //   Product(
                //       productname:
                //           "Chicken Curry Cut - Large Pieces (Large Pack)",
                //       productiamge: "Image",
                //       productdesc: "description",
                //       productprice: 150.4,
                //       productweight: "500g"),
                //   Product(
                //       productname:
                //           "Chicken Curry Cut - Large Pieces (Large Pack)",
                //       productiamge: "Image",
                //       productdesc: "description",
                //       productprice: 150.4,
                //       productweight: "500g"),
                //   Product(
                //       productname:
                //           "Chicken Curry Cut - Large Pieces (Large Pack)",
                //       productiamge: "Image",
                //       productdesc: "description",
                //       productprice: 150.4,
                //       productweight: "500g")
                // ],
              ),
            );
  }
}