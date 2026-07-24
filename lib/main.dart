import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pockaw/core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization disabled for local dev/simulator to prevent Core exception with dummy options
  runApp(ProviderScope(child: const MyApp()));
}
