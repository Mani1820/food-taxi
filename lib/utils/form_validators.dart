String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  }
  if (password.contains(' ')) {
    return 'Password can not contain spaces';
  }
  if (password.trim().length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

String? confirmPasswordValidator(String? confirmPassword, String? password) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm password is required';
  }
  if (confirmPassword != password) {
    return 'Passwords do not match';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Name is required';
  }
  if (name.length < 2) {
    return 'Name must be at least 2 characters';
  }
  return null;
}

String? addressValidator(String? address) {
  if (address == null || address.isEmpty) {
    return 'Address is required';
  }
  if (address.length < 2) {
    return 'Address must be at least 2 characters';
  }
  return null;
}

String? phoneNumberValidator(String? phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return 'Please enter your phone number';
  }
  if (phoneNumber.length != 10) {
    return 'Enter a valid phone number';
  }
  return null;
}

String? pincodeValidator(String? pincode) {
  if (pincode == null || pincode.isEmpty) {
    return 'Please enter your pincode';
  }
  final pincodeRegex = RegExp(r'^\d{6}$');
  if (!pincodeRegex.hasMatch(pincode)) {
    return 'Enter a valid pincode';
  }
  return null;
}
String? streetValidator(String? street) {
  if (street == null || street.isEmpty) {
    return 'Street is required';
  }
  if (street.length < 2) {
    return 'Street must be at least 2 characters';
  }
  return null;
}
String? areaValidator(String? area) {
  if (area == null || area.isEmpty) {
    return 'Area is required';
  }
  if (area.length < 2) {
    return 'Area must be at least 2 characters';
  }
  return null;
}
String? landmarkValidator(String? landmark) {
  if (landmark == null || landmark.isEmpty) {
    return 'Landmark is required';
  }
  if (landmark.length < 2) {
    return 'Landmark must be at least 2 characters';
  }
  return null;
}
String? cityValidator(String? city) {
  if (city == null || city.isEmpty) {
    return 'City is required';
  }
  if (city.length < 2) {
    return 'City must be at least 2 characters';
  }
  return null;
}