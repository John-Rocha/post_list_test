import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_list_test/app_widget.dart';
import 'package:post_list_test/core/di/inject.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  inject();
  runApp(const AppWidget());
}
