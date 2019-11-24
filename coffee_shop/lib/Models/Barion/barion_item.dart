import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'barion_item.g.dart';

abstract class BuiltBarionItem implements Built<BuiltBarionItem, BuiltBarionItemBuilder> {
  String get Name;
  String get Description;
  int get Quantity;
  String get Unit; //piece
  int get UnitPrice;
  int get ItemTotal;

  BuiltBarionItem._();

  factory BuiltBarionItem([updates(BuiltBarionItemBuilder b)]) = _$BuiltBarionItem;

  static Serializer<BuiltBarionItem> get serializer => _$builtBarionItemSerializer;
}
