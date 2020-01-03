// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barion_start_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltBarionStartResponse> _$builtBarionStartResponseSerializer =
    new _$BuiltBarionStartResponseSerializer();

class _$BuiltBarionStartResponseSerializer
    implements StructuredSerializer<BuiltBarionStartResponse> {
  @override
  final Iterable<Type> types = const [
    BuiltBarionStartResponse,
    _$BuiltBarionStartResponse
  ];
  @override
  final String wireName = 'BuiltBarionStartResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, BuiltBarionStartResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'GatewayUrl',
      serializers.serialize(object.GatewayUrl,
          specifiedType: const FullType(String)),
      'PaymentId',
      serializers.serialize(object.PaymentId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BuiltBarionStartResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltBarionStartResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'GatewayUrl':
          result.GatewayUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'PaymentId':
          result.PaymentId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltBarionStartResponse extends BuiltBarionStartResponse {
  @override
  final String GatewayUrl;
  @override
  final String PaymentId;

  factory _$BuiltBarionStartResponse(
          [void Function(BuiltBarionStartResponseBuilder) updates]) =>
      (new BuiltBarionStartResponseBuilder()..update(updates)).build();

  _$BuiltBarionStartResponse._({this.GatewayUrl, this.PaymentId}) : super._() {
    if (GatewayUrl == null) {
      throw new BuiltValueNullFieldError(
          'BuiltBarionStartResponse', 'GatewayUrl');
    }
    if (PaymentId == null) {
      throw new BuiltValueNullFieldError(
          'BuiltBarionStartResponse', 'PaymentId');
    }
  }

  @override
  BuiltBarionStartResponse rebuild(
          void Function(BuiltBarionStartResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltBarionStartResponseBuilder toBuilder() =>
      new BuiltBarionStartResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltBarionStartResponse &&
        GatewayUrl == other.GatewayUrl &&
        PaymentId == other.PaymentId;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, GatewayUrl.hashCode), PaymentId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltBarionStartResponse')
          ..add('GatewayUrl', GatewayUrl)
          ..add('PaymentId', PaymentId))
        .toString();
  }
}

class BuiltBarionStartResponseBuilder
    implements
        Builder<BuiltBarionStartResponse, BuiltBarionStartResponseBuilder> {
  _$BuiltBarionStartResponse _$v;

  String _GatewayUrl;
  String get GatewayUrl => _$this._GatewayUrl;
  set GatewayUrl(String GatewayUrl) => _$this._GatewayUrl = GatewayUrl;

  String _PaymentId;
  String get PaymentId => _$this._PaymentId;
  set PaymentId(String PaymentId) => _$this._PaymentId = PaymentId;

  BuiltBarionStartResponseBuilder();

  BuiltBarionStartResponseBuilder get _$this {
    if (_$v != null) {
      _GatewayUrl = _$v.GatewayUrl;
      _PaymentId = _$v.PaymentId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltBarionStartResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltBarionStartResponse;
  }

  @override
  void update(void Function(BuiltBarionStartResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltBarionStartResponse build() {
    final _$result = _$v ??
        new _$BuiltBarionStartResponse._(
            GatewayUrl: GatewayUrl, PaymentId: PaymentId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
