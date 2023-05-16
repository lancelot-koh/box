

class Product {
  int? _total;
  int? _skip;
  int? _limit;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product({
    required total,
    required skip,
    required limit,
    required products,
  }) {
    this._total = total;
    this._skip = skip;
    this._limit = limit;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _total = json['total'];
    _skip = json['skip'];
    _limit = json['limit'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(new ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  num? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<dynamic>? images;


  ProductModel(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail,
        this.images});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'discountPercentage': this.discountPercentage,
      'rating': this.rating,
      'stock': this.stock,
      'brand': this.brand,
      'category': this.category,
      'thumbnail': this.thumbnail,
      'images': this.images,
    };
  }
}