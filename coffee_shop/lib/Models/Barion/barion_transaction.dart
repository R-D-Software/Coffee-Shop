import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'barion_item.dart';

part 'barion_transaction.g.dart';

abstract class BuiltBarionTransaction implements Built<BuiltBarionTransaction, BuiltBarionTransactionBuilder> {
  String get POSTransactionId;
  String get Payee; //tranzakciót fogadó fél barion fiókjának e-mail címe (saját)
  int get Total;
  BuiltList<BuiltBarionItem> get Items;

  BuiltBarionTransaction._();

  factory BuiltBarionTransaction([updates(BuiltBarionTransactionBuilder b)]) = _$BuiltBarionTransaction;

  static Serializer<BuiltBarionTransaction> get serializer => _$builtBarionTransactionSerializer;
}
