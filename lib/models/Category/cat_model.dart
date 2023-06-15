import 'package:hive/hive.dart';
part 'cat_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CatModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  CatModel(
      {required this.id,
      required this.name,
      this.isDeleted = false,
      required this.type});

  @override
  String toString() {
    return '{$name $type}';
  }
}
