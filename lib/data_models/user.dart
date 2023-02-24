class User {
  final String userId;
  final String? userIcon;
  final String userName;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String? email;
  final String? bio;
  final int followingNum;
  final int followedNum;

//<editor-fold desc="Data Methods">

  const User({
    required this.userId,
    this.userIcon,
    required this.userName,
    required this.updatedAt,
    required this.createdAt,
    this.email,
    this.bio,
    required this.followingNum,
    required this.followedNum,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          userIcon == other.userIcon &&
          userName == other.userName &&
          updatedAt == other.updatedAt &&
          createdAt == other.createdAt &&
          email == other.email &&
          bio == other.bio &&
          followingNum == other.followingNum &&
          followedNum == other.followedNum);

  @override
  int get hashCode =>
      userId.hashCode ^
      userIcon.hashCode ^
      userName.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode ^
      email.hashCode ^
      bio.hashCode ^
      followingNum.hashCode ^
      followedNum.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' userId: $userId,' +
        ' userIcon: $userIcon,' +
        ' userName: $userName,' +
        ' updatedAt: $updatedAt,' +
        ' createdAt: $createdAt,' +
        ' email: $email,' +
        ' bio: $bio,' +
        ' followingNum: $followingNum,' +
        ' followedNum: $followedNum,' +
        '}';
  }

  User copyWith({
    String? userId,
    String? userIcon,
    String? userName,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? email,
    String? bio,
    int? followingNum,
    int? followedNum,
  }) {
    return User(
      userId: userId ?? this.userId,
      userIcon: userIcon ?? this.userIcon,
      userName: userName ?? this.userName,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      followingNum: followingNum ?? this.followingNum,
      followedNum: followedNum ?? this.followedNum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'userIcon': this.userIcon,
      'userName': this.userName,
      'updatedAt': this.updatedAt,
      'createdAt': this.createdAt,
      'email': this.email,
      'bio': this.bio,
      'followingNum': this.followingNum,
      'followedNum': this.followedNum,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      userIcon: map['userIcon'] as String?,
      userName: map['userName'] as String,
      updatedAt: map['updatedAt'].toDate(),
      createdAt: map['createdAt'].toDate(),
      email: map['email'] as String?,
      bio: map['bio'] as String?,
      followingNum: map['followingNum'] as int,
      followedNum: map['followedNum'] as int,
    );
  }

//</editor-fold>
}
