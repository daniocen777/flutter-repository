import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullname,
    this.profilePic,
    this.bio,
    this.groupId = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
  });

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          profilePic: '',
          bio: '',
          points: 0,
          fullname: '',
          groupId: const [],
          enrolledCourseIds: const [],
          following: const [],
          followers: const [],
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullname;
  final List<String>? groupId;
  final List<String>? enrolledCourseIds;
  final List<String>? following;
  final List<String>? followers;

  // Es suficiente con el uid para diferenciar los objetos (firebase)
  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, bio: $bio, points: $points, '
        'fullname: $fullname}';
  }
}
