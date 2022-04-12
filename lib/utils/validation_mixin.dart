class ValidationMixin {
  String? validateEmail(String value) {
    if (value.trim().isEmpty) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePassword(String value,
      {bool isConfirmPassword = false, String confirmValue = ""}) {
    if (value.trim().isEmpty) {
      return "Please enter password";
    }
    if (isConfirmPassword) {
      if (value != confirmValue) {
        return "Your passwords does not match";
      }
    }
    return null;
  }

  validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Mobile number is required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Mobile number should be digits";
    } else if (value.trim().length != 10) {
      return "Mobile number must be 10 digits";
    }
    return null;
  }

  String? validate(String value, String title) {
    if (value.trim().isEmpty) {
      return "Please enter your $title";
    }
    return null;
  }

  String? validateAge(String value) {
    if (value.trim().isEmpty) {
      return "Please enter your age";
    } else if (int.tryParse(value) == null) {
      return "Please enter a numeric value";
    }
    if (int.parse(value) < 0 || int.parse(value) > 150) {
      return "Please enter age more than 0 and less than 150";
    }
    return null;
  }

  String? validateNumber(String value, String title, double maxValue) {
    if (value.trim().isEmpty) {
      return "Please enter $title";
    } else if (double.tryParse(value) == null) {
      return "Please enter a numeric value";
    }
    if (double.parse(value) < 0 || double.parse(value) > maxValue) {
      return "Please enter $title more than 0 and less than $maxValue";
    }
    return null;
  }
}
