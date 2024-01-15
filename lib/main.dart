import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mvvm/configurations/environment_config.dart';
import 'package:flutter_mvvm/themes/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm/localizations/locale_utils.dart';
import 'package:flutter_mvvm/localizations/locale_manager.dart';

Future<void> main() async {
  await EnvironmentConfig.load(EnvType.dev);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleManager>(create: (_) => LocaleManager()),
        ChangeNotifierProvider<ThemeManager>(create: (_) => ThemeManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleManager, ThemeManager>(
      builder: (context, localeManager, themeManager, child) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeManager.locale,
          theme: themeManager.theme,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late LocaleManager localeManager;
  late ThemeManager themeManager;

  @override
  void initState() {
    super.initState();
    localeManager = Provider.of<LocaleManager>(context, listen: false);
    themeManager = Provider.of<ThemeManager>(context, listen: false);
  }

  void handleLanguageChange(String languageCode) {
    localeManager.setLocale(languageCode);
  }

  void handleThemeChange(String themeType) {
    themeManager.changeTheme(themeType);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
