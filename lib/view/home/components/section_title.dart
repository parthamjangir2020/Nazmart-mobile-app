import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:provider/provider.dart';

import '../../utils/constant_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.pressed,
    this.hasSeeAllBtn = true,
  }) : super(key: key);

  final String title;
  final VoidCallback? pressed;
  final bool hasSeeAllBtn;

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslateStringService>(
      builder: (context, asProvider, child) => Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: blackCustomColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasSeeAllBtn)
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: pressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      asProvider.getString('See all'),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: primaryColor,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
