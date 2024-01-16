import 'package:flutter_mvvm/services/api/api_endpoints.dart';
import 'package:flutter_mvvm/services/api/api_service.dart';

class CartRepository {
  late ApiService _apiService;

  CartRepository() {
    _apiService = ApiService();
  }

  Future<dynamic> getCartByUserId(String userId) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.getCartByUserId.replaceFirst('{userId}', userId),
        {},
        {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addItemToCart(
    String userId,
    String productId, {
    int index = 0,
    int quantity = 1,
  }) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.addItemToCart
            .replaceFirst('{userId}', userId)
            .replaceFirst('{productId}', productId),
        {
          "index": index,
          "quantity": quantity,
        },
        {},
        {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> removeItemFromCart(
    String userId,
    String productId, {
    bool decreaseQuantity = false,
  }) async {
    try {
      final response = await _apiService.delete(
        ApiEndpoints.removeItemFromCart
            .replaceFirst('{userId}', userId)
            .replaceFirst('{productId}', productId),
        {"action": decreaseQuantity ? 'decrease' : 'delete'},
        {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
