import 'package:closure/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config.dart';
import 'providers/provider.dart';
import 'views/login_view.dart';

void main() async {
  await Supabase.initialize(
    url: AppConfig.projectUrlSupabase,
    anonKey: AppConfig.anonKeySupabase,
  );
  await Hive.initFlutter();
  await Hive.openBox('chatCache');
  await Hive.openBox('chatRooms');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationServiceProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      home: loginView(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
