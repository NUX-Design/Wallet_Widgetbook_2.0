import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';

enum BankType { scb, kbank, bbl, krungsri }

class DrawerDepositChannel extends StatelessWidget {
  static const List<BankType> _banks = [
    BankType.scb,
    BankType.bbl,
    BankType.krungsri,
    BankType.kbank,
  ];

  final VoidCallback? onClose;
  final Function(BankType)? onBankSelected;

  const DrawerDepositChannel({super.key, this.onClose, this.onBankSelected});

  static Future<void> show(
    BuildContext context, {
    Function(BankType)? onBankSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
      builder:
          (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: DrawerDepositChannel(
              onBankSelected: onBankSelected,
              onClose: () => Navigator.pop(context),
            ),
          ),
    );
  }

  String _getBankName(BankType bank) {
    switch (bank) {
      case BankType.scb:
        return 'Siam Commercial Bank';
      case BankType.kbank:
        return 'Kasikorn Bank';
      case BankType.bbl:
        return 'Bangkok Bank Mobile Banking';
      case BankType.krungsri:
        return 'Bank of Ayudhya';
    }
  }

  String _getBankLogo(BankType bank) {
    switch (bank) {
      case BankType.scb:
        return 'lib/assets/images/figma_banks/scb.svg';
      case BankType.kbank:
        return 'lib/assets/images/figma_banks/kbank.svg';
      case BankType.bbl:
        return 'lib/assets/images/figma_banks/bbl.svg';
      case BankType.krungsri:
        return 'lib/assets/images/figma_banks/krungsri.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding =
        mediaQuery.viewPadding.bottom > 0
            ? mediaQuery.viewPadding.bottom
            : mediaQuery.padding.bottom;
    final drawerHeight = math.min(mediaQuery.size.height * 0.80, 640.0);

    return Container(
      width: double.infinity,
      height: drawerHeight,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
      decoration: BoxDecoration(
        color: ThemeColors.get(brightnessKey, 'fill/base/100'),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(
            brightnessKey,
            l10n?.titleDrawerDepositChannel ?? 'Deposit Channel',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildLabelContainer(brightnessKey),
                  const SizedBox(height: 16),
                  for (var i = 0; i < _banks.length; i++) ...[
                    _buildBankItem(brightnessKey, _banks[i]),
                    if (i != _banks.length - 1) const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
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
    );
  }

  Widget _buildHeader(String brightnessKey, String title) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24, height: 24),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.notoSansThai(
                  fontSize: 15,
                  height: 1.0,
                  fontWeight: FontWeight.w600,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                ThemeColors.get(brightnessKey, 'text/base/600'),
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'lib/assets/images/cancel-01.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelContainer(String brightnessKey) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ThemeColors.get(brightnessKey, 'fill/base/600'),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Mobile Banking',
          style: GoogleFonts.notoSansThai(
            fontSize: 10,
            height: 1.2,
            fontWeight: FontWeight.w600,
            color: ThemeColors.get(brightnessKey, 'text/base/600'),
          ),
        ),
      ),
    );
  }

  Widget _buildBankItem(String brightnessKey, BankType bank) {
    return GestureDetector(
      onTap: () => onBankSelected?.call(bank),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ThemeColors.get(brightnessKey, 'fill/base/300'),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(_getBankLogo(bank), width: 24, height: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _getBankName(bank),
                style: GoogleFonts.notoSansThai(
                  fontSize: 13,
                  height: 16 / 13,
                  fontWeight: FontWeight.w600,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
