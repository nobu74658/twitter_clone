class Tweet {
  final String tweetId;
  final String userId;
  final int favoriteNum;
  final String desc;
  final DateTime createdAt;

//<editor-fold desc="Data Methods">

  Tweet({
    required this.tweetId,
    required this.userId,
    required this.favoriteNum,
    required this.desc,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tweet &&
          runtimeType == other.runtimeType &&
          tweetId == other.tweetId &&
          userId == other.userId &&
          favoriteNum == other.favoriteNum &&
          desc == other.desc &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      tweetId.hashCode ^
      userId.hashCode ^
      favoriteNum.hashCode ^
      desc.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'Tweet{' +
        ' tweetId: $tweetId,' +
        ' userId: $userId,' +
        ' favoriteNum: $favoriteNum,' +
        ' desc: $desc,' +
        ' createdAt: $createdAt,' +
        '}';
  }

  Tweet copyWith({
    String? postId,
    String? userId,
    int? favoriteNum,
    String? desc,
    DateTime? createdAt,
  }) {
    return Tweet(
      tweetId: postId ?? this.tweetId,
      userId: userId ?? this.userId,
      favoriteNum: favoriteNum ?? this.favoriteNum,
      desc: desc ?? this.desc,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tweetId': this.tweetId,
      'userId': this.userId,
      'favoriteNum': this.favoriteNum,
      'desc': this.desc,
      'createdAt': this.createdAt,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      tweetId: map['tweetId'] as String,
      userId: map['userId'] as String,
      favoriteNum: map['favoriteNum'] as int,
      desc: map['desc'] as String,
      createdAt: map['createdAt'].toDate(),
    );
  }

//</editor-fold>
}
