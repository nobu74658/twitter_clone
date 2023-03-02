// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tweet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Tweet _$TweetFromJson(Map<String, dynamic> json) {
  return _Tweet.fromJson(json);
}

/// @nodoc
mixin _$Tweet {
  String get tweetId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String? get userIcon => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  int get favoriteNum => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TweetCopyWith<Tweet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TweetCopyWith<$Res> {
  factory $TweetCopyWith(Tweet value, $Res Function(Tweet) then) =
      _$TweetCopyWithImpl<$Res, Tweet>;
  @useResult
  $Res call(
      {String tweetId,
      String userId,
      String userName,
      String? userIcon,
      String bio,
      int favoriteNum,
      String desc,
      String? imageUrl,
      DateTime createdAt});
}

/// @nodoc
class _$TweetCopyWithImpl<$Res, $Val extends Tweet>
    implements $TweetCopyWith<$Res> {
  _$TweetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tweetId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userIcon = freezed,
    Object? bio = null,
    Object? favoriteNum = null,
    Object? desc = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      tweetId: null == tweetId
          ? _value.tweetId
          : tweetId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userIcon: freezed == userIcon
          ? _value.userIcon
          : userIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      favoriteNum: null == favoriteNum
          ? _value.favoriteNum
          : favoriteNum // ignore: cast_nullable_to_non_nullable
              as int,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TweetCopyWith<$Res> implements $TweetCopyWith<$Res> {
  factory _$$_TweetCopyWith(_$_Tweet value, $Res Function(_$_Tweet) then) =
      __$$_TweetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tweetId,
      String userId,
      String userName,
      String? userIcon,
      String bio,
      int favoriteNum,
      String desc,
      String? imageUrl,
      DateTime createdAt});
}

/// @nodoc
class __$$_TweetCopyWithImpl<$Res> extends _$TweetCopyWithImpl<$Res, _$_Tweet>
    implements _$$_TweetCopyWith<$Res> {
  __$$_TweetCopyWithImpl(_$_Tweet _value, $Res Function(_$_Tweet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tweetId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userIcon = freezed,
    Object? bio = null,
    Object? favoriteNum = null,
    Object? desc = null,
    Object? imageUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$_Tweet(
      tweetId: null == tweetId
          ? _value.tweetId
          : tweetId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userIcon: freezed == userIcon
          ? _value.userIcon
          : userIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      favoriteNum: null == favoriteNum
          ? _value.favoriteNum
          : favoriteNum // ignore: cast_nullable_to_non_nullable
              as int,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Tweet implements _Tweet {
  _$_Tweet(
      {required this.tweetId,
      required this.userId,
      required this.userName,
      this.userIcon,
      required this.bio,
      required this.favoriteNum,
      required this.desc,
      this.imageUrl,
      required this.createdAt});

  factory _$_Tweet.fromJson(Map<String, dynamic> json) =>
      _$$_TweetFromJson(json);

  @override
  final String tweetId;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String? userIcon;
  @override
  final String bio;
  @override
  final int favoriteNum;
  @override
  final String desc;
  @override
  final String? imageUrl;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Tweet(tweetId: $tweetId, userId: $userId, userName: $userName, userIcon: $userIcon, bio: $bio, favoriteNum: $favoriteNum, desc: $desc, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Tweet &&
            (identical(other.tweetId, tweetId) || other.tweetId == tweetId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userIcon, userIcon) ||
                other.userIcon == userIcon) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.favoriteNum, favoriteNum) ||
                other.favoriteNum == favoriteNum) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tweetId, userId, userName,
      userIcon, bio, favoriteNum, desc, imageUrl, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TweetCopyWith<_$_Tweet> get copyWith =>
      __$$_TweetCopyWithImpl<_$_Tweet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TweetToJson(
      this,
    );
  }
}

abstract class _Tweet implements Tweet {
  factory _Tweet(
      {required final String tweetId,
      required final String userId,
      required final String userName,
      final String? userIcon,
      required final String bio,
      required final int favoriteNum,
      required final String desc,
      final String? imageUrl,
      required final DateTime createdAt}) = _$_Tweet;

  factory _Tweet.fromJson(Map<String, dynamic> json) = _$_Tweet.fromJson;

  @override
  String get tweetId;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String? get userIcon;
  @override
  String get bio;
  @override
  int get favoriteNum;
  @override
  String get desc;
  @override
  String? get imageUrl;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_TweetCopyWith<_$_Tweet> get copyWith =>
      throw _privateConstructorUsedError;
}
