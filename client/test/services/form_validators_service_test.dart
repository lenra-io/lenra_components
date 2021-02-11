import 'package:flutter_test/flutter_test.dart';
import 'package:fr_lenra_client/services/form_validators_service.dart';

void main() {
  test('checkLength valid if value length between min and max', () {
    expect(
      checkLength(min: 2, max: 10)("test"),
      null,
    );
  });

  test('checkLength valid if value length == min', () {
    expect(
      checkLength(min: 2, max: 10)("te"),
      null,
    );
  });

  test('checkLength valid if value length == max', () {
    expect(
      checkLength(min: 2, max: 10)("testde10ch"),
      null,
    );
  });

  test('checkLength invalid if value length > max', () {
    expect(
      checkLength(min: 2, max: 10)("testde11cha"),
      'Doit contenir entre 2 et 10 caractères',
    );
  });

  test('checkLength invalid if value length < min', () {
    expect(
      checkLength(min: 2, max: 10)("t"),
      'Doit contenir entre 2 et 10 caractères',
    );
  });

  test('checkLength invalid take my error message', () {
    expect(
      checkLength(min: 2, max: 10, error: "my error")("t"),
      "my error",
    );
  });

  test('checkNotEmpty valid if not empty string', () {
    expect(checkNotEmpty()("test"), null);
  });

  test('checkNotEmpty invalid if empty string', () {
    expect(checkNotEmpty()(""), 'Le champ ne doit pas être vide');
  });

  test('checkNotEmpty invalid custom error', () {
    expect(checkNotEmpty(error: "My error")(""), "My error");
  });

  test('checkEmailFormat invalid custom error', () {
    expect(checkEmailFormat(error: "My error")("emailinvalid"), "My error");
  });

  test('checkEmailFormat invalid', () {
    expect(checkEmailFormat()("emailinvalid"), "Email invalide");
  });

  test('checkEmailFormat valid', () {
    expect(checkEmailFormat()("test@test.te"), null);
  });

  test('validator must be valid if empty', () {
    expect(
      validator([])("ok"),
      null,
    );
  });

  test('validator must be valid if all validators are valid.', () {
    expect(
      validator([
        checkNotEmpty(),
        checkLength(min: 1, max: 3),
      ])("42"),
      null,
    );
  });

  test('validator must be invalid if one of validators are invalid.', () {
    expect(
      validator([
        checkNotEmpty(),
        checkLength(min: 1, max: 3),
      ])("4245"),
      'Doit contenir entre 1 et 3 caractères',
    );
  });

  test('if more than one validator is invalid, it must stop and return the first invalid', () {
    expect(
      validator([
        checkNotEmpty(),
        checkLength(min: 1, max: 3),
      ])(""),
      'Le champ ne doit pas être vide',
    );
  });
}
