import 'package:flutter/foundation.dart';

class DjangoUser {
  String username;

  DjangoUser({
    required this.username,
  });

  factory DjangoUser.fromJson(Map<String, dynamic> json) {
    return DjangoUser(
      username: json['username'],
    );
  }
}

class ProfileDetails {
  DjangoUser user;
  String bio;
  String? image;

  ProfileDetails({
    required this.user,
    required this.bio,
    this.image,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      user: DjangoUser.fromJson(json['user']),
      bio: json['bio'],
      image: json['image'],
    );
  }
}

class UserProvider extends ChangeNotifier {
  DjangoUser? _user;
  ProfileDetails? _profileDetails;

  void setLoggedInUser(DjangoUser user, ProfileDetails profileDetails) {
    _user = user;
    _profileDetails = profileDetails;
    notifyListeners();
  }

  String get username => _user?.username ?? '';
  String get bio => _profileDetails?.bio ?? '';
  String get image => _profileDetails?.image ?? '';

  bool get isLoggedIn => _user != null;
}