class Tweet {
  final String tweetId;
  final String userId;
  final String userName;
  final String? userIcon;
  final String bio;
  final int favoriteNum;
  final String desc;
  final String? imageUrl;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">

  Tweet({
    required this.tweetId,
    required this.userId,
    required this.userName,
    this.userIcon,
    required this.bio,
    required this.favoriteNum,
    required this.desc,
    this.imageUrl,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tweet &&
          runtimeType == other.runtimeType &&
          tweetId == other.tweetId &&
          userId == other.userId &&
          userName == other.userName &&
          userIcon == other.userIcon &&
          bio == other.bio &&
          favoriteNum == other.favoriteNum &&
          desc == other.desc &&
          imageUrl == other.imageUrl &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      tweetId.hashCode ^
      userId.hashCode ^
      userName.hashCode ^
      userIcon.hashCode ^
      bio.hashCode ^
      favoriteNum.hashCode ^
      desc.hashCode ^
      imageUrl.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'Tweet{' +
        ' tweetId: $tweetId,' +
        ' userId: $userId,' +
        ' userName: $userName,' +
        ' userIcon: $userIcon,' +
        ' bio: $bio,' +
        ' favoriteNum: $favoriteNum,' +
        ' desc: $desc,' +
        ' imageUrl: $imageUrl,' +
        ' createdAt: $createdAt,' +
        '}';
  }

  Tweet copyWith({
    String? tweetId,
    String? userId,
    String? userName,
    String? userIcon,
    String? bio,
    int? favoriteNum,
    String? desc,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return Tweet(
      tweetId: tweetId ?? this.tweetId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userIcon: userIcon ?? this.userIcon,
      bio: bio ?? this.bio,
      favoriteNum: favoriteNum ?? this.favoriteNum,
      desc: desc ?? this.desc,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tweetId': this.tweetId,
      'userId': this.userId,
      'userName': this.userName,
      'userIcon': this.userIcon,
      'bio': this.bio,
      'favoriteNum': this.favoriteNum,
      'desc': this.desc,
      'imageUrl': this.imageUrl,
      'createdAt': this.createdAt,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      tweetId: map['tweetId'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userIcon: map['userIcon'] as String?,
      bio: map['bio'] as String,
      favoriteNum: map['favoriteNum'] as int,
      desc: map['desc'] as String,
      imageUrl: map['imageUrl'] as String?,
      createdAt: map['createdAt'].toDate(),
    );
  }

//</editor-fold>
}
