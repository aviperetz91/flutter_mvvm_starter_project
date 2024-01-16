class Cart {
  String id;
  double totalAmount;
  double? discountedTotal;
  String userId;
  int totalProducts;
  int totalQuantity;
  List<CartItem> cartItems;

  Cart({
    required this.id,
    required this.totalAmount,
    this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
    required this.cartItems,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<dynamic> cartItemsJson = json['cartItems'];
    List<CartItem> cartItems = cartItemsJson
        .map((cartItemsJson) => CartItem.fromJson(cartItemsJson))
        .toList();
    return Cart(
      id: json['_id'].toString(),
      totalAmount: json['totalAmount'].toDouble(),
      discountedTotal: json['discountedTotal']?.toDouble() ?? 0.0,
      userId: json['userId'].toString(),
      totalProducts: json['totalProducts'],
      totalQuantity: json['totalQuantity'],
      cartItems: cartItems,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? cartItemsJson;
    cartItemsJson = cartItems.map((item) => item.toJson()).toList();

    return {
      '_id': id,
      'totalAmount': totalAmount,
      'discountedTotal': discountedTotal,
      'userId': userId,
      'totalProducts': totalProducts,
      'totalQuantity': totalQuantity,
      'cartItems': cartItemsJson,
    };
  }
}

class CartItem {
  String id;
  String productId;
  String title;
  double price;
  String? brand;
  String? description;
  double? rating;
  String? thumbnail;
  int? stock;
  int? sold;
  int quantity;
  double total;
  double? discountPercentage;
  double? discountedPrice;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    this.brand,
    this.description,
    this.rating,
    this.thumbnail,
    this.stock,
    this.sold,
    required this.quantity,
    required this.total,
    this.discountPercentage,
    this.discountedPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'].toString(),
      productId: json['productId'],
      title: json['title'],
      price: json['price'].toDouble(),
      brand: json['brand'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      thumbnail: json['thumbnail'],
      stock: json['stock'],
      sold: json['sold'],
      quantity: json['quantity'],
      total: json['total'].toDouble(),
      discountPercentage: json['discountPercentage']?.toDouble() ?? 0.0,
      discountedPrice: json['discountedPrice']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'brand': brand,
      'description': description,
      'rating': rating,
      'thumbnail': thumbnail,
      'quantity': quantity,
      'stock': stock,
      'sold': sold,
      'total': total,
      'discountPercentage': discountPercentage,
      'discountedPrice': discountedPrice,
    };
  }
}
