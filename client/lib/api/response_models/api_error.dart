class ApiError {
  String message;
  int code;

  bool is401() {
    return code == 401;
  }

  ApiError.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        code = json["code"];

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
      };

  @override
  String toString() {
    return message;
  }
}
