// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barion_payment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltBarionPayment> _$builtBarionPaymentSerializer =
    new _$BuiltBarionPaymentSerializer();

class _$BuiltBarionPaymentSerializer
    implements StructuredSerializer<BuiltBarionPayment> {
  @override
  final Iterable<Type> types = const [BuiltBarionPayment, _$BuiltBarionPayment];
  @override
  final String wireName = 'BuiltBarionPayment';

  @override
  Iterable<Object> serialize(Serializers serializers, BuiltBarionPayment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'POSKey',
      serializers.serialize(object.POSKey,
          specifiedType: const FullType(String)),
      'PaymentType',
      serializers.serialize(object.PaymentType,
          specifiedType: const FullType(String)),
      'PaymentRequestId',
      serializers.serialize(object.PaymentRequestId,
          specifiedType: const FullType(String)),
      'FundingSources',
      serializers.serialize(object.FundingSources,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'Currency',
      serializers.serialize(object.Currency,
          specifiedType: const FullType(String)),
      'RedirectUrl',
      serializers.serialize(object.RedirectUrl,
          specifiedType: const FullType(String)),
      'CallbackUrl',
      serializers.serialize(object.CallbackUrl,
          specifiedType: const FullType(String)),
      'Locale',
      serializers.serialize(object.Locale,
          specifiedType: const FullType(String)),
      'GuestCheckOut',
      serializers.serialize(object.GuestCheckOut,
          specifiedType: const FullType(bool)),
      'Transactions',
      serializers.serialize(object.Transactions,
          specifiedType: const FullType(
              BuiltList, const [const FullType(BuiltBarionTransaction)])),
    ];

    return result;
  }

  @override
  BuiltBarionPayment deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltBarionPaymentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'POSKey':
          result.POSKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'PaymentType':
          result.PaymentType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'PaymentRequestId':
          result.PaymentRequestId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'FundingSources':
          result.FundingSources.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'Currency':
          result.Currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'RedirectUrl':
          result.RedirectUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'CallbackUrl':
          result.CallbackUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Locale':
          result.Locale = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'GuestCheckOut':
          result.GuestCheckOut = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'Transactions':
          result.Transactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltBarionTransaction)
              ])) as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltBarionPayment extends BuiltBarionPayment {
  @override
  final String POSKey;
  @override
  final String PaymentType;
  @override
  final String PaymentRequestId;
  @override
  final BuiltList<String> FundingSources;
  @override
  final String Currency;
  @override
  final String RedirectUrl;
  @override
  final String CallbackUrl;
  @override
  final String Locale;
  @override
  final bool GuestCheckOut;
  @override
  final BuiltList<BuiltBarionTransaction> Transactions;

  factory _$BuiltBarionPayment(
          [void Function(BuiltBarionPaymentBuilder) updates]) =>
      (new BuiltBarionPaymentBuilder()..update(updates)).build();

  _$BuiltBarionPayment._(
      {this.POSKey,
      this.PaymentType,
      this.PaymentRequestId,
      this.FundingSources,
      this.Currency,
      this.RedirectUrl,
      this.CallbackUrl,
      this.Locale,
      this.GuestCheckOut,
      this.Transactions})
      : super._() {
    if (POSKey == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'POSKey');
    }
    if (PaymentType == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'PaymentType');
    }
    if (PaymentRequestId == null) {
      throw new BuiltValueNullFieldError(
          'BuiltBarionPayment', 'PaymentRequestId');
    }
    if (FundingSources == null) {
      throw new BuiltValueNullFieldError(
          'BuiltBarionPayment', 'FundingSources');
    }
    if (Currency == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'Currency');
    }
    if (RedirectUrl == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'RedirectUrl');
    }
    if (CallbackUrl == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'CallbackUrl');
    }
    if (Locale == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'Locale');
    }
    if (GuestCheckOut == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'GuestCheckOut');
    }
    if (Transactions == null) {
      throw new BuiltValueNullFieldError('BuiltBarionPayment', 'Transactions');
    }
  }

  @override
  BuiltBarionPayment rebuild(
          void Function(BuiltBarionPaymentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltBarionPaymentBuilder toBuilder() =>
      new BuiltBarionPaymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltBarionPayment &&
        POSKey == other.POSKey &&
        PaymentType == other.PaymentType &&
        PaymentRequestId == other.PaymentRequestId &&
        FundingSources == other.FundingSources &&
        Currency == other.Currency &&
        RedirectUrl == other.RedirectUrl &&
        CallbackUrl == other.CallbackUrl &&
        Locale == other.Locale &&
        GuestCheckOut == other.GuestCheckOut &&
        Transactions == other.Transactions;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, POSKey.hashCode),
                                        PaymentType.hashCode),
                                    PaymentRequestId.hashCode),
                                FundingSources.hashCode),
                            Currency.hashCode),
                        RedirectUrl.hashCode),
                    CallbackUrl.hashCode),
                Locale.hashCode),
            GuestCheckOut.hashCode),
        Transactions.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltBarionPayment')
          ..add('POSKey', POSKey)
          ..add('PaymentType', PaymentType)
          ..add('PaymentRequestId', PaymentRequestId)
          ..add('FundingSources', FundingSources)
          ..add('Currency', Currency)
          ..add('RedirectUrl', RedirectUrl)
          ..add('CallbackUrl', CallbackUrl)
          ..add('Locale', Locale)
          ..add('GuestCheckOut', GuestCheckOut)
          ..add('Transactions', Transactions))
        .toString();
  }
}

class BuiltBarionPaymentBuilder
    implements Builder<BuiltBarionPayment, BuiltBarionPaymentBuilder> {
  _$BuiltBarionPayment _$v;

  String _POSKey;
  String get POSKey => _$this._POSKey;
  set POSKey(String POSKey) => _$this._POSKey = POSKey;

  String _PaymentType;
  String get PaymentType => _$this._PaymentType;
  set PaymentType(String PaymentType) => _$this._PaymentType = PaymentType;

  String _PaymentRequestId;
  String get PaymentRequestId => _$this._PaymentRequestId;
  set PaymentRequestId(String PaymentRequestId) =>
      _$this._PaymentRequestId = PaymentRequestId;

  ListBuilder<String> _FundingSources;
  ListBuilder<String> get FundingSources =>
      _$this._FundingSources ??= new ListBuilder<String>();
  set FundingSources(ListBuilder<String> FundingSources) =>
      _$this._FundingSources = FundingSources;

  String _Currency;
  String get Currency => _$this._Currency;
  set Currency(String Currency) => _$this._Currency = Currency;

  String _RedirectUrl;
  String get RedirectUrl => _$this._RedirectUrl;
  set RedirectUrl(String RedirectUrl) => _$this._RedirectUrl = RedirectUrl;

  String _CallbackUrl;
  String get CallbackUrl => _$this._CallbackUrl;
  set CallbackUrl(String CallbackUrl) => _$this._CallbackUrl = CallbackUrl;

  String _Locale;
  String get Locale => _$this._Locale;
  set Locale(String Locale) => _$this._Locale = Locale;

  bool _GuestCheckOut;
  bool get GuestCheckOut => _$this._GuestCheckOut;
  set GuestCheckOut(bool GuestCheckOut) =>
      _$this._GuestCheckOut = GuestCheckOut;

  ListBuilder<BuiltBarionTransaction> _Transactions;
  ListBuilder<BuiltBarionTransaction> get Transactions =>
      _$this._Transactions ??= new ListBuilder<BuiltBarionTransaction>();
  set Transactions(ListBuilder<BuiltBarionTransaction> Transactions) =>
      _$this._Transactions = Transactions;

  BuiltBarionPaymentBuilder();

  BuiltBarionPaymentBuilder get _$this {
    if (_$v != null) {
      _POSKey = _$v.POSKey;
      _PaymentType = _$v.PaymentType;
      _PaymentRequestId = _$v.PaymentRequestId;
      _FundingSources = _$v.FundingSources?.toBuilder();
      _Currency = _$v.Currency;
      _RedirectUrl = _$v.RedirectUrl;
      _CallbackUrl = _$v.CallbackUrl;
      _Locale = _$v.Locale;
      _GuestCheckOut = _$v.GuestCheckOut;
      _Transactions = _$v.Transactions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltBarionPayment other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltBarionPayment;
  }

  @override
  void update(void Function(BuiltBarionPaymentBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltBarionPayment build() {
    _$BuiltBarionPayment _$result;
    try {
      _$result = _$v ??
          new _$BuiltBarionPayment._(
              POSKey: POSKey,
              PaymentType: PaymentType,
              PaymentRequestId: PaymentRequestId,
              FundingSources: FundingSources.build(),
              Currency: Currency,
              RedirectUrl: RedirectUrl,
              CallbackUrl: CallbackUrl,
              Locale: Locale,
              GuestCheckOut: GuestCheckOut,
              Transactions: Transactions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'FundingSources';
        FundingSources.build();

        _$failedField = 'Transactions';
        Transactions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BuiltBarionPayment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
