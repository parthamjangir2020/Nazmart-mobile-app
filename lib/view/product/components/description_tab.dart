import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paragraphCommon(
            'Lorem Ipsum is simply dummy text of the printing and typesetting',
            textAlign: TextAlign.start),
      ],
    );
  }
}
