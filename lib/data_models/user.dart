class User {
  final String userId;
  final String? userIcon;
  final String userName;
  final DateTime? updatedAt;
  final DateTime createdAt;
  final String? email;
  final String? bio;

//<editor-fold desc="Data Methods">

  const User({
    required this.userId,
    this.userIcon,
    required this.userName,
    this.updatedAt,
    required this.createdAt,
    this.email,
    this.bio,
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
          bio == other.bio);

  @override
  int get hashCode =>
      userId.hashCode ^
      userIcon.hashCode ^
      userName.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode ^
      email.hashCode ^
      bio.hashCode;

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
  }) {
    return User(
      userId: userId ?? this.userId,
      userIcon: userIcon ?? this.userIcon,
      userName: userName ?? this.userName,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      bio: bio ?? this.bio,
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
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      userIcon: map['userIcon'] as String?,
      userName: map['userName'] as String,
      updatedAt: map['updatedAt']?.toDate(),
      createdAt: map['createdAt'].toDate(),
      email: map['email'] as String?,
      bio: map['bio'] as String?,
    );
  }

//</editor-fold>
}
