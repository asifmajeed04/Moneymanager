// ignore: file_names
import 'package:first/db/Cate_db/cat_db.dart';
import 'package:first/models/Category/cat_model.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> selectedCategoryNoti =
    ValueNotifier(CategoryType.income);

Future<void> showCatAddPop(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text("Add Category"),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add Details '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                RadioButton(title: "Income", type: CategoryType.income),
                RadioButton(title: "Expense", type: CategoryType.expense)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                final _name = _nameEditingController.text;
                if (_name.isEmpty) {
                  return;
                }
                final _type = selectedCategoryNoti.value;
                final _categoty = CatModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type);
                CatDbB.instance.insertCat(_categoty);
                Navigator.of(ctx).pop();
              },
              child: const Text('ADD'),
            ),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNoti,
            builder: (BuildContext ctx, CategoryType newCategoty, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newCategoty,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNoti.value = value;
                    selectedCategoryNoti.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
