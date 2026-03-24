import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static Future<void> initEnviroment() async {
    await dotenv.load(fileName: '.env');
  }

  static final String pokeApi =
      dotenv.env['POKE_API'] ??
      (throw AssertionError('POKE_API not found in .env files'));
}
