import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static final Logger instance = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: false,
    ),
  );
}