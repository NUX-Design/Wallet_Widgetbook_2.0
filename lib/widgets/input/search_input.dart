import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const SearchInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
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

    final borderColor =
        _hasFocus
            ? ThemeColors.get(brightnessKey, 'primary/400')
            : ThemeColors.get(brightnessKey, 'stroke/base/200');
    final backgroundColor = ThemeColors.get(brightnessKey, 'fill/base/300');

    return Container(
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
          SvgPicture.asset(
            'lib/assets/images/search-02.svg',
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              _hasFocus
                  ? ThemeColors.get(brightnessKey, 'text/base/600')
                  : ThemeColors.get(brightnessKey, 'stroke/base/600'),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              cursorColor: ThemeColors.get(brightnessKey, 'text/base/600'),
              style: GoogleFonts.notoSansThai(
                fontSize: 15,
                height: 1.33,
                color:
                    _hasText
                        ? ThemeColors.get(brightnessKey, 'text/base/600')
                        : ThemeColors.get(brightnessKey, 'text/base/400'),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                hintText: 'Search',
                hintStyle: GoogleFonts.notoSansThai(
                  fontSize: 15,
                  height: 1.33,
                  color: ThemeColors.get(brightnessKey, 'text/base/400'),
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ),
          if (_hasText)
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
    );
  }
}
