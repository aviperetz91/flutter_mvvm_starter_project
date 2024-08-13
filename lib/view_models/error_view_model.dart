import 'package:flutter/material.dart';

class ErrorViewModel with ChangeNotifier {
  bool _error = false;
  int? _errorCode;
  String? _errorMessage;

  bool get error => _error;
  int? get statusCode => _errorCode;
  String? get errorMessage => _errorMessage;

  setError(bool value) {
    _error = value;
    notifyListeners();
  }

  setErrorCode(int? code) {
    _errorCode = code;
    notifyListeners();
  }

  setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
