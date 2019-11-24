import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'barion_transaction.dart';

part 'barion_payment.g.dart';

String POSKey = "a3b3a7967c9043729a914472ea093991";

abstract class BuiltBarionPayment implements Built<BuiltBarionPayment, BuiltBarionPaymentBuilder> {
  static String renaoPOSKey = "a3b3a7967c9043729a914472ea093991";

  String get POSKey;
  String get PaymentType;
  String get PaymentRequestId;
  BuiltList<String> get FundingSources;
  String get Currency;
  String get RedirectUrl;
  String get CallbackUrl;
  String get Locale;
  bool get GuestCheckOut;
  BuiltList<BuiltBarionTransaction> get Transactions;

  BuiltBarionPayment._();

  factory BuiltBarionPayment([updates(BuiltBarionPaymentBuilder b)]) = _$BuiltBarionPayment;

  static Serializer<BuiltBarionPayment> get serializer => _$builtBarionPaymentSerializer;
}
