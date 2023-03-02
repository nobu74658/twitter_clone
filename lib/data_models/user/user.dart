import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String userId,
    required String userName,
    String? userIcon,
    DateTime? updatedAt,
    required DateTime createdAt,
    String? email,
    required String bio,
    @Default(0) int followingNum,
    @Default(0) int followedNum,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
