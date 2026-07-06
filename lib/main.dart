import 'package:flutter/material.dart';
import 'package:merchant_product_management/app/app.dart';
import 'package:merchant_product_management/di/injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}