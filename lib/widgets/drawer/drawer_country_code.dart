import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/widgets/input/search_input.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';

class CountryCode {
  final String name;
  final String code;
  final String flagAsset;

  const CountryCode({
    required this.name,
    required this.code,
    required this.flagAsset,
  });
}

class DrawerCountryCode extends StatefulWidget {
  final String title;
  final List<CountryCode> countries;
  final Function(CountryCode)? onCountrySelected;
  final VoidCallback? onClose;

  const DrawerCountryCode({
    super.key,
    required this.title,
    required this.countries,
    this.onCountrySelected,
    this.onClose,
  });

  static void show(
    BuildContext context, {
    required String title,
    required List<CountryCode> countries,
    Function(CountryCode)? onCountrySelected,
    VoidCallback? onClose,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DrawerCountryCode(
            title: title,
            countries: countries,
            onCountrySelected: onCountrySelected,
            onClose: onClose,
          ),
    );
  }

  @override
  State<DrawerCountryCode> createState() => _DrawerCountryCodeState();
}

class _DrawerCountryCodeState extends State<DrawerCountryCode> {
  final TextEditingController _searchController = TextEditingController();
  List<CountryCode> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = widget.countries;
      } else {
        _filteredCountries =
            widget.countries.where((country) {
              return country.name.toLowerCase().contains(query.toLowerCase()) ||
                  country.code.toLowerCase().contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final bottomPadding =
        mediaQuery.viewPadding.bottom > 0
            ? mediaQuery.viewPadding.bottom
            : mediaQuery.padding.bottom;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {},
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: screenHeight * 0.80,
            decoration: BoxDecoration(
              color: ThemeColors.get(brightnessKey, 'fill/base/100'),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                _buildHeader(context, brightnessKey),
                Expanded(
                  child:
                      _filteredCountries.isEmpty
                          ? _buildEmptyState(context, brightnessKey)
                          : _buildCountryList(context, brightnessKey),
                ),
                if (bottomPadding > 0)
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: bottomPadding,
                        color: ThemeColors.get(
                          brightnessKey,
                          'fill/base/100',
                        ).withValues(alpha: 0.9),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, String brightnessKey) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Opacity(opacity: 0, child: Icon(Icons.close, size: 24)),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Noto Sans Thai',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.51,
                      color: ThemeColors.get(brightnessKey, 'text/base/600'),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onClose?.call();
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  size: 24,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SearchInput(
            controller: _searchController,
            onChanged: _filterCountries,
          ),
        ],
      ),
    );
  }

  Widget _buildCountryList(BuildContext context, String brightnessKey) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        return GestureDetector(
          onTap: () {
            widget.onCountrySelected?.call(country);
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ThemeColors.get(brightnessKey, 'fill/base/300'),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ThemeColors.get(brightnessKey, 'stroke/base/200'),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(country.flagAsset, width: 32, height: 24),
                const SizedBox(width: 8),
                Text(
                  country.code,
                  style: TextStyle(
                    fontFamily: 'Noto Sans Thai',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    country.name,
                    style: TextStyle(
                      fontFamily: 'Noto Sans Thai',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                      color: ThemeColors.get(brightnessKey, 'text/base/600'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, String brightnessKey) {
    return Padding(
      padding: const EdgeInsets.only(top: 96),
      child: Column(
        children: [
          Image.asset(
            'lib/assets/images/empty-state.png',
            width: 144,
            height: 144,
          ),
          Text(
            AppLocalizations.of(context)!.titleDrawerEmptyNoResultsFound,
            style: TextStyle(
              fontFamily: 'Noto Sans Thai',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.51,
              color: ThemeColors.get(brightnessKey, 'text/base/600'),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.descriptionDrawerEmptyTryAgain,
            style: TextStyle(
              fontFamily: 'Noto Sans Thai',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.33,
              color: ThemeColors.get(brightnessKey, 'text/base/400'),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
