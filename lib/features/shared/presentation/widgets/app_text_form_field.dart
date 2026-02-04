import '../../../../core/constants/exports.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPasswordField;
  final bool readOnly;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final String? label;
  final double borderRadius;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final AutovalidateMode? autoValidationMode;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool? enabled;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableSuggestions;
  final String? errorText;
  final String? helperText;

  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderWidth;
  final double focusedBorderWidth;

  const AppTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.isPasswordField = false,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.prefix,
    this.suffixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.label,
    this.borderRadius = 18,
    this.fillColor,
    this.contentPadding,
    this.textStyle,
    this.autoValidationMode,
    this.validator,
    this.focusNode,
    this.enabled,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.errorText,
    this.helperText,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth = 1,
    this.focusedBorderWidth = 1.2,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final ValueNotifier<bool> _obscureNotifier;
  late final ValueNotifier<TextDirection> _textDirectionNotifier;
  late final ValueNotifier<bool> _hasFocusNotifier;

  @override
  void initState() {
    super.initState();
    _obscureNotifier = ValueNotifier(widget.isPasswordField);
    _textDirectionNotifier = ValueNotifier(TextDirection.ltr);
    _hasFocusNotifier = ValueNotifier(false);

    widget.controller?.addListener(_updateTextDirection);
    widget.focusNode?.addListener(_updateFocusState);

    _updateTextDirection();
  }

  void _updateTextDirection() {
    final text = widget.controller?.text ?? '';
    final isRTL = _isArabic(text);
    final newDir = isRTL ? TextDirection.rtl : TextDirection.ltr;
    if (_textDirectionNotifier.value != newDir) {
      _textDirectionNotifier.value = newDir;
    }
  }

  void _updateFocusState() {
    if (widget.focusNode != null) {
      _hasFocusNotifier.value = widget.focusNode!.hasFocus;
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateTextDirection);
    widget.focusNode?.removeListener(_updateFocusState);
    _obscureNotifier.dispose();
    _textDirectionNotifier.dispose();
    _hasFocusNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ValueListenableBuilder(
      valueListenable: _obscureNotifier,
      builder: (context, obscure, _) {
        return ValueListenableBuilder(
          valueListenable: _textDirectionNotifier,
          builder: (context, direction, _) {
            return ValueListenableBuilder(
              valueListenable: _hasFocusNotifier,
              builder: (context, hasFocus, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.label != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          widget.label!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colors.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ],
                    TextFormField(
                      cursorRadius: const Radius.circular(6),
                      cursorColor: colors.primary,
                      cursorWidth: 2,
                      enabled: widget.enabled,
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      obscureText: widget.isPasswordField ? obscure : false,
                      readOnly: widget.readOnly,
                      keyboardType: widget.textInputType,
                      textInputAction: widget.textInputAction,
                      textCapitalization: widget.textCapitalization,
                      autocorrect: widget.isPasswordField
                          ? false
                          : widget.autocorrect,
                      enableSuggestions: widget.isPasswordField
                          ? false
                          : widget.enableSuggestions,
                      maxLength: widget.maxLength,
                      maxLines: widget.isPasswordField ? 1 : widget.maxLines,
                      minLines: widget.minLines,
                      inputFormatters: widget.inputFormatters,
                      autovalidateMode:
                          widget.autoValidationMode ??
                          AutovalidateMode.onUserInteraction,
                      validator: widget.validator,
                      onChanged: widget.onChanged,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      onTap: widget.onTap,
                      onEditingComplete: widget.onEditingComplete,
                      textDirection: direction,
                      style:
                          widget.textStyle ??
                          TextStyle(
                            fontSize: 15,
                            color: colors.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            widget.fillColor ??
                            colors.onPrimaryContainer.withValues(alpha: 0.08),
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: colors.onSurfaceVariant.withValues(alpha: 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        errorText: widget.errorText,
                        helperText: widget.helperText,
                        helperStyle: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 12,
                          height: 1.4,
                        ),
                        errorStyle: TextStyle(
                          color: colors.error,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                        errorMaxLines: 2,
                        counterText: widget.maxLength != null ? '' : null,
                        contentPadding:
                            widget.contentPadding ??
                            EdgeInsets.symmetric(
                              vertical: widget.maxLines == 1 ? 18 : 16,
                              horizontal: 20,
                            ),
                        prefixIcon: widget.prefix == null
                            ? null
                            : Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 12,
                                  end: 8,
                                ),
                                child: widget.prefix,
                              ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                        ),
                        suffixIcon: widget.isPasswordField
                            ? IconButton(
                                splashRadius: 24,
                                tooltip: obscure
                                    ? 'Show password'
                                    : 'Hide password',
                                onPressed: () => _obscureNotifier.value =
                                    !_obscureNotifier.value,
                                icon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  transitionBuilder: (child, animation) {
                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  child: Icon(
                                    obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    key: ValueKey(obscure),
                                    color: colors.onSurfaceVariant,
                                    size: 22,
                                  ),
                                ),
                              )
                            : widget.suffixIcon,
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: BorderSide(
                            color:
                                widget.borderColor ??
                                colors.outline.withValues(alpha: 0.3),
                            width: widget.borderWidth,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: BorderSide(
                            color: widget.focusedBorderColor ?? colors.primary,
                            width: widget.focusedBorderWidth,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: BorderSide(
                            color: widget.errorBorderColor ?? colors.error,
                            width: widget.borderWidth,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: BorderSide(
                            color: widget.errorBorderColor ?? colors.error,
                            width: widget.focusedBorderWidth,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          borderSide: BorderSide(
                            color: colors.outline.withValues(alpha: 0.15),
                            width: widget.borderWidth,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  bool _isArabic(String text) {
    final arabicRegex = RegExp(
      r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFEFC]',
    );
    return arabicRegex.hasMatch(text);
  }
}
