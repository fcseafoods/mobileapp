class CartItem {
  int? id;
  int? cartId;
  int? productIdId;
  int? qty;

  CartItem({this.id, this.cartId, this.productIdId, this.qty});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    productIdId = json['product_id_id'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['product_id_id'] = this.productIdId;
    data['qty'] = this.qty;
    return data;
  }
}
