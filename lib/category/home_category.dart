import 'package:first/category/expensec.dart';
import 'package:first/category/incomec.dart';
import 'package:first/db/Cate_db/cat_db.dart';
import 'package:flutter/material.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CatDbB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Color.fromARGB(255, 255, 255, 255),
            indicatorColor: const Color.fromARGB(255, 216, 216, 216),
            tabs: const [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENSE',
              ),
            ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [IncomeC(), Expensec()],
          ),
        ),
      ],
    );
  }
}
