// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Tweet _$$_TweetFromJson(Map<String, dynamic> json) => _$_Tweet(
      tweetId: json['tweetId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userIcon: json['userIcon'] as String?,
      bio: json['bio'] as String,
      favoriteNum: json['favoriteNum'] as int,
      desc: json['desc'] as String,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_TweetToJson(_$_Tweet instance) => <String, dynamic>{
      'tweetId': instance.tweetId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userIcon': instance.userIcon,
      'bio': instance.bio,
      'favoriteNum': instance.favoriteNum,
      'desc': instance.desc,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
