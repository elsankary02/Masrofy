import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, tertiary, outlined, text }

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double? height;
  final Widget? icon;
  final bool isDisabled;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding; // أضفنا الحشو الداخلي
  final EdgeInsetsGeometry? margin; // أضفنا الهوامش الخارجية

  const CustomBtn({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.width,
    this.height,
    this.icon,
    this.isDisabled = false,
    this.style,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          margin: margin,
          padding: padding,
          child: SizedBox(
            width: width ?? double.infinity,
            height: height ?? 48,
            child: _buildButton(theme),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(ThemeData theme) {
    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
          ),
          child: _buildContent(Colors.white),
        );
      case ButtonVariant.secondary:
        return ElevatedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: Colors.white,
          ),
          child: _buildContent(Colors.white),
        );
      case ButtonVariant.tertiary:
        return ElevatedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.tertiary,
            foregroundColor: Colors.black,
          ),
          child: _buildContent(Colors.black),
        );
      case ButtonVariant.outlined:
        return OutlinedButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: theme.colorScheme.primary),
            foregroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _buildContent(theme.colorScheme.primary),
        );
      case ButtonVariant.text:
        return TextButton(
          onPressed: (isLoading || isDisabled) ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
          ),
          child: _buildContent(theme.colorScheme.primary),
        );
    }
  }

  Widget _buildContent(Color textColor) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(text, style: style),
      ],
    );
  }
}
