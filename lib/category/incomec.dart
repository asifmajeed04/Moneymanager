import 'package:flutter/material.dart';

import '../db/Cate_db/cat_db.dart';
import '../models/Category/cat_model.dart';

class IncomeC extends StatelessWidget {
  const IncomeC({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CatDbB().incomeCategoryList,
        builder: (BuildContext ctx, List<CatModel> newList, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              // ignore: body_might_complete_normally_nullable
              itemBuilder: (ctx, index) {
                final category = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          CatDbB.instance.deleteCategory(category.id);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length);
        });
  }
}
