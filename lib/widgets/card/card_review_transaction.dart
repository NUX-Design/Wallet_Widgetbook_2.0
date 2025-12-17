import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

class CardReviewTransaction extends StatelessWidget {
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
  final String dateLabel;
  final String dateValue;

  const CardReviewTransaction({
    super.key,
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
    required this.dateLabel,
    required this.dateValue,
  });

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeColors.get(brightnessKey, 'fill/base/300'),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Total Section
          Column(
            children: [
              Text(
                'Total',
                style: GoogleFonts.notoSansThai(
                  fontSize: 15,
                  height: 1.51,
                  fontWeight: FontWeight.w600,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                totalAmount,
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansThai(
                  fontSize: 22,
                  height: 1.27,
                  fontWeight: FontWeight.w700,
                  color: ThemeColors.get(brightnessKey, 'success/500'),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    feeAmount,
                    style: GoogleFonts.notoSansThai(
                      fontSize: 13,
                      height: 1.23,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.get(brightnessKey, 'text/base/600'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: ThemeColors.get(brightnessKey, 'stroke/base/200'),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
          // Transaction Details
          Column(
            children: [
              _buildDetailRow(fromLabel, fromValue, brightnessKey),
              const SizedBox(height: 16),
              _buildDetailRow(mobileLabel, mobileValue, brightnessKey),
              const SizedBox(height: 16),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  color: ThemeColors.get(brightnessKey, 'stroke/base/200'),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow(toLabel, toValue, brightnessKey),
              const SizedBox(height: 16),
              _buildDetailRow(
                accountNameLabel,
                accountNameValue,
                brightnessKey,
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                accountNumberLabel,
                accountNumberValue,
                brightnessKey,
              ),
              const SizedBox(height: 16),
              _buildDetailRow(dateLabel, dateValue, brightnessKey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, String brightnessKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSansThai(
            fontSize: 13,
            height: 1.23,
            fontWeight: FontWeight.w600,
            color: ThemeColors.get(brightnessKey, 'text/base/400'),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.notoSansThai(
              fontSize: 13,
              height: 1.23,
              fontWeight: FontWeight.w600,
              color: ThemeColors.get(brightnessKey, 'text/base/600'),
            ),
          ),
        ),
      ],
    );
  }
}
