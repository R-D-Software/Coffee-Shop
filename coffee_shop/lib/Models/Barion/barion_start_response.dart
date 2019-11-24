import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'barion_start_response.g.dart';

abstract class BuiltBarionStartResponse implements Built<BuiltBarionStartResponse, BuiltBarionStartResponseBuilder> {
  String get GatewayUrl;
  String get PaymentId;

  BuiltBarionStartResponse._();

  factory BuiltBarionStartResponse([updates(BuiltBarionStartResponseBuilder b)]) = _$BuiltBarionStartResponse;

  static Serializer<BuiltBarionStartResponse> get serializer => _$builtBarionStartResponseSerializer;
}
