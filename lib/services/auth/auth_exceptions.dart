// login exceptions
class UserNotFoundAuthException implements Exception {
  String msg = "User not found";
}

class WrongPasswordAuthException implements Exception {
  String msg = "Password Incorrect";
}

// register exceptions

class WeakPasswordAuthException implements Exception {
  String msg = "Password is too weak,set something stronger";
}

class EmailAlreadyInUseAuthException implements Exception {
  String msg = "This email already exists";
}

class InvalidEmailAuthException implements Exception {
  String msg = "Invalid Email";
}

// generic exceptions

class GenericAuthException implements Exception {
  String msg = "Something went wrong";
}

class UserNotLoggedInAuthException implements Exception {
  String msg = "User is not logged in";
}
