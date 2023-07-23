import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderPlacedpage extends StatefulWidget {
  const OrderPlacedpage({super.key});

  @override
  State<OrderPlacedpage> createState() => _OrderPlacedpageState();
}

class _OrderPlacedpageState extends State<OrderPlacedpage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirect();
  }
  redirect()async{
    await Future.delayed(Duration(seconds: 7));
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Lottie.asset("assets/orderplaced.json"),
        Material(
            child: Text(
          "Order Placed",
          textScaleFactor: 2,
          style: TextStyle(fontWeight: FontWeight.bold),
        ))
      ]),
    );
  }
}
