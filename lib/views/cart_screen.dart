import 'package:flutter/material.dart';
import 'package:flutter_common_widgets/view_models/error_view_model.dart';
import 'package:flutter_common_widgets/view_models/loading_view_model.dart';
import 'package:flutter_mvvm/services/api/api_response.dart';
import 'package:flutter_mvvm/themes/theme_manager.dart';
import 'package:flutter_mvvm/view_models/cart_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm/localizations/locale_utils.dart';
import 'package:flutter_mvvm/localizations/locale_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late LocaleManager localeManager;
  late ThemeManager themeManager;
  late LoadingViewModel loadingViewModel;
  late ErrorViewModel errorViewModel;
  late CartViewModel cartViewModel;

  String tempUserId = '64fa241c1362947e28100357';
  String tempProductId = "64f9d47e7f200d2d381c9148";

  @override
  void initState() {
    super.initState();
    localeManager = Provider.of<LocaleManager>(context, listen: false);
    themeManager = Provider.of<ThemeManager>(context, listen: false);
    loadingViewModel = Provider.of<LoadingViewModel>(context, listen: false);
    errorViewModel = Provider.of<ErrorViewModel>(context, listen: false);
    cartViewModel = Provider.of<CartViewModel>(context, listen: false);
  }

  void handleLanguageChange(String languageCode) {
    localeManager.setLocale(languageCode);
  }

  void handleThemeChange(String themeType) {
    themeManager.changeTheme(themeType);
  }

  Future<void> getCartByUserId() async {
    loadingViewModel.setLoading(true);
    await cartViewModel.getCartByUserId(tempUserId);
    if (cartViewModel.getCartApiResponse.status == Status.completed) {
      // Handle success
    }
    if (cartViewModel.getCartApiResponse.status == Status.error) {
      errorViewModel.setError(true);
      errorViewModel.setErrorCode(cartViewModel.getCartApiResponse.errorCode);
      errorViewModel.setErrorMessage(
        cartViewModel.getCartApiResponse.errorMessage,
      );
    }
    loadingViewModel.setLoading(false);
  }

  Future<void> addItemToCart() async {
    loadingViewModel.setLoading(true);
    await cartViewModel.addItemToCart(tempUserId, tempProductId);
    if (cartViewModel.addItemToCartApiResponse.status == Status.completed) {
      // Handle success
    }
    if (cartViewModel.addItemToCartApiResponse.status == Status.error) {
      errorViewModel.setError(true);
      errorViewModel
          .setErrorCode(cartViewModel.addItemToCartApiResponse.errorCode);
      errorViewModel.setErrorMessage(
        cartViewModel.addItemToCartApiResponse.errorMessage,
      );
    }
    loadingViewModel.setLoading(false);
  }

  Future<void> removeItemFromCart() async {
    loadingViewModel.setLoading(true);
    await cartViewModel.removeItemFromCart(tempUserId, tempProductId);
    if (cartViewModel.removeItemFromCartApiResponse.status ==
        Status.completed) {
      // Handle success
    }
    if (cartViewModel.removeItemFromCartApiResponse.status == Status.error) {
      errorViewModel.setError(true);
      errorViewModel.setErrorCode(
        cartViewModel.removeItemFromCartApiResponse.errorCode,
      );
      errorViewModel.setErrorMessage(
        cartViewModel.removeItemFromCartApiResponse.errorMessage,
      );
    }
    loadingViewModel.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(translate(context).appName),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.language,
              color: Theme.of(context).colorScheme.primary,
            ),
            onSelected: handleLanguageChange,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: he,
                child: Text(hebrew),
              ),
              const PopupMenuItem<String>(
                value: en,
                child: Text(english),
              ),
            ],
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.visibility,
              color: Theme.of(context).colorScheme.primary,
            ),
            onSelected: handleThemeChange,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: ThemeType.light.name,
                child: Text(ThemeType.light.name),
              ),
              PopupMenuItem<String>(
                value: ThemeType.dark.name,
                child: Text(ThemeType.dark.name),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: getCartByUserId,
              child: const Text('Get Cart By ID'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: addItemToCart,
              child: const Text('Add Item To Cart'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: removeItemFromCart,
              child: const Text('Remove Item From Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
