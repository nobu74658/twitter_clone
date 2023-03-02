// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userIcon: json['userIcon'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      email: json['email'] as String?,
      bio: json['bio'] as String,
      followingNum: json['followingNum'] as int? ?? 0,
      followedNum: json['followedNum'] as int? ?? 0,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userIcon': instance.userIcon,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'email': instance.email,
      'bio': instance.bio,
      'followingNum': instance.followingNum,
      'followedNum': instance.followedNum,
    };
