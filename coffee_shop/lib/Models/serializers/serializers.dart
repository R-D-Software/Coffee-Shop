import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:coffee_shop/Models/Barion/barion_item.dart';
import 'package:coffee_shop/Models/Barion/barion_payment.dart';
import 'package:coffee_shop/Models/Barion/barion_start_response.dart';
import 'package:coffee_shop/Models/Barion/barion_transaction.dart';

part 'serializers.g.dart';

@SerializersFor(const [BuiltBarionPayment, BuiltBarionTransaction, BuiltBarionItem, BuiltBarionStartResponse])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
