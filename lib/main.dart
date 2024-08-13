import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mvvm/configurations/environment_config.dart';
import 'package:flutter_mvvm/localizations/locale_utils.dart';
import 'package:flutter_mvvm/services/navigation/navigation_service.dart';
import 'package:flutter_mvvm/themes/theme_manager.dart';
import 'package:flutter_mvvm/view_models/cart_view_model.dart';
import 'package:flutter_mvvm/view_models/error_view_model.dart';
import 'package:flutter_mvvm/view_models/loading_view_model.dart';
import 'package:flutter_mvvm/views/cart_screen.dart';
import 'package:flutter_mvvm/views/error_screen.dart';
import 'package:flutter_mvvm/views/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm/localizations/locale_manager.dart';

Future<void> main() async {
  await EnvironmentConfig.load(EnvType.dev);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleManager>(create: (_) => LocaleManager()),
        ChangeNotifierProvider<ThemeManager>(create: (_) => ThemeManager()),
        ChangeNotifierProvider<LoadingViewModel>(
          create: (_) => LoadingViewModel(),
        ),
        ChangeNotifierProvider<ErrorViewModel>(
          create: (_) => ErrorViewModel(),
        ),
        ChangeNotifierProvider<CartViewModel>(
          create: (_) => CartViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer4<LocaleManager, ThemeManager, LoadingViewModel,
        ErrorViewModel>(
      builder: (
        context,
        localeManager,
        themeManager,
        loadingViewModel,
        errorViewModel,
        child,
      ) {
        return MaterialApp(
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                const LoadingScreen(),
                ErrorScreen(
                  icon: Icons.warning_amber,
                  title: translate(context).errorSceenTitle,
                  subtitle: errorViewModel.errorMessage ??
                      translate(context).errorScreenSubtitle,
                )
              ],
            );
          },
          navigatorKey: NavigationService.navigatorKey,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeManager.locale,
          theme: themeManager.theme,
          home: const CartScreen(),
        );
      },
    );
  }
}
