

bool isValidEmail(String value) {
  RegExp regExp = new RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (value.isEmpty){
    return false;
  } else if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}



bool isStrongPassword(String password) {
  if (password.length < 8) {
    return false;
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }
  return true;
}



