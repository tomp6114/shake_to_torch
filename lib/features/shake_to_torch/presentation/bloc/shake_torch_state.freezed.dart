// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_torch_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShakeTorchState {
  ShakeSensitivity get sensitivity => throw _privateConstructorUsedError;
  bool get isTorchOn => throw _privateConstructorUsedError;
  bool get isServiceActive => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ShakeTorchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShakeTorchStateCopyWith<ShakeTorchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShakeTorchStateCopyWith<$Res> {
  factory $ShakeTorchStateCopyWith(
          ShakeTorchState value, $Res Function(ShakeTorchState) then) =
      _$ShakeTorchStateCopyWithImpl<$Res, ShakeTorchState>;
  @useResult
  $Res call(
      {ShakeSensitivity sensitivity,
      bool isTorchOn,
      bool isServiceActive,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$ShakeTorchStateCopyWithImpl<$Res, $Val extends ShakeTorchState>
    implements $ShakeTorchStateCopyWith<$Res> {
  _$ShakeTorchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShakeTorchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sensitivity = null,
    Object? isTorchOn = null,
    Object? isServiceActive = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      sensitivity: null == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as ShakeSensitivity,
      isTorchOn: null == isTorchOn
          ? _value.isTorchOn
          : isTorchOn // ignore: cast_nullable_to_non_nullable
              as bool,
      isServiceActive: null == isServiceActive
          ? _value.isServiceActive
          : isServiceActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShakeTorchStateImplCopyWith<$Res>
    implements $ShakeTorchStateCopyWith<$Res> {
  factory _$$ShakeTorchStateImplCopyWith(_$ShakeTorchStateImpl value,
          $Res Function(_$ShakeTorchStateImpl) then) =
      __$$ShakeTorchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ShakeSensitivity sensitivity,
      bool isTorchOn,
      bool isServiceActive,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$ShakeTorchStateImplCopyWithImpl<$Res>
    extends _$ShakeTorchStateCopyWithImpl<$Res, _$ShakeTorchStateImpl>
    implements _$$ShakeTorchStateImplCopyWith<$Res> {
  __$$ShakeTorchStateImplCopyWithImpl(
      _$ShakeTorchStateImpl _value, $Res Function(_$ShakeTorchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShakeTorchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sensitivity = null,
    Object? isTorchOn = null,
    Object? isServiceActive = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ShakeTorchStateImpl(
      sensitivity: null == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as ShakeSensitivity,
      isTorchOn: null == isTorchOn
          ? _value.isTorchOn
          : isTorchOn // ignore: cast_nullable_to_non_nullable
              as bool,
      isServiceActive: null == isServiceActive
          ? _value.isServiceActive
          : isServiceActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ShakeTorchStateImpl implements _ShakeTorchState {
  const _$ShakeTorchStateImpl(
      {this.sensitivity = ShakeSensitivity.medium,
      this.isTorchOn = false,
      this.isServiceActive = false,
      this.isLoading = false,
      this.errorMessage});

  @override
  @JsonKey()
  final ShakeSensitivity sensitivity;
  @override
  @JsonKey()
  final bool isTorchOn;
  @override
  @JsonKey()
  final bool isServiceActive;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ShakeTorchState(sensitivity: $sensitivity, isTorchOn: $isTorchOn, isServiceActive: $isServiceActive, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShakeTorchStateImpl &&
            (identical(other.sensitivity, sensitivity) ||
                other.sensitivity == sensitivity) &&
            (identical(other.isTorchOn, isTorchOn) ||
                other.isTorchOn == isTorchOn) &&
            (identical(other.isServiceActive, isServiceActive) ||
                other.isServiceActive == isServiceActive) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sensitivity, isTorchOn,
      isServiceActive, isLoading, errorMessage);

  /// Create a copy of ShakeTorchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShakeTorchStateImplCopyWith<_$ShakeTorchStateImpl> get copyWith =>
      __$$ShakeTorchStateImplCopyWithImpl<_$ShakeTorchStateImpl>(
          this, _$identity);
}

abstract class _ShakeTorchState implements ShakeTorchState {
  const factory _ShakeTorchState(
      {final ShakeSensitivity sensitivity,
      final bool isTorchOn,
      final bool isServiceActive,
      final bool isLoading,
      final String? errorMessage}) = _$ShakeTorchStateImpl;

  @override
  ShakeSensitivity get sensitivity;
  @override
  bool get isTorchOn;
  @override
  bool get isServiceActive;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of ShakeTorchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShakeTorchStateImplCopyWith<_$ShakeTorchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
