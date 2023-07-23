import 'dart:convert';

import 'package:http/http.dart' as http;

class Constants {
  static final String host = "https://fcseafoods.pythonanywhere.com/";
  static final String host_alt = "https://fcseafoods.pythonanywhere.com";

  static addtocart(String authtoken, int product_id) async {
    Map<String , dynamic> data ={
      "product_id":product_id

    };
    var resp = await http.post(
      Uri.parse(Constants.host + "product/addtocart"),
      headers: {
        'Content-type': 'application/json',
        "token":authtoken
      }
      , 
      body: json.encode(data),
    );
  }
}
