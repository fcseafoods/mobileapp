class ProductModel {
  int? _id;
  String? _productSku;
  String? _productName;
  int? _productCategoryId;
  Null _productSubcategoryId;
  String? _productShortdesc;
  String? _productLongdesc;
  double? _productMrp;
  int? _productTaxrate;
  int? _productWeight;
  int? _productPiece;
  int? _productStock;
  bool? _productIsactive;
  String? _productImg1;
  String? _productImg2;
  String? _productImg3;
  String? _productImg4;
  String? _createdAt;
  String? _modifiedAt;

  ProductModel(
      {int? id,
      String? productSku,
      String? productName,
      int? productCategoryId,
      Null productSubcategoryId,
      String? productShortdesc,
      String? productLongdesc,
      double? productMrp,
      int? productTaxrate,
      int? productWeight,
      int? productPiece,
      int? productStock,
      bool? productIsactive,
      String? productImg1,
      String? productImg2,
      String? productImg3,
      String? productImg4,
      String? createdAt,
      String? modifiedAt}) {
    this._id = id;
    this._productSku = productSku;
    this._productName = productName;
    this._productCategoryId = productCategoryId;
    this._productSubcategoryId = productSubcategoryId;
    this._productShortdesc = productShortdesc;
    this._productLongdesc = productLongdesc;
    this._productMrp = productMrp;
    this._productTaxrate = productTaxrate;
    this._productWeight = productWeight;
    this._productPiece = productPiece;
    this._productStock = productStock;
    this._productIsactive = productIsactive;
    this._productImg1 = productImg1;
    this._productImg2 = productImg2;
    this._productImg3 = productImg3;
    this._productImg4 = productImg4;
    this._createdAt = createdAt;
    this._modifiedAt = modifiedAt;
  }
  ProductModel.fromJson(Map<String?, dynamic> json) {
    _id = json['id'];
    _productSku = json['product_sku'];
    _productName = json['product_name'];
    _productCategoryId = json['product_category_id'];
    _productSubcategoryId = json['product_subcategory_id'];
    _productShortdesc = json['product_shortdesc'];
    _productLongdesc = json['product_longdesc'];
    _productMrp = json['product_mrp'];
    _productTaxrate = json['product_taxrate'];
    _productWeight = json['product_weight'];
    _productPiece = json['product_piece'];
    _productStock = json['product_stock'];
    _productIsactive = json['product_isactive'];
    _productImg1 = json['product_img1'];
    _productImg2 = json['product_img2'];
    _productImg3 = json['product_img3'];
    _productImg4 = json['product_img4'];
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this._id;
    data['product_sku'] = this._productSku;
    data['product_name'] = this._productName;
    data['product_category_id'] = this._productCategoryId;
    data['product_subcategory_id'] = this._productSubcategoryId;
    data['product_shortdesc'] = this._productShortdesc;
    data['product_longdesc'] = this._productLongdesc;
    data['product_mrp'] = this._productMrp;
    data['product_taxrate'] = this._productTaxrate;
    data['product_weight'] = this._productWeight;
    data['product_piece'] = this._productPiece;
    data['product_stock'] = this._productStock;
    data['product_isactive'] = this._productIsactive;
    data['product_img1'] = this._productImg1;
    data['product_img2'] = this._productImg2;
    data['product_img3'] = this._productImg3;
    data['product_img4'] = this._productImg4;
    data['created_at'] = this._createdAt;
    data['modified_at'] = this._modifiedAt;
    return data;
  }
  

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get productSku => _productSku;
  set productSku(String? productSku) => _productSku = productSku;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  int? get productCategoryId => _productCategoryId;
  set productCategoryId(int? productCategoryId) =>
      _productCategoryId = productCategoryId;
  Null get productSubcategoryId => _productSubcategoryId;
  set productSubcategoryId(Null productSubcategoryId) =>
      _productSubcategoryId = productSubcategoryId;
  String? get productShortdesc => _productShortdesc;
  set productShortdesc(String? productShortdesc) =>
      _productShortdesc = productShortdesc;
  String? get productLongdesc => _productLongdesc;
  set productLongdesc(String? productLongdesc) =>
      _productLongdesc = productLongdesc;
  double? get productMrp => _productMrp;
  set productMrp(double? productMrp) => _productMrp = productMrp;
  int? get productTaxrate => _productTaxrate;
  set productTaxrate(int? productTaxrate) => _productTaxrate = productTaxrate;
  int? get productWeight => _productWeight;
  set productWeight(int? productWeight) => _productWeight = productWeight;
  int? get productPiece => _productPiece;
  set productPiece(int? productPiece) => _productPiece = productPiece;
  int? get productStock => _productStock;
  set productStock(int? productStock) => _productStock = productStock;
  bool? get productIsactive => _productIsactive;
  set productIsactive(bool? productIsactive) =>
      _productIsactive = productIsactive;
  String? get productImg1 => _productImg1;
  set productImg1(String? productImg1) => _productImg1 = productImg1;
  String? get productImg2 => _productImg2;
  set productImg2(String? productImg2) => _productImg2 = productImg2;
  String? get productImg3 => _productImg3;
  set productImg3(String? productImg3) => _productImg3 = productImg3;
  String? get productImg4 => _productImg4;
  set productImg4(String? productImg4) => _productImg4 = productImg4;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get modifiedAt => _modifiedAt;
  set modifiedAt(String? modifiedAt) => _modifiedAt = modifiedAt;


}
