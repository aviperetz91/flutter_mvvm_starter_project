import 'package:flutter/material.dart';
import 'package:flutter_mvvm/services/navigation/navigation_service.dart';
import 'package:flutter_mvvm/view_models/error_view_model.dart';
import 'package:provider/provider.dart';

handleError(int? errorCode, String? errorMessage) {
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  ErrorViewModel errorViewModel =
      Provider.of<ErrorViewModel>(context, listen: false);
  errorViewModel.setError(true);
  errorViewModel.setErrorCode(errorCode);
  errorViewModel.setErrorMessage(errorMessage);
}
