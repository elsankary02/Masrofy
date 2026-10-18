import 'package:flutter/material.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.labelText,
    this.hint,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.isPassword = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode,
    this.radius = 12.0,
    this.fillColor,
    this.filled = true,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    this.prefixIconConstraints,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.style,
    this.hintStyle,
    this.labelStyle,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? label;
  final String? labelText;
  final String? hint;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final AutovalidateMode? autovalidateMode;

  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool isPassword;
  final bool autofocus;

  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;

  final double radius;
  final Color? fillColor;
  final bool filled;
  final EdgeInsetsGeometry contentPadding;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;

  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword ? true : widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // الـ Label الخارجي (لو موجود) باستخدام الـ extension
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style:
                widget.labelStyle ??
                context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 8),
        ],

        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          autovalidateMode: widget.autovalidateMode,
          obscureText: _obscure,
          maxLines: (widget.isPassword || widget.obscureText)
              ? 1
              : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          style: widget.style ?? context.textTheme.bodyMedium,
          cursorColor: context.theme.colorScheme.primary,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hint,
            hintStyle:
                widget.hintStyle ??
                context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.hintColor,
                ),
            contentPadding: widget.contentPadding,
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: widget.prefixIconConstraints,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: context.theme.iconTheme.color,
                    ),
                  )
                : widget.suffixIcon,
            filled: widget.filled,
            fillColor:
                widget.fillColor ??
                context.theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
            enabledBorder: _buildBorder(
              color:
                  widget.enabledBorderColor ??
                  context.theme.colorScheme.outline.withValues(alpha: 0.3),
            ),
            focusedBorder: _buildBorder(
              color:
                  widget.focusedBorderColor ??
                  context.theme.colorScheme.primary,
              width: 1.5,
            ),
            errorBorder: _buildBorder(color: context.theme.colorScheme.error),
            focusedErrorBorder: _buildBorder(
              color: context.theme.colorScheme.error,
              width: 1.5,
            ),
            disabledBorder: _buildBorder(
              color: context.theme.colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder({required Color color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
