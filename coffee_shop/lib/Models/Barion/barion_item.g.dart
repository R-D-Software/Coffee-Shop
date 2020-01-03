// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barion_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltBarionItem> _$builtBarionItemSerializer =
    new _$BuiltBarionItemSerializer();

class _$BuiltBarionItemSerializer
    implements StructuredSerializer<BuiltBarionItem> {
  @override
  final Iterable<Type> types = const [BuiltBarionItem, _$BuiltBarionItem];
  @override
  final String wireName = 'BuiltBarionItem';

  @override
  Iterable<Object> serialize(Serializers serializers, BuiltBarionItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'Name',
      serializers.serialize(object.Name, specifiedType: const FullType(String)),
      'Description',
      serializers.serialize(object.Description,
          specifiedType: const FullType(String)),
      'Quantity',
      serializers.serialize(object.Quantity,
          specifiedType: const FullType(int)),
      'Unit',
      serializers.serialize(object.Unit, specifiedType: const FullType(String)),
      'UnitPrice',
      serializers.serialize(object.UnitPrice,
          specifiedType: const FullType(int)),
      'ItemTotal',
      serializers.serialize(object.ItemTotal,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  BuiltBarionItem deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltBarionItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'Name':
          result.Name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Description':
          result.Description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Quantity':
          result.Quantity = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'Unit':
          result.Unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'UnitPrice':
          result.UnitPrice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'ItemTotal':
          result.ItemTotal = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltBarionItem extends BuiltBarionItem {
  @override
  final String Name;
  @override
  final String Description;
  @override
  final int Quantity;
  @override
  final String Unit;
  @override
  final int UnitPrice;
  @override
  final int ItemTotal;

  factory _$BuiltBarionItem([void Function(BuiltBarionItemBuilder) updates]) =>
      (new BuiltBarionItemBuilder()..update(updates)).build();

  _$BuiltBarionItem._(
      {this.Name,
      this.Description,
      this.Quantity,
      this.Unit,
      this.UnitPrice,
      this.ItemTotal})
      : super._() {
    if (Name == null) {
      throw new BuiltValueNullFieldError('BuiltBarionItem', 'Name');
    }
    if (Description == null) {
      throw new BuiltValueNullFieldError('BuiltBarionItem', 'Description');
    }
    if (Quantity == null) {
      throw new BuiltValueNullFieldError('BuiltBarionItem', 'Quantity');
    }
    if (Unit == null) {
      throw new BuiltValueNullFieldError('BuiltBarionItem', 'Unit');
    }
    if (UnitPrice == null) {
      throw new BuiltValueNullFieldError('BuiltBarionItem', 'UnitPrice');
    }
    if (ItemTotal == null) {
      throw new BuiltValueNullFieldError('BuiltBarionItem', 'ItemTotal');
    }
  }

  @override
  BuiltBarionItem rebuild(void Function(BuiltBarionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltBarionItemBuilder toBuilder() =>
      new BuiltBarionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltBarionItem &&
        Name == other.Name &&
        Description == other.Description &&
        Quantity == other.Quantity &&
        Unit == other.Unit &&
        UnitPrice == other.UnitPrice &&
        ItemTotal == other.ItemTotal;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, Name.hashCode), Description.hashCode),
                    Quantity.hashCode),
                Unit.hashCode),
            UnitPrice.hashCode),
        ItemTotal.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltBarionItem')
          ..add('Name', Name)
          ..add('Description', Description)
          ..add('Quantity', Quantity)
          ..add('Unit', Unit)
          ..add('UnitPrice', UnitPrice)
          ..add('ItemTotal', ItemTotal))
        .toString();
  }
}

class BuiltBarionItemBuilder
    implements Builder<BuiltBarionItem, BuiltBarionItemBuilder> {
  _$BuiltBarionItem _$v;

  String _Name;
  String get Name => _$this._Name;
  set Name(String Name) => _$this._Name = Name;

  String _Description;
  String get Description => _$this._Description;
  set Description(String Description) => _$this._Description = Description;

  int _Quantity;
  int get Quantity => _$this._Quantity;
  set Quantity(int Quantity) => _$this._Quantity = Quantity;

  String _Unit;
  String get Unit => _$this._Unit;
  set Unit(String Unit) => _$this._Unit = Unit;

  int _UnitPrice;
  int get UnitPrice => _$this._UnitPrice;
  set UnitPrice(int UnitPrice) => _$this._UnitPrice = UnitPrice;

  int _ItemTotal;
  int get ItemTotal => _$this._ItemTotal;
  set ItemTotal(int ItemTotal) => _$this._ItemTotal = ItemTotal;

  BuiltBarionItemBuilder();

  BuiltBarionItemBuilder get _$this {
    if (_$v != null) {
      _Name = _$v.Name;
      _Description = _$v.Description;
      _Quantity = _$v.Quantity;
      _Unit = _$v.Unit;
      _UnitPrice = _$v.UnitPrice;
      _ItemTotal = _$v.ItemTotal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltBarionItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltBarionItem;
  }

  @override
  void update(void Function(BuiltBarionItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltBarionItem build() {
    final _$result = _$v ??
        new _$BuiltBarionItem._(
            Name: Name,
            Description: Description,
            Quantity: Quantity,
            Unit: Unit,
            UnitPrice: UnitPrice,
            ItemTotal: ItemTotal);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
