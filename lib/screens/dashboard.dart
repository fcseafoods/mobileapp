import 'dart:convert';
import 'package:fcfreshfoods/components/best_seller.dart';
import 'package:fcfreshfoods/components/super_fresh.dart';
import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List banners = [
    Image.asset("assets/banner1.png"),
    Image.asset("assets/banner2.jpg"),
    Image.asset("assets/banner3.jpg")
  ];
  bool loaded=false;
  String bannerurl= "";
  List<ProductModel> bestseller=[];
  List<ProductModel> freshest=[];

  loaddata()async{
    try{

    var resp = await http.get(Uri.parse(Constants.host+"product/getbanner"));
        var data = json.decode(resp.body);
        var bstsellerdata = await http.get(Uri.parse(Constants.host+"product/getbestseller"));
        bestseller =(json.decode(bstsellerdata.body) as List).map((i) =>
                  ProductModel.fromJson(i)).cast<ProductModel>().toList();
        
        var rsp= await http.get(Uri.parse(Constants.host+"product/getfreshest"));
        freshest =(json.decode(bstsellerdata.body) as List).map((i) =>
                  ProductModel.fromJson(i)).cast<ProductModel>().toList();

  setState(() {
      bannerurl = Constants.host_alt+data["banner"];
      loaded=true;
    });
    }
    catch (e){
      print(e);
    }
    

    


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  String city = "Kolkata";
  String address = "Select Location";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            Icon(
              Icons.location_pin,
              color: Colors.blue,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                ),
                Text(
                  address,
                  textScaleFactor: 0.7,
                ),
              ],
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/cart");
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 14,
            ),
            Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Image.asset("assets/chicken.png"),
                        ),
                        Text("Chicken")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Image.asset("assets/mutton.png"),
                        ),
                        Text("Mutton")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Image.asset("assets/eggs.png"),
                        ),
                        Text("Eggs")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Image.asset("assets/fish.png"),
                        ),
                        Text("Fish & SeaFoods")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Image.asset("assets/more.png"),
                        ),
                        Text("View All")
                      ],
                    ),
                  )
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:loaded? Image.network(bannerurl):banners[2],
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Best Sellers",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8,),
            Text("Most Popular of Us"),
            SizedBox(
              height: 8,
            ),
            loaded?BestSeller(bestseller: bestseller,):Container(height:250),
            SizedBox(
              height: 8,
            ),
            Text(
              "Super Fresh",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8,),
            Text("Fresher tahn fresh"),
            SizedBox(
              height: 8,
            ),
            SuperFresh(bestseller: freshest,)
          ],
        ),
      ),
    );
  }
}
