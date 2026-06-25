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
      isFollowing: false,
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
    );
  }
}