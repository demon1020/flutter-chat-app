//firebase user
//User(displayName: babu, email: babu@gmail.com, emailVerified: false, isAnonymous: false,
// metadata: UserMetadata(creationTime: 2022-04-24 16:23:40.706,
// lastSignInTime: 2022-04-25 02:46:18.711), phoneNumber: null, photoURL: null, providerData,
// [UserInfo(displayName: babu, email: babu@gmail.com, phoneNumber: null, photoURL: null,
// providerId: password, uid: babu@gmail.com)], refreshToken: , tenantId: null,
// uid: 8x5pFPiRS7ZS27047uH6eq2l5133)
class UsersInfo {
  final String? name;
  final String? email;
  final String? photoURL;
  final int? phoneNumber;
  final String? uid;

  UsersInfo({this.name, this.email, this.photoURL,this.phoneNumber, required this.uid});
}
