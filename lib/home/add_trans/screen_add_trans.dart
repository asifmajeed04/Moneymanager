import 'package:first/db/Cate_db/cat_db.dart';
import 'package:first/db/trans_db/trans_db.dart';
import 'package:first/models/Category/cat_model.dart';
import 'package:first/models/Transacation/trans_model.dart';
import 'package:flutter/material.dart';

class ScreenaddTrans extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTrans({super.key});

  @override
  State<ScreenaddTrans> createState() => _ScreenaddTransState();
}

class _ScreenaddTransState extends State<ScreenaddTrans> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CatModel? _selectedcategoryModel;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _purposeTextEditingController,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount')),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateT = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 60)),
                  lastDate: DateTime.now(),
                );
                if (_selectedDateT == null) {
                  return;
                } else {
                  print(_selectedDateT.toString());
                  setState(() {
                    _selectedDate = _selectedDateT;
                  });
                }
              },
              icon: Icon(Icons.calendar_today_outlined),
              label: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate!.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: _selectedCategorytype,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategorytype = CategoryType.income;
                          _categoryID = null;
                        });
                      },
                    ),
                    Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: _selectedCategorytype,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategorytype = CategoryType.expense;
                          _categoryID = null;
                        });
                      },
                    ),
                    Text('Expense'),
                  ],
                ),
              ],
            ),

            //Category Type

            DropdownButton<String>(
              hint: const Text('Select Category'),
              value: _categoryID,
              items: (_selectedCategorytype == CategoryType.income
                      ? CatDbB().incomeCategoryList
                      : CatDbB().expenseCategoryList)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    print(e.toString());
                    _selectedcategoryModel = e;
                  },
                );
              }).toList(),
              onChanged: (selectedValue) {
                print(selectedValue);
                setState(() {
                  _categoryID = selectedValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                addTransaction();
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    //if (_categoryID == null) {
    //  return;
    //}
    if (_selectedDate == null) {
      return;
    }
    if (_selectedcategoryModel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    //  _selectedCategorytype
    //_categoryID
    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedcategoryModel!,
    );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
