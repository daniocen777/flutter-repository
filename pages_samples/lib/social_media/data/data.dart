// Posts
import '../models/post_model.dart';
import '../models/user_model.dart';

final _post0 = Post(
    imageUrl: 'assets/social_media/post0.jpg',
    author: User(),
    title: 'Post 0',
    location: 'Location 0',
    likes: 102,
    comments: 37);
final _post1 = Post(
    imageUrl: 'assets/social_media/post1.jpg',
    author: User(),
    title: 'Post 1',
    location: 'Location 1',
    likes: 532,
    comments: 129);
final _post2 = Post(
    imageUrl: 'assets/social_media/post2.jpg',
    author: User(),
    title: 'Post 2',
    location: 'Location 2',
    likes: 985,
    comments: 213);
final _post3 = Post(
    imageUrl: 'assets/social_media/post3.jpg',
    author: User(),
    title: 'Post 3',
    location: 'Location 3',
    likes: 402,
    comments: 25);
final _post4 = Post(
  imageUrl: 'assets/social_media/post4.jpg',
  author: User(),
  title: 'Post 4',
  location: 'Location 4',
  likes: 628,
  comments: 74,
);
final _post5 = Post(
    imageUrl: 'assets/social_media/post5.jpg',
    author: User(),
    title: 'Post 5',
    location: 'Location 5',
    likes: 299,
    comments: 28);

final posts = [_post0, _post1, _post2, _post3, _post4, _post5];
final users = [
  User(profileImageUrl: 'assets/social_media/user0.jpg'),
  User(profileImageUrl: 'assets/social_media/user1.jpg'),
  User(profileImageUrl: 'assets/social_media/user2.jpg'),
  User(profileImageUrl: 'assets/social_media/user3.jpg'),
  User(profileImageUrl: 'assets/social_media/user4.jpg'),
  User(profileImageUrl: 'assets/social_media/user5.jpg'),
  User(profileImageUrl: 'assets/social_media/user6.jpg'),
];
final _yourPosts = [_post1, _post3, _post5];
final _yourFavorites = [_post0, _post2, _post4];

// Current User
final User currentUser = User(
  profileImageUrl: 'assets/social_media/user.jpg',
  backgroundImageUrl: 'assets/social_media/user_background.jpg',
  name: 'Rebecca',
  following: 453,
  followers: 937,
  posts: _yourPosts,
  favorites: _yourFavorites,
);
