import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

enum ButtonType { primary, secondary, amount }

class Buttons extends StatefulWidget {
  final String text;
  final ButtonType type;
  final bool enabled;
  final VoidCallback? onPressed;

  const Buttons({
    super.key,
    required this.text,
    this.type = ButtonType.primary,
    this.enabled = true,
    this.onPressed,
  });

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  bool _isPressed = false;

  ({
    Color backgroundColor,
    Color textColor,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
  })
  _resolveStyle(String brightnessKey) {
    if (!widget.enabled) {
      if (widget.type == ButtonType.secondary) {
        return (
          backgroundColor: ThemeColors.get(brightnessKey, 'alt/base/600'),
          textColor: ThemeColors.get(brightnessKey, 'text/base/400'),
          borderColor: null,
          boxShadow: [
            BoxShadow(
              color: const Color(0x10182828).withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        );
      }

      return (
        backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/300'),
        textColor: ThemeColors.get(brightnessKey, 'text/base/400'),
        borderColor: ThemeColors.get(brightnessKey, 'stroke/base/200'),
        boxShadow: null,
      );
    }

    switch (widget.type) {
      case ButtonType.primary:
        return (
          backgroundColor: ThemeColors.get(brightnessKey, 'primary/400'),
          textColor: ThemeColors.get(brightnessKey, 'fill/contrast/600'),
          borderColor: null,
          boxShadow: null,
        );
      case ButtonType.secondary:
        return (
          backgroundColor: ThemeColors.get(brightnessKey, 'fill/contrast/600'),
          textColor:
              brightnessKey == 'light'
                  ? const Color(0xFFFFFFFF)
                  : ThemeColors.get(brightnessKey, 'text/base/600'),
          borderColor: ThemeColors.get(brightnessKey, 'text/base/600'),
          boxShadow: [
            BoxShadow(
              color: const Color(0x10182828).withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        );
      case ButtonType.amount:
        return (
          backgroundColor: ThemeColors.get(brightnessKey, 'fill/contrast/600'),
          textColor:
              brightnessKey == 'light'
                  ? const Color(0xFFFFFFFF)
                  : ThemeColors.get(brightnessKey, 'text/base/600'),
          borderColor: ThemeColors.get(brightnessKey, 'text/base/600'),
          boxShadow: [
            BoxShadow(
              color: const Color(0x10182828).withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final style = _resolveStyle(brightnessKey);

    return GestureDetector(
      onTapDown:
          widget.enabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp:
          widget.enabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel:
          widget.enabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.enabled ? widget.onPressed : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(999),
            border:
                style.borderColor != null
                    ? Border.all(color: style.borderColor!, width: 1)
                    : null,
            boxShadow: style.boxShadow,
          ),
          child: Center(
            child: Text(
              widget.type == ButtonType.amount
                  ? widget.text.replaceAll('฿', '')
                  : widget.text,
              style: GoogleFonts.notoSansThai(
                fontSize: 15,
                height: 1.33,
                fontWeight: FontWeight.w700,
                color: style.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
