import 'package:flutter/material.dart';
import 'package:flutter_mvvm/services/api/api_response.dart';
import 'package:flutter_mvvm/themes/theme_manager.dart';
import 'package:flutter_mvvm/utils/error_handler.dart';
import 'package:flutter_mvvm/view_models/cart_view_model.dart';
import 'package:flutter_mvvm/view_models/error_view_model.dart';
import 'package:flutter_mvvm/view_models/loading_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm/localizations/locale_utils.dart';
import 'package:flutter_mvvm/localizations/locale_manager.dart';
import 'package:flutter_mvvm/utils/string_extensions.dart';

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

  @override
  void initState() {
    super.initState();
    localeManager = Provider.of<LocaleManager>(context, listen: false);
    themeManager = Provider.of<ThemeManager>(context, listen: false);
    loadingViewModel = Provider.of<LoadingViewModel>(context, listen: false);
    errorViewModel = Provider.of<ErrorViewModel>(context, listen: false);
    cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    initCartData();
  }

  void handleLanguageChange(String languageCode) {
    localeManager.setLocale(languageCode);
  }

  void handleThemeChange(String themeType) {
    themeManager.changeTheme(themeType);
  }

  Future<void> initCartData() async {
    if (cartViewModel.cart == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        loadingViewModel.setLoading(true);
        await cartViewModel.getCartByUserId(tempUserId);
        if (cartViewModel.getCartApiResponse.status == Status.completed) {
          // Do something, for example displaying a snackbar or success modal
        }
        if (cartViewModel.getCartApiResponse.status == Status.error) {
          handleError(
            cartViewModel.getCartApiResponse.errorCode,
            cartViewModel.getCartApiResponse.errorMessage,
          );
        }
        loadingViewModel.setLoading(false);
      });
    }
  }

  Future<void> addItemToCart(String productId) async {
    await cartViewModel.addItemToCart(tempUserId, productId);
    if (cartViewModel.addItemToCartApiResponse.status == Status.completed) {
      // Do something, for example displaying a snackbar or success modal
    }
    if (cartViewModel.addItemToCartApiResponse.status == Status.error) {
      handleError(
        cartViewModel.addItemToCartApiResponse.errorCode,
        cartViewModel.addItemToCartApiResponse.errorMessage,
      );
    }
  }

  Future<void> removeItemFromCart(String productId) async {
    await cartViewModel.removeItemFromCart(
      tempUserId,
      productId,
      decreaseQuantity: true,
    );
    if (cartViewModel.removeItemFromCartApiResponse.status ==
        Status.completed) {
      // Do something, for example displaying a snackbar or success modal
    }
    if (cartViewModel.removeItemFromCartApiResponse.status == Status.error) {
      handleError(
        cartViewModel.removeItemFromCartApiResponse.errorCode,
        cartViewModel.removeItemFromCartApiResponse.errorMessage,
      );
    }
  }

  Future<void> deleteCart() async {
    loadingViewModel.setLoading(true);
    await cartViewModel.deleteCart(tempUserId);
    if (cartViewModel.deleteCartApiResponse.status == Status.completed) {
      // Do something, for example displaying a snackbar or success modal
    }
    if (cartViewModel.deleteCartApiResponse.status == Status.error) {
      handleError(
        cartViewModel.deleteCartApiResponse.errorCode,
        cartViewModel.deleteCartApiResponse.errorMessage,
      );
    }
    loadingViewModel.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CartViewModel, LoadingViewModel>(
      builder: (context, cartViewModel, loadingViewModel, child) {
        if (loadingViewModel.isLoading) {
          return const SizedBox();
        } else if (cartViewModel.cart != null &&
            cartViewModel.cart!.cartItems.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(translate(context).appName,
                  style: const TextStyle(fontSize: 16)),
              actions: [
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.language,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onSelected: handleLanguageChange,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: he,
                      child: Text(hebrew, style: TextStyle(fontSize: 18)),
                    ),
                    const PopupMenuItem<String>(
                      value: en,
                      child: Text(english, style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.visibility,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onSelected: handleThemeChange,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: ThemeType.light.name,
                      child: Text(ThemeType.light.name,
                          style: const TextStyle(fontSize: 18)),
                    ),
                    PopupMenuItem<String>(
                      value: ThemeType.dark.name,
                      child: Text(ThemeType.dark.name,
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
            body: SizedBox(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: cartViewModel.cart!.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartViewModel.cart!.cartItems[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: 8,
                          ),
                          leading: Image.network(
                            cartItem.thumbnail!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            cartItem.title,
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () => removeItemFromCart(
                                    cartItem.productId,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(22, 22),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                OutlinedButton(
                                  onPressed: () => addItemToCart(
                                    cartItem.productId,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(22, 22),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Text(
                            '\$${cartItem.price.toStringAsFixed(2).toPrice()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  translate(context).total,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$${cartViewModel.cart!.totalAmount.toStringAsFixed(2).toPrice()}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.delete_forever),
                                  onPressed: deleteCart,
                                  label: Text(translate(context).clearCart),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/empty_cart.png',
                          width: 180,
                          height: 180,
                        ),
                        Text(
                          translate(context).emptyCartScreenTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          translate(context).emptyCartScreenSubtitle,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
