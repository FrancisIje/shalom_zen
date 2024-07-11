class ZenUserConst {
  static const id = 'id';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const email = 'email';
  static const profileUrl = 'profileUrl';
  static const password = 'password';
  static const userRecordings = 'userRecordings';
}

class ZenUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String? profileUrl;
  String password;
  // List<UserRecordings>? recordings;

  ZenUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileUrl,
    required this.password,
    // required this.recordings
  });

  factory ZenUser.fromFirestore(Map<String, dynamic> data) {
    return ZenUser(
      id: data[ZenUserConst.id],
      firstName: data[ZenUserConst.firstName],
      lastName: data[ZenUserConst.lastName],
      email: data[ZenUserConst.email],
      profileUrl: data[ZenUserConst.profileUrl],
      password: data[ZenUserConst.password],
      // recordings: data[ZenUserConst.userRecordings]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      ZenUserConst.id: id,
      ZenUserConst.firstName: firstName,
      ZenUserConst.lastName: lastName,
      ZenUserConst.email: email,
      ZenUserConst.profileUrl: profileUrl,
      ZenUserConst.password: password,
      // ZenUserConst.userRecordings: recordings ?? []
    };
  }
}
