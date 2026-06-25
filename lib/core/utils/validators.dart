class AppValidators {
  AppValidators._();

  static String? requiredField(
      String? value, {
        String fieldName = 'Field',
      }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? images(List files) {
    if (files.isEmpty) return "At least 1 image required";
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    final regex = RegExp(r'^[a-zA-Z\s]+$');

    if (!regex.hasMatch(value.trim())) {
      return 'Only letters and spaces allowed';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }

    final regex = RegExp(r'^[a-zA-Z0-9_]+$');

    if (!regex.hasMatch(value.trim())) {
      return 'Only letters, numbers and underscore allowed';
    }

    if (value.trim().length < 3) {
      return 'Username must be at least 3 characters';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final regex = RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    );

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final regex = RegExp(r'^[0-9]{10}$');

    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    final hasUpper = RegExp(r'[A-Z]').hasMatch(value);
    final hasLower = RegExp(r'[a-z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    final hasSpecial =
    RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

    if (!hasUpper ||
        !hasLower ||
        !hasNumber ||
        !hasSpecial) {
      return 'Password must contain uppercase, lowercase, number and special character';
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String originalPassword,
      ) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? price(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }

    final price = double.tryParse(value);

    if (price == null) {
      return 'Enter a valid price';
    }

    if (price <= 0) {
      return 'Price must be greater than 0';
    }

    return null;
  }

  static String? quantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantity is required';
    }

    final quantity = int.tryParse(value);

    if (quantity == null) {
      return 'Enter a valid quantity';
    }

    if (quantity <= 0) {
      return 'Quantity must be greater than 0';
    }

    return null;
  }

  static String? description(
      String? value, {
        int minLength = 10,
      }) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }

    if (value.trim().length < minLength) {
      return 'Description must be at least $minLength characters';
    }

    return null;
  }

  static String? bio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (value.length > 150) {
      return 'Bio cannot exceed 150 characters';
    }

    return null;
  }
}