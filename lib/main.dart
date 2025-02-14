import 'package:flutter/material.dart';
import 'package:post_list_test/app_widget.dart';
import 'package:post_list_test/core/di/inject.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  inject();
  runApp(const AppWidget());
}
