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
      return error ?? 'Doit contenir entre $min et $max caractères';
    }
    return null;
  };
}

Validator checkNotEmpty({String? error}) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return error ?? 'Le champ ne doit pas être vide';
    }
    return null;
  };
}

Validator checkEmailFormat({String? error}) {
  return (String? value) {
    if (value == null || !RegExp(r"[^@]+@[^\.]+\..+").hasMatch(value)) {
      return error ?? "Email invalide";
    }
    return null;
  };
}

Validator checkGitRepoFormat({String? error}) {
  return (String? value) {
    if (value == null ||
        !RegExp(r"((git|http(s)?)|(git@[\w\.]+))(:(//)?)([\w\.@\:/\-~]+)(\.git)(/)?").hasMatch(value)) {
      return error ?? "Dépot git invalide";
    }
    return null;
  };
}

Validator checkPassword({String? error}) {
  return (String? value) {
    if (value == null || !RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(value)) {
      return error ?? "1 majuscule, 1 minuscule et 1 caractère spécial.";
    }
    return null;
  };
}
