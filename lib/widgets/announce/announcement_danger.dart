import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart' as theme;
import 'package:mcp_test_app/widgets/announce/announcement_warning.dart';

class AnnouncementDanger extends AnnouncementWarning {
  const AnnouncementDanger({
    super.key,
    required super.title,
    required super.description,
    super.descriptionSpans,
  });

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final backgroundColor = theme.ThemeColors.get(brightnessKey, 'danger/600');
    final textColor = theme.ThemeColors.get(brightnessKey, 'text/base/danger');
    final iconColor = theme.ThemeColors.get(brightnessKey, 'danger/500');

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alert Icon
          SvgPicture.asset(
            'lib/assets/images/Alert Icon.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 4),
          // Warning Text Container
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title.isNotEmpty) ...[
                  Text(
                    title,
                    style: GoogleFonts.notoSansThaiTextTheme().bodySmall
                        ?.copyWith(
                          color: textColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          height: 1.27,
                        ),
                  ),
                  const SizedBox(height: 4),
                ],
                descriptionSpans != null
                    ? RichText(
                      text: TextSpan(
                        style: GoogleFonts.notoSansThai(
                          color: textColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          height: 1.45,
                        ),
                        children: descriptionSpans,
                      ),
                    )
                    : Text(
                      description,
                      style: GoogleFonts.notoSansThaiTextTheme().bodySmall
                          ?.copyWith(
                            color: textColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 1.45,
                          ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
