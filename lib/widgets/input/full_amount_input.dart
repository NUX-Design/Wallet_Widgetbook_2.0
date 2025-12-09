import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

class FullAmountInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String infoText;
  final bool enabled;

  const FullAmountInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.infoText = 'ท่านต้องฝากเงินอย่างน้อย 100 THB',
    this.enabled = true,
  });

  @override
  State<FullAmountInput> createState() => _FullAmountInputState();
}

class _FullAmountInputState extends State<FullAmountInput> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        TextEditingController(text: widget.initialValue ?? '');
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _onFocusChanged() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  bool get _isError {
    if (!widget.enabled) return false;
    if (!_hasFocus && !_hasText) return false;
    final value = double.tryParse(_controller.text) ?? 0;
    return value < 100;
  }

  bool get _isSuccess {
    if (!widget.enabled) return false;
    final value = double.tryParse(_controller.text) ?? 0;
    return value >= 100;
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    Color borderColor;
    if (!widget.enabled) {
      borderColor = ThemeColors.get(brightnessKey, 'stroke/base/200');
    } else if (_isError) {
      borderColor = ThemeColors.get(brightnessKey, 'text/base/danger');
    } else if (_isSuccess && _hasFocus) {
      borderColor = ThemeColors.get(brightnessKey, 'primary/400');
    } else {
      borderColor = ThemeColors.get(brightnessKey, 'stroke/base/200');
    }

    final backgroundColor =
        widget.enabled
            ? ThemeColors.get(brightnessKey, 'fill/base/300')
            : ThemeColors.get(brightnessKey, 'fill/base/100');

    final textColor =
        widget.enabled
            ? ((_hasText || _hasFocus)
                ? ThemeColors.get(brightnessKey, 'text/base/600')
                : ThemeColors.get(brightnessKey, 'text/base/400'))
            : ThemeColors.get(brightnessKey, 'text/base/400');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              Text(
                '฿',
                style: GoogleFonts.notoSansThai(
                  fontSize: 15,
                  height: 1.33,
                  color: textColor,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  cursorColor: ThemeColors.get(brightnessKey, 'text/base/600'),
                  style: GoogleFonts.notoSansThai(
                    fontSize: 15,
                    height: 1.33,
                    color:
                        widget.enabled && _hasText
                            ? ThemeColors.get(brightnessKey, 'text/base/600')
                            : ThemeColors.get(brightnessKey, 'text/base/400'),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.notoSansThai(
                      fontSize: 15,
                      height: 1.33,
                      color: ThemeColors.get(brightnessKey, 'text/base/400'),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: widget.onChanged,
                ),
              ),
              if (_hasText && widget.enabled)
                GestureDetector(
                  onTap: () {
                    _controller.clear();
                    widget.onChanged?.call('');
                  },
                  child: SvgPicture.asset(
                    'lib/assets/images/cancel-circle.svg',
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      ThemeColors.get(brightnessKey, 'stroke/base/600'),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 12,
          child: Text(
            widget.infoText,
            style: GoogleFonts.notoSansThai(
              fontSize: 10,
              height: 1.2,
              fontWeight: FontWeight.w600,
              color:
                  !widget.enabled
                      ? ThemeColors.get(brightnessKey, 'text/base/400')
                      : _isError
                      ? ThemeColors.get(brightnessKey, 'text/base/danger')
                      : _isSuccess
                      ? ThemeColors.get(brightnessKey, 'text/base/success')
                      : ThemeColors.get(brightnessKey, 'text/base/400'),
            ),
          ),
        ),
      ],
    );
  }
}
