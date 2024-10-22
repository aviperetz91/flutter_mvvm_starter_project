import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/configurations/environment_config.dart';
import 'package:flutter_mvvm/repositories/cart_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  EnvironmentConfig.load(EnvType.dev);

  Dio dio = Dio();

  late DioAdapter adapter;
  late CartRepository cartRepository;

  String userId = '64fa241c1362947e28100357';
  String productId = '66ba93b2dec7c9cd9bfaf8a5';

  setUp(() {
    adapter = DioAdapter(dio: dio);
    cartRepository = CartRepository();
  });

  Future<Map<String, dynamic>> loadMockData(String path) async {
    final String response = await rootBundle.loadString(path);
    return json.decode(response);
  }

  group('CartRepository Tests', () {
    test('getCartByUserId returns cart data', () async {
      final getCartByUserIdMockResponse =
          await loadMockData('assets/mock_data/Get_Cart_By_User_ID.json');

      adapter.onGet(
        'Get_Cart_By_User_ID',
        (server) => server.reply(200, getCartByUserIdMockResponse),
      );

      final response = await cartRepository.getCartByUserId(userId);

      expect(response['userId'], getCartByUserIdMockResponse['userId']);
      expect(
          response['totalAmount'], getCartByUserIdMockResponse['totalAmount']);
      expect(response['totalProducts'],
          getCartByUserIdMockResponse['totalProducts']);
      expect(response['totalQuantity'],
          getCartByUserIdMockResponse['totalQuantity']);
    });

    test('addItemToCart adds item to cart', () async {
      final addItemToCartMockResponse =
          await loadMockData('assets/mock_data/Add_Item_To_Cart.json');

      adapter.onPost(
        'Add_Item_To_Cart',
        (server) => server.reply(200, addItemToCartMockResponse),
      );

      final response = await cartRepository.addItemToCart(userId, productId);

      expect(response['userId'], addItemToCartMockResponse['userId']);
      expect(response['totalAmount'], addItemToCartMockResponse['totalAmount']);
      expect(response['totalProducts'],
          addItemToCartMockResponse['totalProducts']);
      expect(response['totalQuantity'],
          addItemToCartMockResponse['totalQuantity']);
    });

    test('removeItemFromCart removes item from cart', () async {
      final removeItemFromCartMockResponse =
          await loadMockData('assets/mock_data/Remove_Item_From_Cart.json');

      adapter.onPost(
        'Remove_Item_From_Cart',
        (server) => server.reply(200, removeItemFromCartMockResponse),
      );

      final response = await cartRepository
          .removeItemFromCart(userId, productId, decreaseQuantity: true);

      expect(response['userId'], removeItemFromCartMockResponse['userId']);
      expect(response['totalAmount'],
          removeItemFromCartMockResponse['totalAmount']);
      expect(response['totalProducts'],
          removeItemFromCartMockResponse['totalProducts']);
      expect(response['totalQuantity'],
          removeItemFromCartMockResponse['totalQuantity']);
    });

    test('deleteCart deletes the cart', () async {
      final deleteCartMockResponse =
          await loadMockData('assets/mock_data/Delete_Cart.json');

      adapter.onDelete(
        'Delete_Cart',
        (server) => server.reply(200, deleteCartMockResponse),
      );

      final response = await cartRepository.deleteCart(userId);
      expect(response, isNull);
    });
  });
}
