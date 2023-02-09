class User {
  final String userId;
  final String? userIcon;
  final String userName;
  final String userType;
  final DateTime? updatedAt;
  final DateTime createdAt;
  final String? email;
  final String? phoneNumber;
  final String? bio;
  final List<dynamic>? blockUserIds;

//<editor-fold desc="Data Methods">

  const User({
    required this.userId,
    this.userIcon,
    required this.userName,
    required this.userType,
    this.updatedAt,
    required this.createdAt,
    this.email,
    this.phoneNumber,
    this.bio,
    this.blockUserIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          userIcon == other.userIcon &&
          userName == other.userName &&
          userType == other.userType &&
          updatedAt == other.updatedAt &&
          createdAt == other.createdAt &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          bio == other.bio &&
          blockUserIds == other.blockUserIds);

  @override
  int get hashCode =>
      userId.hashCode ^
      userIcon.hashCode ^
      userName.hashCode ^
      userType.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      bio.hashCode ^
      blockUserIds.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' userId: $userId,' +
        ' userIcon: $userIcon,' +
        ' userName: $userName,' +
        ' userType: $userType,' +
        ' updatedAt: $updatedAt,' +
        ' createdAt: $createdAt,' +
        ' email: $email,' +
        ' phoneNumber: $phoneNumber,' +
        ' bio: $bio,' +
        ' blockUserIds: $blockUserIds,' +
        '}';
  }

  User copyWith({
    String? userId,
    String? userIcon,
    String? userName,
    String? userType,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? email,
    String? phoneNumber,
    String? bio,
    List<dynamic>? blockUserIds,
  }) {
    return User(
      userId: userId ?? this.userId,
      userIcon: userIcon ?? this.userIcon,
      userName: userName ?? this.userName,
      userType: userType ?? this.userType,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      blockUserIds: blockUserIds ?? this.blockUserIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'userIcon': this.userIcon,
      'userName': this.userName,
      'userType': this.userType,
      'updatedAt': this.updatedAt,
      'createdAt': this.createdAt,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'bio': this.bio,
      'blockUserIds': this.blockUserIds,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      userIcon: map['userIcon'] as String?,
      userName: map['userName'] as String,
      userType: map['userType'] as String,
      updatedAt: map['updatedAt']?.toDate(),
      createdAt: map['createdAt'].toDate(),
      email: map['email'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      bio: map['bio'] as String?,
      blockUserIds: map['blockUserIds'] as List<dynamic>?,
    );
  }

//</editor-fold>
}