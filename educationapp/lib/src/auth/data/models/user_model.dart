import 'package:educationapp/core/utils/typedef.dart';
import 'package:educationapp/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.profilePic,
    required super.bio,
    required super.points,
    required super.fullname,
    super.groupId,
    super.enrolledCourseIds,
    super.following,
    super.followers,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          profilePic: null,
          bio: null,
          points: 0,
          fullname: '',
          groupId: const [],
          enrolledCourseIds: const [],
          following: const [],
          followers: const [],
        );

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          // num => firebase
          points: (map['points'] as num).toInt(),
          fullname: map['fullname'] as String,
          groupId: (map['groupId'] as List<dynamic>).cast<String>(),
          enrolledCourseIds:
              (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
        );

  LocalUserModel copiWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullname,
    List<String>? groupId,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullname: fullname ?? this.fullname,
      groupId: groupId ?? this.groupId,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'profilePic': profilePic,
        'bio': bio,
        'points': points,
        'fullname': fullname,
        'groupId': groupId,
        'enrolledCourseIds': enrolledCourseIds,
        'following': following,
        'followers': followers,
      };
}
