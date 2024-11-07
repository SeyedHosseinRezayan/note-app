import 'package:hive_flutter/hive_flutter.dart';

part 'type_enum.g.dart';

@HiveType(typeId: 6)
enum TypeEnum {
  @HiveField(0)
  working,
  @HiveField(1)
  focus,
  @HiveField(2)
  date
}
