class ProfileModel {
  final String userId;
  final String username;
  final String name;
  final String bio;
  final String? profilePic;
  final String email;
  final String phoneNo;
  final bool isFollowing;

  final String govtIdType;
  final String defaultAddress;
  final String socialMediaHandle;
  final bool isFaceVerified;
  final String bankName;

  final int followers;
  final int following;
  final int activeListings;
  final int soldListings;
  final int rentedListings;

  const ProfileModel({
    required this.userId,
    required this.username,
    required this.name,
    required this.bio,
    this.profilePic,
    required this.email,
    required this.phoneNo,
    required this.govtIdType,
    required this.defaultAddress,
    required this.socialMediaHandle,
    required this.isFaceVerified,
    required this.bankName,
    required this.followers,
    required this.following,
    required this.activeListings,
    required this.soldListings,
    required this.rentedListings,
    required this.isFollowing,
  });

  factory ProfileModel.empty(String userId) {
    return ProfileModel(
      userId: userId,
      username: '',
      name: '',
      bio: '',
      profilePic: null,
      email: '',
      phoneNo: '',
      govtIdType: 'Not uploaded',
      defaultAddress: 'No default address configured',
      socialMediaHandle: 'Not added',
      isFaceVerified: false,
      bankName: 'Not linked',
      followers: 0,
      following: 0,
      activeListings: 0,
      soldListings: 0,
      rentedListings: 0,
      isFollowing: false,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      profilePic: json['profile_pic'],
      email: json['email'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      govtIdType: json['govt_id_type'] ?? '',
      defaultAddress: json['default_address'] ?? '',
      socialMediaHandle: json['social_media_handle'] ?? '',
      isFaceVerified: json['is_face_verified'] ?? false,
      bankName: json['bank_name'] ?? '',
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      activeListings: json['active_listings'] ?? 0,
      soldListings: json['sold_listings'] ?? 0,
      rentedListings: json['rented_listings'] ?? 0,

      // not stored in DB usually (computed per user relation)
      isFollowing: json['is_following'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'name': name,
      'bio': bio,
      'profile_pic': profilePic,
      'email': email,
      'phone_no': phoneNo,
      'govt_id_type': govtIdType,
      'default_address': defaultAddress,
      'social_media_handle': socialMediaHandle,
      'is_face_verified': isFaceVerified,
      'bank_name': bankName,
      'followers': followers,
      'following': following,
      'active_listings': activeListings,
      'sold_listings': soldListings,
      'rented_listings': rentedListings,
    };
  }
}