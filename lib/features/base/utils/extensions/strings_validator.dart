extension StringsValidator on String {
  bool isValidPassword() {
    bool passwordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(this);
    return passwordValid;
  }

  bool isValidEmail() {
    // Improved email validation that requires:
    // - Valid local part (before @)
    // - @ symbol
    // - Valid domain with at least one dot and TLD with 2+ letters
    // Rejects domains like "334343e" (no dot, invalid TLD)
    var pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    bool emailValid = RegExp(pattern).hasMatch(this.trim());
    
    // Additional check: domain must have at least one letter (not all numbers)
    if (emailValid) {
      final parts = this.trim().split('@');
      if (parts.length == 2) {
        final domain = parts[1];
        final domainParts = domain.split('.');
        // Check that the main domain part (before TLD) contains at least one letter
        if (domainParts.length >= 2) {
          final mainDomain = domainParts[domainParts.length - 2];
          // If main domain is all numbers, it's invalid
          if (RegExp(r'^[0-9]+$').hasMatch(mainDomain)) {
            return false;
          }
        }
      }
    }
    
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
