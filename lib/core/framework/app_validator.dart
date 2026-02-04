abstract class AppValidator {
  AppValidator._();

  // ============================
  // Constants (Single Source)
  // ============================

  static const int minLoginPasswordLength = 6;
  static const int minSignupPasswordLength = 8;

  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;

  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;

  // ============================
  // Regex (Cached)
  // ============================

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowerCaseRegex = RegExp(r'[a-z]');
  static final RegExp _numberRegex = RegExp(r'[0-9]');
  static final RegExp _specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  static final RegExp _nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');

  static final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');

  static final RegExp _digitsOnlyRegex = RegExp(r'[^\d]');

  // ============================
  // Email
  // ============================

  static String? email(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return 'email required';
    }

    if (!_emailRegex.hasMatch(v)) {
      return 'email invalid';
    }

    return null;
  }

  // ============================
  // Password
  // ============================

  static String? password(String? value, {required bool isSignup}) {
    final v = value;

    if (v == null || v.isEmpty) {
      return 'password required';
    }

    if (!isSignup) {
      if (v.length < minLoginPasswordLength) {
        return 'password too short';
      }
      return null;
    }

    // Signup rules
    if (v.length < minSignupPasswordLength) {
      return 'password min length';
    }

    if (!_upperCaseRegex.hasMatch(v)) {
      return 'password uppercase required';
    }

    if (!_lowerCaseRegex.hasMatch(v)) {
      return 'password lowercase required';
    }

    if (!_numberRegex.hasMatch(v)) {
      return 'password number required';
    }

    if (!_specialCharRegex.hasMatch(v)) {
      return 'password special char required';
    }

    return null;
  }

  // ============================
  // Confirm Password
  // ============================

  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'confirm password required';
    }

    if (value != originalPassword) {
      return "passwords don't match";
    }

    return null;
  }

  // ============================
  // Name
  // ============================

  static String? name(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return 'name required';
    }

    if (v.length < minNameLength) {
      return 'name too short';
    }

    if (v.length > maxNameLength) {
      return 'name too long';
    }

    if (!_nameRegex.hasMatch(v)) {
      return 'name invalid chars';
    }

    return null;
  }

  // ============================
  // Phone Number
  // ============================

  static String? phoneNumber(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return 'phone required';
    }

    final digitsOnly = v.replaceAll(_digitsOnlyRegex, '');

    if (digitsOnly.length < minPhoneLength) {
      return 'phone too short';
    }

    if (digitsOnly.length > maxPhoneLength) {
      return 'phone too long';
    }

    return null;
  }

  // ============================
  // Username
  // ============================

  static String? username(String? value) {
    final v = value?.trim();

    if (v == null || v.isEmpty) {
      return 'username required';
    }

    if (v.length < minUsernameLength) {
      return 'username too short';
    }

    if (v.length > maxUsernameLength) {
      return 'username too long';
    }

    if (!_usernameRegex.hasMatch(v)) {
      return 'username invalid chars';
    }

    return null;
  }
}
