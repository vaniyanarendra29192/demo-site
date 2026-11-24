// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_contract.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApplicationData extends ApplicationData {
  @override
  final ScreenState state;
  @override
  final String? errorMessage;

  factory _$ApplicationData([void Function(ApplicationDataBuilder)? updates]) =>
      (ApplicationDataBuilder()..update(updates))._build();

  _$ApplicationData._({required this.state, this.errorMessage}) : super._();
  @override
  ApplicationData rebuild(void Function(ApplicationDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApplicationDataBuilder toBuilder() => ApplicationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplicationData &&
        state == other.state &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApplicationData')
          ..add('state', state)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class ApplicationDataBuilder
    implements Builder<ApplicationData, ApplicationDataBuilder> {
  _$ApplicationData? _$v;

  ScreenState? _state;
  ScreenState? get state => _$this._state;
  set state(ScreenState? state) => _$this._state = state;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  ApplicationDataBuilder();

  ApplicationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _state = $v.state;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplicationData other) {
    _$v = other as _$ApplicationData;
  }

  @override
  void update(void Function(ApplicationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApplicationData build() => _build();

  _$ApplicationData _build() {
    final _$result =
        _$v ??
        _$ApplicationData._(
          state: BuiltValueNullFieldError.checkNotNull(
            state,
            r'ApplicationData',
            'state',
          ),
          errorMessage: errorMessage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
