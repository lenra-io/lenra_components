import 'package:fr_lenra_client/error/error.dart';

class LenraComponentCreationError extends LenraError {
  LenraComponentCreationError(String description) : super(description);
}

class LenraJsonMalformedError extends LenraComponentCreationError {
  LenraJsonMalformedError(String description) : super(description);
}
