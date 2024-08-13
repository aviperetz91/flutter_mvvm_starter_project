import 'package:flutter/material.dart';
import 'package:flutter_mvvm/models/cart_model.dart';
import 'package:flutter_mvvm/repositories/cart_repository.dart';
import 'package:flutter_mvvm/services/api/api_exception.dart';
import 'package:flutter_mvvm/services/api/api_response.dart';

class CartViewModel with ChangeNotifier {
  late CartRepository _cartRepository;

  Cart? _cart;

  Cart? get cart => _cart;

  CartViewModel() {
    _cartRepository = CartRepository();
  }

  ApiResponse getCartApiResponse = ApiResponse.initial();
  ApiResponse addItemToCartApiResponse = ApiResponse.initial();
  ApiResponse removeItemFromCartApiResponse = ApiResponse.initial();
  ApiResponse deleteCartApiResponse = ApiResponse.initial();

  void setCart(ApiResponse response) {
    if (response.data != null) {
      var resData = response.data as Map<String, dynamic>;
      if (resData.isNotEmpty) {
        _cart = Cart.fromJson(resData);
      }
      notifyListeners();
    }
  }

  Future<void> getCartByUserId(String userId) async {
    try {
      getCartApiResponse = ApiResponse.loading();
      dynamic responseJson = await _cartRepository.getCartByUserId(userId);
      getCartApiResponse = ApiResponse.completed(responseJson);
      setCart(getCartApiResponse);
    } catch (error) {
      getCartApiResponse = ApiResponse.error(
        error is ApiException ? error.code : null,
        error is ApiException ? error.message : error.toString(),
      );
    }
  }

  Future<void> addItemToCart(
    String userId,
    String productId, {
    int index = 0,
    quantity = 1,
  }) async {
    try {
      addItemToCartApiResponse = ApiResponse.loading();
      dynamic responseJson = await _cartRepository.addItemToCart(
        userId,
        productId,
        index: index,
        quantity: quantity,
      );
      addItemToCartApiResponse = ApiResponse.completed(responseJson);
      setCart(addItemToCartApiResponse);
    } catch (error) {
      addItemToCartApiResponse = ApiResponse.error(
        error is ApiException ? error.code : null,
        error is ApiException ? error.message : error.toString(),
      );
    }
  }

  Future<void> removeItemFromCart(
    String userId,
    String productId, {
    bool decreaseQuantity = false,
  }) async {
    try {
      removeItemFromCartApiResponse = ApiResponse.loading();
      dynamic responseJson = await _cartRepository.removeItemFromCart(
        userId,
        productId,
        decreaseQuantity: decreaseQuantity,
      );
      removeItemFromCartApiResponse = ApiResponse.completed(responseJson);
      setCart(removeItemFromCartApiResponse);
    } catch (error) {
      removeItemFromCartApiResponse = ApiResponse.error(
        error is ApiException ? error.code : null,
        error is ApiException ? error.message : error.toString(),
      );
    }
  }

  Future<void> deleteCart(String userId) async {
    try {
      deleteCartApiResponse = ApiResponse.loading();
      dynamic responseJson = await _cartRepository.deleteCart(
        userId,
      );
      deleteCartApiResponse = ApiResponse.completed(responseJson);
      setCart(deleteCartApiResponse);
    } catch (error) {
      deleteCartApiResponse = ApiResponse.error(
        error is ApiException ? error.code : null,
        error is ApiException ? error.message : error.toString(),
      );
    }
  }
}
