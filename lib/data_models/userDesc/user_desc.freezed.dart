// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_desc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDesc _$UserDescFromJson(Map<String, dynamic> json) {
  return _UserDesc.fromJson(json);
}

/// @nodoc
mixin _$UserDesc {
  String get userId => throw _privateConstructorUsedError;
  String? get userIcon => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDescCopyWith<UserDesc> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDescCopyWith<$Res> {
  factory $UserDescCopyWith(UserDesc value, $Res Function(UserDesc) then) =
      _$UserDescCopyWithImpl<$Res, UserDesc>;
  @useResult
  $Res call({String userId, String? userIcon, String userName, String bio});
}

/// @nodoc
class _$UserDescCopyWithImpl<$Res, $Val extends UserDesc>
    implements $UserDescCopyWith<$Res> {
  _$UserDescCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userIcon = freezed,
    Object? userName = null,
    Object? bio = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userIcon: freezed == userIcon
          ? _value.userIcon
          : userIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserDescCopyWith<$Res> implements $UserDescCopyWith<$Res> {
  factory _$$_UserDescCopyWith(
          _$_UserDesc value, $Res Function(_$_UserDesc) then) =
      __$$_UserDescCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String? userIcon, String userName, String bio});
}

/// @nodoc
class __$$_UserDescCopyWithImpl<$Res>
    extends _$UserDescCopyWithImpl<$Res, _$_UserDesc>
    implements _$$_UserDescCopyWith<$Res> {
  __$$_UserDescCopyWithImpl(
      _$_UserDesc _value, $Res Function(_$_UserDesc) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userIcon = freezed,
    Object? userName = null,
    Object? bio = null,
  }) {
    return _then(_$_UserDesc(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userIcon: freezed == userIcon
          ? _value.userIcon
          : userIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserDesc implements _UserDesc {
  _$_UserDesc(
      {required this.userId,
      this.userIcon,
      required this.userName,
      required this.bio});

  factory _$_UserDesc.fromJson(Map<String, dynamic> json) =>
      _$$_UserDescFromJson(json);

  @override
  final String userId;
  @override
  final String? userIcon;
  @override
  final String userName;
  @override
  final String bio;

  @override
  String toString() {
    return 'UserDesc(userId: $userId, userIcon: $userIcon, userName: $userName, bio: $bio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDesc &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userIcon, userIcon) ||
                other.userIcon == userIcon) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.bio, bio) || other.bio == bio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, userIcon, userName, bio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserDescCopyWith<_$_UserDesc> get copyWith =>
      __$$_UserDescCopyWithImpl<_$_UserDesc>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDescToJson(
      this,
    );
  }
}

abstract class _UserDesc implements UserDesc {
  factory _UserDesc(
      {required final String userId,
      final String? userIcon,
      required final String userName,
      required final String bio}) = _$_UserDesc;

  factory _UserDesc.fromJson(Map<String, dynamic> json) = _$_UserDesc.fromJson;

  @override
  String get userId;
  @override
  String? get userIcon;
  @override
  String get userName;
  @override
  String get bio;
  @override
  @JsonKey(ignore: true)
  _$$_UserDescCopyWith<_$_UserDesc> get copyWith =>
      throw _privateConstructorUsedError;
}
