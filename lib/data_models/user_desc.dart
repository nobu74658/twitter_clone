class UserDesc {
  final String userId;
  final String? userIcon;
  final String userName;
  final String bio;

//<editor-fold desc="Data Methods">

  const UserDesc({
    required this.userId,
    this.userIcon,
    required this.userName,
    required this.bio,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDesc &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          userIcon == other.userIcon &&
          userName == other.userName &&
          bio == other.bio);

  @override
  int get hashCode =>
      userId.hashCode ^ userIcon.hashCode ^ userName.hashCode ^ bio.hashCode;

  @override
  String toString() {
    return 'UserDesc{' +
        ' userId: $userId,' +
        ' userIcon: $userIcon,' +
        ' userName: $userName,' +
        ' bio: $bio,' +
        '}';
  }

  UserDesc copyWith({
    String? userId,
    String? userIcon,
    String? userName,
    String? bio,
  }) {
    return UserDesc(
      userId: userId ?? this.userId,
      userIcon: userIcon ?? this.userIcon,
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'userIcon': this.userIcon,
      'userName': this.userName,
      'bio': this.bio,
    };
  }

  factory UserDesc.fromMap(Map<String, dynamic> map) {
    return UserDesc(
      userId: map['userId'] as String,
      userIcon: map['userIcon'] as String?,
      userName: map['userName'] as String,
      bio: map['bio'] as String,
    );
  }

//</editor-fold>
}
