import 'package:flutter/material.dart';
import 'package:flutter_mvvm/themes/app_colors.dart';
import 'package:flutter_mvvm/view_models/error_view_model.dart';
import 'package:provider/provider.dart';

class ErrorScreen extends StatelessWidget {
  final IconData? icon;
  final double iconSize;
  final Color iconColor;
  final String? title;
  final double titleSize;
  final Color titleColor;
  final String? subtitle;
  final double subtitleSize;
  final Color subtitleColor;

  const ErrorScreen({
    super.key,
    this.icon,
    this.iconSize = 160,
    this.iconColor = AppColors.warning,
    this.title,
    this.titleSize = 20,
    this.titleColor = Colors.black,
    this.subtitle,
    this.subtitleSize = 16,
    this.subtitleColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ErrorViewModel>(
      builder: (context, errorViewModel, _) {
        if (errorViewModel.error) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon != null
                      ? Icon(
                          icon,
                          size: iconSize,
                          color: iconColor,
                        )
                      : const SizedBox(),
                  SizedBox(height: title != null ? 16 : 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      children: [
                        title != null
                            ? Text(
                                title!,
                                style: TextStyle(
                                  fontSize: titleSize,
                                  color: titleColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: subtitle != null ? 24 : 0),
                        subtitle != null
                            ? Text(
                                subtitle!,
                                style: TextStyle(
                                  fontSize: subtitleSize,
                                  color: subtitleColor,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
