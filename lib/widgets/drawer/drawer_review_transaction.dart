import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/widgets/announce/announcement_warning.dart';
import 'package:mcp_test_app/widgets/card/card_review_transaction.dart';
import 'package:mcp_test_app/widgets/button/buttons.dart';

class DrawerReviewTransaction extends StatelessWidget {
  final String warningTitle;
  final String warningDescription;
  final String totalAmount;
  final String feeAmount;
  final String fromLabel;
  final String fromValue;
  final String mobileLabel;
  final String mobileValue;
  final String toLabel;
  final String toValue;
  final String accountNameLabel;
  final String accountNameValue;
  final String accountNumberLabel;
  final String accountNumberValue;
  final String objectLabel;
  final String objectValue;
  final String dateLabel;
  final String dateValue;
  final String confirmButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onClose;

  const DrawerReviewTransaction({
    super.key,
    required this.warningTitle,
    required this.warningDescription,
    required this.totalAmount,
    this.feeAmount = '0.00',
    required this.fromLabel,
    required this.fromValue,
    required this.mobileLabel,
    required this.mobileValue,
    required this.toLabel,
    required this.toValue,
    required this.accountNameLabel,
    required this.accountNameValue,
    required this.accountNumberLabel,
    required this.accountNumberValue,
    required this.objectLabel,
    required this.objectValue,
    required this.dateLabel,
    required this.dateValue,
    this.confirmButtonText = 'Confirm',
    this.onConfirm,
    this.onClose,
  });

  static Future<void> show(
    BuildContext context, {
    required String warningTitle,
    required String warningDescription,
    required String totalAmount,
    String feeAmount = '0.00',
    required String fromLabel,
    required String fromValue,
    required String mobileLabel,
    required String mobileValue,
    required String toLabel,
    required String toValue,
    required String accountNameLabel,
    required String accountNameValue,
    required String accountNumberLabel,
    required String accountNumberValue,
    required String objectLabel,
    required String objectValue,
    required String dateLabel,
    required String dateValue,
    String confirmButtonText = 'Confirm',
    VoidCallback? onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
      builder:
          (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: DrawerReviewTransaction(
              warningTitle: warningTitle,
              warningDescription: warningDescription,
              totalAmount: totalAmount,
              feeAmount: feeAmount,
              fromLabel: fromLabel,
              fromValue: fromValue,
              mobileLabel: mobileLabel,
              mobileValue: mobileValue,
              toLabel: toLabel,
              toValue: toValue,
              accountNameLabel: accountNameLabel,
              accountNameValue: accountNameValue,
              accountNumberLabel: accountNumberLabel,
              accountNumberValue: accountNumberValue,
              objectLabel: objectLabel,
              objectValue: objectValue,
              dateLabel: dateLabel,
              dateValue: dateValue,
              confirmButtonText: confirmButtonText,
              onConfirm: onConfirm,
              onClose: () => Navigator.pop(context),
            ),
          ),
    );
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

    return Container(
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
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    'Review',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansThai(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.51,
                      color: ThemeColors.get(brightnessKey, 'text/base/600'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Warning
                  AnnouncementWarning(
                    title: warningTitle,
                    description: warningDescription,
                  ),
                  const SizedBox(height: 16),
                  // Transaction Details
                  CardReviewTransaction(
                    totalAmount: totalAmount,
                    feeAmount: feeAmount,
                    fromLabel: fromLabel,
                    fromValue: fromValue,
                    mobileLabel: mobileLabel,
                    mobileValue: mobileValue,
                    toLabel: toLabel,
                    toValue: toValue,
                    accountNameLabel: accountNameLabel,
                    accountNameValue: accountNameValue,
                    accountNumberLabel: accountNumberLabel,
                    accountNumberValue: accountNumberValue,
                    dateLabel: dateLabel,
                    dateValue: dateValue,
                  ),
                  const SizedBox(height: 8),
                  // Object Label
                  Text(
                    objectLabel,
                    style: GoogleFonts.notoSansThai(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.51,
                      color: ThemeColors.get(brightnessKey, 'text/base/600'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Object Value
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ThemeColors.get(brightnessKey, 'fill/base/300'),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      objectValue,
                      style: GoogleFonts.notoSansThai(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.23,
                        color: ThemeColors.get(brightnessKey, 'text/base/600'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Confirm Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Buttons(
              text: confirmButtonText,
              type: ButtonType.primary,
              onPressed: onConfirm,
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
}
