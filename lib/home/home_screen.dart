// ignore_for_file: avoid_print

import 'package:first/category/Cat_add_pop.dart';
import 'package:first/category/home_category.dart';
import 'package:first/db/Cate_db/cat_db.dart';
import 'package:first/home/add_trans/screen_add_trans.dart';
import 'package:first/home/widgets/bottomnav.dart';
import 'package:first/models/Category/cat_model.dart';
import 'package:first/transaction/home_transaction.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  homeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTrans(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(221, 0, 0, 0),
      bottomNavigationBar: const MoneyBottomNav(),
      appBar: AppBar(
        title: Text(
          'MONEY MANAGER  ',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transaction');
            Navigator.of(context).pushNamed(ScreenaddTrans.routeName);
          } else {
            print('Add Category');
            showCatAddPop(context);

            //final _sample = CatModel(
            //    id: DateTime.now().millisecondsSinceEpoch.toString(),
            //  name: 'Travel',
            //   type: CategoryType.expense);
            // CatDbB().insertCat(_sample);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
