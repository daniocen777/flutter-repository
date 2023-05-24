class Publication {
  final User user;
  final String title;
  final DateTime createdAt;
  final String imageUrl;
  final int commetsCount;
  final int sharesCount;
  final Reaction currentUserReaction;

  const Publication(
      {required this.title,
      required this.createdAt,
      required this.imageUrl,
      required this.commetsCount,
      required this.sharesCount,
      required this.user,
      required this.currentUserReaction});
}

class User {
  final String avatar;
  final String username;

  const User({required this.avatar, required this.username});
}

enum Reaction { like, love, laughing, sad, shocking, angry }
