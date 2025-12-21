extension StringsValidator on String {
  bool isValidPassword() {
    bool passwordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(this);
    return passwordValid;
  }

  bool isValidEmail() {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    bool emailValid = RegExp(pattern).hasMatch(this);
    return emailValid;
  }

  bool isValidPhone() {
    bool phoneValid = RegExp(r'^01[0-2,5]{1}[0-9]{8}$').hasMatch(this);
    return phoneValid;
  }

  bool isValidIdNumber() {
    bool idValid = RegExp(r'^[1-2][0-9]{9}$').hasMatch(this);
    return idValid;
  }

  bool isValidName() {
    // Allow letters (including accented characters and Arabic), spaces, hyphens, and apostrophes
    // Reject special characters like #, @, numbers, etc.
    // The regex validates the entire string, not just the first character
    bool nameValid = RegExp(r"^[a-zA-ZÀ-ÿ\u0621-\u064A\s'-]+$").hasMatch(this.trim());
    return nameValid && this.trim().isNotEmpty && this.trim().length >= 2;
  }
}
