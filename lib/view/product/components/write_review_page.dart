import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:no_name_ecommerce/view/support_ticket/components/textarea_field.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final productId;
  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  double rating = 1;
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon('Write a review', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 15,
            ),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
              itemSize: 32,
              unratedColor: greyFive,
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) {
                rating = value;
                print(rating);
              },
            ),
            sizedboxCustom(20),
            const Text(
              'How was the product?',
              style: TextStyle(
                  color: greyFour, fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 14,
            ),
            TextareaField(
              notesController: reviewController,
              hintText: 'Write a review',
            ),
            sizedboxCustom(20),
            buttonPrimary('Post a review', (() {}))
          ]),
        ),
      ),
    );
  }
}
