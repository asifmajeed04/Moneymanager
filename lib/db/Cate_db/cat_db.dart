import 'dart:ffi';

import 'package:first/models/Category/cat_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const Cate_Db_Name = 'category_database';

abstract class CatDb {
  Future<List<CatModel>> getCategories();
  Future<void> insertCat(CatModel value);
  Future<void> deleteCategory(String categoryID);
}

class CatDbB implements CatDb {
  CatDbB._internal();
  static CatDbB instance = CatDbB._internal();
  factory CatDbB() {
    return instance;
  }

  ValueNotifier<List<CatModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CatModel>> expenseCategoryList = ValueNotifier([]);
  @override
  Future<void> insertCat(CatModel value) async {
    final _catDB = await Hive.openBox<CatModel>(Cate_Db_Name);
    await _catDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CatModel>> getCategories() async {
    final _catDB = await Hive.openBox<CatModel>(Cate_Db_Name);
    return _catDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(_allCategories, (CatModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryList.value.add(category);
      } else {
        expenseCategoryList.value.add(category);
      }
    });
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _catDB = await Hive.openBox<CatModel>(Cate_Db_Name);
    await _catDB.delete(categoryID);
    refreshUI();
  }
}
