import 'package:first/home/add_trans/screen_add_trans.dart';
import 'package:first/home/home_screen.dart';
import 'package:first/models/Category/cat_model.dart';
import 'package:first/models/Transacation/trans_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CatModelAdapter().typeId)) {
    Hive.registerAdapter(CatModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homeScreen(),
      routes: {
        ScreenaddTrans.routeName: (ctx) => const ScreenaddTrans(),
      },
    );
  }
}
