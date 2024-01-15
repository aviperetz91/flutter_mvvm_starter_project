class ApiException implements Exception {
  final int? _code;
  final String? _message;
  final String? _prefix;

  ApiException(
    this._code,
    this._message,
    this._prefix,
  );

  int? get code => _code;
  String? get message => _message;

  @override
  String toString() {
    return "$_code, $_prefix$_message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException(int? code, String? message)
      : super(code, message, "Error During Communication: ");
}

class BadRequestException extends ApiException {
  BadRequestException(int? code, String? message)
      : super(code, message, "Invalid Request: ");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException(int? code, String? message)
      : super(code, message, "Unauthorised Request: ");
}

class NotFoundException extends ApiException {
  NotFoundException(int? code, String? message)
      : super(code, message, "Not Found: ");
}

class InvalidInputException extends ApiException {
  InvalidInputException(int? code, String? message)
      : super(code, message, "Invalid Input: ");
}
