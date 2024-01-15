import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvType { dev, prod }

class EnvironmentConfig {
  static Future<void> load(EnvType type) async {
    await dotenv.load(fileName: '.env.${type.name}');
  }

  static String get baseURL => dotenv.env['baseURL']!;
  static bool get allowNetworkLogs =>
      dotenv.env['allowNetworkLogs']!.toLowerCase() == 'true';
  static int get connectTimeout =>
      int.tryParse(dotenv.env['connectTimeout']!) ?? 3000;
}
