import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:no_name_ecommerce/view/home/components/categories.dart';
import 'package:no_name_ecommerce/view/product/components/color_size.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({Key? key}) : super(key: key);

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  int selectedCategory = 0;
  int selectedColor = 0;
  double rating = 4;
  RangeValues _currentRangeValues = const RangeValues(10, 80);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 2 + 210,
      color: Colors.white,
      padding:
          EdgeInsets.symmetric(horizontal: screenPadHorizontal, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonHelper().titleCommon('Filter by:'),
            sizedboxCustom(20),

            //Category =====>
            paragraphStyleTitle('Category:'),
            sizedboxCustom(12),
            const Categories(marginRight: 20),

            //Color ========>

            //=========>
            const ColorAndSize(),

            //Price range =========>
            sizedboxCustom(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                paragraphStyleTitle('Price range:'),
                Text(
                  '\$${_currentRangeValues.start.round().toString()} - \$${_currentRangeValues.end.round().toString()}',
                  style: TextStyle(
                      color: cc.greyFour,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SliderTheme(
              data: const SliderThemeData(
                trackHeight: 1,
              ),
              child: RangeSlider(
                values: _currentRangeValues,

                max: 100,
                // divisions: 5,
                activeColor: cc.primaryColor,
                inactiveColor: Colors.grey.withOpacity(.2),
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            paragraphStyleTitle('Ratings:'),
            sizedboxCustom(10),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
              itemSize: 30,
              unratedColor: cc.greyFive,
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) {
                rating = value;
                print(rating);
              },
            ),

            // Reset filter and apply button
            sizedboxCustom(30),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                          color: const Color(0xffEAECF0),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Text(
                        'Clear',
                        style: TextStyle(
                          color: Color(0xff667085),
                          fontSize: 14,
                        ),
                      )),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CommonHelper().buttonPrimary('Apply filter', () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) =>
                    //         const AllproductPage(),
                    //   ),
                    // );
                  }, borderRadius: 100),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
