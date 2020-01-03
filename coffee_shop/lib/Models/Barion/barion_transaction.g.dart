// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barion_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltBarionTransaction> _$builtBarionTransactionSerializer =
    new _$BuiltBarionTransactionSerializer();

class _$BuiltBarionTransactionSerializer
    implements StructuredSerializer<BuiltBarionTransaction> {
  @override
  final Iterable<Type> types = const [
    BuiltBarionTransaction,
    _$BuiltBarionTransaction
  ];
  @override
  final String wireName = 'BuiltBarionTransaction';

  @override
  Iterable<Object> serialize(
      Serializers serializers, BuiltBarionTransaction object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'POSTransactionId',
      serializers.serialize(object.POSTransactionId,
          specifiedType: const FullType(String)),
      'Payee',
      serializers.serialize(object.Payee,
          specifiedType: const FullType(String)),
      'Total',
      serializers.serialize(object.Total, specifiedType: const FullType(int)),
      'Items',
      serializers.serialize(object.Items,
          specifiedType: const FullType(
              BuiltList, const [const FullType(BuiltBarionItem)])),
    ];

    return result;
  }

  @override
  BuiltBarionTransaction deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltBarionTransactionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'POSTransactionId':
          result.POSTransactionId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Payee':
          result.Payee = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Total':
          result.Total = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'Items':
          result.Items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BuiltBarionItem)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltBarionTransaction extends BuiltBarionTransaction {
  @override
  final String POSTransactionId;
  @override
  final String Payee;
  @override
  final int Total;
  @override
  final BuiltList<BuiltBarionItem> Items;

  factory _$BuiltBarionTransaction(
          [void Function(BuiltBarionTransactionBuilder) updates]) =>
      (new BuiltBarionTransactionBuilder()..update(updates)).build();

  _$BuiltBarionTransaction._(
      {this.POSTransactionId, this.Payee, this.Total, this.Items})
      : super._() {
    if (POSTransactionId == null) {
      throw new BuiltValueNullFieldError(
          'BuiltBarionTransaction', 'POSTransactionId');
    }
    if (Payee == null) {
      throw new BuiltValueNullFieldError('BuiltBarionTransaction', 'Payee');
    }
    if (Total == null) {
      throw new BuiltValueNullFieldError('BuiltBarionTransaction', 'Total');
    }
    if (Items == null) {
      throw new BuiltValueNullFieldError('BuiltBarionTransaction', 'Items');
    }
  }

  @override
  BuiltBarionTransaction rebuild(
          void Function(BuiltBarionTransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltBarionTransactionBuilder toBuilder() =>
      new BuiltBarionTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltBarionTransaction &&
        POSTransactionId == other.POSTransactionId &&
        Payee == other.Payee &&
        Total == other.Total &&
        Items == other.Items;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, POSTransactionId.hashCode), Payee.hashCode),
            Total.hashCode),
        Items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltBarionTransaction')
          ..add('POSTransactionId', POSTransactionId)
          ..add('Payee', Payee)
          ..add('Total', Total)
          ..add('Items', Items))
        .toString();
  }
}

class BuiltBarionTransactionBuilder
    implements Builder<BuiltBarionTransaction, BuiltBarionTransactionBuilder> {
  _$BuiltBarionTransaction _$v;

  String _POSTransactionId;
  String get POSTransactionId => _$this._POSTransactionId;
  set POSTransactionId(String POSTransactionId) =>
      _$this._POSTransactionId = POSTransactionId;

  String _Payee;
  String get Payee => _$this._Payee;
  set Payee(String Payee) => _$this._Payee = Payee;

  int _Total;
  int get Total => _$this._Total;
  set Total(int Total) => _$this._Total = Total;

  ListBuilder<BuiltBarionItem> _Items;
  ListBuilder<BuiltBarionItem> get Items =>
      _$this._Items ??= new ListBuilder<BuiltBarionItem>();
  set Items(ListBuilder<BuiltBarionItem> Items) => _$this._Items = Items;

  BuiltBarionTransactionBuilder();

  BuiltBarionTransactionBuilder get _$this {
    if (_$v != null) {
      _POSTransactionId = _$v.POSTransactionId;
      _Payee = _$v.Payee;
      _Total = _$v.Total;
      _Items = _$v.Items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltBarionTransaction other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltBarionTransaction;
  }

  @override
  void update(void Function(BuiltBarionTransactionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltBarionTransaction build() {
    _$BuiltBarionTransaction _$result;
    try {
      _$result = _$v ??
          new _$BuiltBarionTransaction._(
              POSTransactionId: POSTransactionId,
              Payee: Payee,
              Total: Total,
              Items: Items.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'Items';
        Items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BuiltBarionTransaction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
