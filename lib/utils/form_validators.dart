typedef Validator = String? Function(String?);

Validator validator(List<Validator> validators) {
  return (String? value) {
    for (Validator validator in validators) {
      String? result = validator(value);
      if (result != null) return result;
    }
    return null;
  };
}

Validator checkLength({int min = 0, int max = 0, String? error}) {
  return (String? value) {
    if (value == null || value.length > max || value.length < min) {
      return error ?? 'Must contain between $min and $max characters';
    }
    return null;
  };
}

Validator checkNotEmpty({String? error}) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return error ?? 'The field should not be empty';
    }
    return null;
  };
}

Validator checkEmailFormat({String? error}) {
  return (String? value) {
    if (value == null || !RegExp(r"[^@]+@[^\.]+\..+").hasMatch(value)) {
      return error ?? "Invalid email";
    }
    return null;
  };
}

Validator checkGitRepoFormat({String? error}) {
  return (String? value) {
    if (value == null ||
        !RegExp(r"((git|http(s)?)|(git@[\w\.]+))(:(//)?)([\w\.@\:/\-~]+)(\.git)(/)?").hasMatch(value)) {
      return error ?? "Invalid git repository";
    }
    return null;
  };
}

Validator checkPassword({String? error}) {
  return (String? value) {
    if (value == null || !RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(value)) {
      return error ?? "1 uppercase, 1 lowercase and 1 special character.";
    }
    return null;
  };
}
