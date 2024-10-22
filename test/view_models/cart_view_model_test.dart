import 'package:flutter_mvvm/configurations/environment_config.dart';
import 'package:flutter_mvvm/services/api/api_response.dart';
import 'package:flutter_mvvm/view_models/cart_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  EnvironmentConfig.load(EnvType.dev);

  late CartViewModel cartViewModel;

  String userId = '64fa241c1362947e28100357';
  String productId = '66ba93b2dec7c9cd9bfaf8a5';

  setUp(() {
    cartViewModel = CartViewModel();
  });

  group('CartViewModel', () {
    test('getCartByUserId fetches cart data ', () async {
      await cartViewModel.getCartByUserId(userId);
      expect(cartViewModel.getCartApiResponse.status, Status.completed);
    });

    test('addItemToCart adds an item to the cart', () async {
      await cartViewModel.addItemToCart(userId, productId);
      expect(cartViewModel.addItemToCartApiResponse.status, Status.completed);
    });

    test('removeItemFromCart removes an item from cart', () async {
      await cartViewModel.removeItemFromCart(userId, productId);
      expect(
          cartViewModel.removeItemFromCartApiResponse.status, Status.completed);
    });

    test('deleteCart deletes the cart', () async {
      await cartViewModel.deleteCart(userId);
      expect(cartViewModel.deleteCartApiResponse.status, Status.completed);
    });
  });
}
