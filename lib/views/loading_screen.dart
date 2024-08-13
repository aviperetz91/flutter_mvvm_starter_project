import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view_models/loading_view_model.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  final Color? progressIndicatorColor;

  const LoadingScreen({
    super.key,
    this.progressIndicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingViewModel>(
      builder: (context, loadingViewModel, _) {
        if (loadingViewModel.isLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: progressIndicatorColor,
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
