import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_desc.freezed.dart';
part 'user_desc.g.dart';

@freezed
class UserDesc with _$UserDesc {
  factory UserDesc({
    required String userId,
    String? userIcon,
    required String userName,
    required String bio,
  }) = _UserDesc;

  factory UserDesc.fromJson(Map<String, dynamic> json) =>
      _$UserDescFromJson(json);
}
