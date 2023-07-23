import 'dart:convert';

import 'package:fcfreshfoods/constants/static.dart';
import 'package:fcfreshfoods/models/category.dart';
import 'package:fcfreshfoods/screens/category_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

List<Category> categories=[];
  loaddata() async{

    var resp =await  http.post(Uri.parse(Constants.host+"product/getcategories"));
    categories = (json.decode(resp.body) as List).map((i) =>
              Category.fromJson(i)).toList();
              setState(() {
                
              });


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
        title: Text("Shop By Category"),leading: IconButton(
    icon: Icon(CupertinoIcons.back, ),
    onPressed: () {},
  )
      ),
      body:categories.length!=0? ListView.builder(
        itemBuilder: (context, index) => InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProduct(categoryid: categories[index].getid()),));
              },
              leading: CircleAvatar(backgroundImage:NetworkImage(Constants.host+"media/"+categories[index].getimg())),
            title: Text(categories[index].getname()),
            subtitle: Text(categories[index].getslogan()),
            trailing: Icon(CupertinoIcons.arrow_down,size: 14,), ),
          ),
        ), 
        itemCount: categories.length):Center(child: CircularProgressIndicator()),
    );
  }
}
