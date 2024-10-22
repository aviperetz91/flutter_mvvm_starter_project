import 'package:flutter_mvvm/models/cart_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartItem Model Tests', () {
    test('CartItem fromJson', () {
      final cartItemJson = {
        '_id': '1',
        'productId': 'p1',
        'title': 'Test Product',
        'price': 100.0,
        'brand': 'Test Brand',
        'description': 'Test Description',
        'rating': 4.5,
        'thumbnail': 'http://example.com/image.png',
        'stock': 10,
        'sold': 5,
        'quantity': 2,
        'total': 200.0,
        'discountPercentage': 10.0,
        'discountedPrice': 90.0,
      };

      final cartItem = CartItem.fromJson(cartItemJson);
      expect(cartItem.id, '1');
      expect(cartItem.productId, 'p1');
      expect(cartItem.title, 'Test Product');
      expect(cartItem.price, 100.0);
      expect(cartItem.brand, 'Test Brand');
      expect(cartItem.description, 'Test Description');
      expect(cartItem.rating, 4.5);
      expect(cartItem.thumbnail, 'http://example.com/image.png');
      expect(cartItem.stock, 10);
      expect(cartItem.sold, 5);
      expect(cartItem.quantity, 2);
      expect(cartItem.total, 200.0);
      expect(cartItem.discountPercentage, 10.0);
      expect(cartItem.discountedPrice, 90.0);
    });

    test('CartItem toJson', () {
      final cartItem = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        price: 100.0,
        brand: 'Test Brand',
        description: 'Test Description',
        rating: 4.5,
        thumbnail: 'http://example.com/image.png',
        stock: 10,
        sold: 5,
        quantity: 2,
        total: 200.0,
        discountPercentage: 10.0,
        discountedPrice: 90.0,
      );

      final cartItemJson = cartItem.toJson();
      expect(cartItemJson, {
        '_id': '1',
        'productId': 'p1',
        'title': 'Test Product',
        'price': 100.0,
        'brand': 'Test Brand',
        'description': 'Test Description',
        'rating': 4.5,
        'thumbnail': 'http://example.com/image.png',
        'stock': 10,
        'sold': 5,
        'quantity': 2,
        'total': 200.0,
        'discountPercentage': 10.0,
        'discountedPrice': 90.0,
      });
    });
  });

  group('Cart Model Tests', () {
    test('Cart fromJson', () {
      final cartJson = {
        '_id': '1',
        'totalAmount': 300.0,
        'discountedTotal': 270.0,
        'userId': 'u1',
        'totalProducts': 3,
        'totalQuantity': 5,
        'cartItems': [
          {
            '_id': '1',
            'productId': 'p1',
            'title': 'Test Product',
            'price': 100.0,
            'brand': 'Test Brand',
            'description': 'Test Description',
            'rating': 4.5,
            'thumbnail': 'http://example.com/image.png',
            'stock': 10,
            'sold': 5,
            'quantity': 2,
            'total': 200.0,
            'discountPercentage': 10.0,
            'discountedPrice': 90.0,
          },
          {
            '_id': '2',
            'productId': 'p2',
            'title': 'Another Product',
            'price': 50.0,
            'brand': 'Another Brand',
            'description': 'Another Description',
            'rating': 4.0,
            'thumbnail': 'http://example.com/image2.png',
            'stock': 20,
            'sold': 10,
            'quantity': 1,
            'total': 50.0,
            'discountPercentage': 5.0,
            'discountedPrice': 47.5,
          },
        ],
      };

      final cart = Cart.fromJson(cartJson);
      expect(cart.id, '1');
      expect(cart.totalAmount, 300.0);
      expect(cart.discountedTotal, 270.0);
      expect(cart.userId, 'u1');
      expect(cart.totalProducts, 3);
      expect(cart.totalQuantity, 5);
      expect(cart.cartItems.length, 2);
    });

    test('Cart toJson', () {
      final cart = Cart(
        id: '1',
        totalAmount: 300.0,
        discountedTotal: 270.0,
        userId: 'u1',
        totalProducts: 3,
        totalQuantity: 5,
        cartItems: [
          CartItem(
            id: '1',
            productId: 'p1',
            title: 'Test Product',
            price: 100.0,
            brand: 'Test Brand',
            description: 'Test Description',
            rating: 4.5,
            thumbnail: 'http://example.com/image.png',
            stock: 10,
            sold: 5,
            quantity: 2,
            total: 200.0,
            discountPercentage: 10.0,
            discountedPrice: 90.0,
          ),
          CartItem(
            id: '2',
            productId: 'p2',
            title: 'Another Product',
            price: 50.0,
            brand: 'Another Brand',
            description: 'Another Description',
            rating: 4.0,
            thumbnail: 'http://example.com/image2.png',
            stock: 20,
            sold: 10,
            quantity: 1,
            total: 50.0,
            discountPercentage: 5.0,
            discountedPrice: 47.5,
          ),
        ],
      );

      final cartJson = cart.toJson();
      expect(cartJson, {
        '_id': '1',
        'totalAmount': 300.0,
        'discountedTotal': 270.0,
        'userId': 'u1',
        'totalProducts': 3,
        'totalQuantity': 5,
        'cartItems': [
          {
            '_id': '1',
            'productId': 'p1',
            'title': 'Test Product',
            'price': 100.0,
            'brand': 'Test Brand',
            'description': 'Test Description',
            'rating': 4.5,
            'thumbnail': 'http://example.com/image.png',
            'stock': 10,
            'sold': 5,
            'quantity': 2,
            'total': 200.0,
            'discountPercentage': 10.0,
            'discountedPrice': 90.0,
          },
          {
            '_id': '2',
            'productId': 'p2',
            'title': 'Another Product',
            'price': 50.0,
            'brand': 'Another Brand',
            'description': 'Another Description',
            'rating': 4.0,
            'thumbnail': 'http://example.com/image2.png',
            'stock': 20,
            'sold': 10,
            'quantity': 1,
            'total': 50.0,
            'discountPercentage': 5.0,
            'discountedPrice': 47.5,
          },
        ],
      });
    });
  });
}
