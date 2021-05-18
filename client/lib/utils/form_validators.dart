Function validator(List<Function> validators) {
  return (String value) {
    for (Function validator in validators) {
      String result = validator(value);
      if (result != null) return result;
    }
    return null;
  };
}

Function checkLength({int min = 0, int max = 0, String error}) {
  return (String value) {
    if (value.length > max || value.length < min) {
      return error ?? 'Doit contenir entre $min et $max caractères';
    }
    return null;
  };
}

Function checkNotEmpty({String error}) {
  return (String value) {
    if (value.isEmpty) {
      return error ?? 'Le champ ne doit pas être vide';
    }
    return null;
  };
}

Function checkEmailFormat({String error}) {
  return (String value) {
    if (!RegExp(r"[^@]+@[^\.]+\..+").hasMatch(value)) {
      return error ?? "Email invalide";
    }
    return null;
  };
}

Function checkPassword({String error}) {
  return (String value) {
    if (!RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(value)) {
      return error ?? "1 majuscule, 1 minuscule et 1 caractère spécial.";
    }
    return null;
  };
}
