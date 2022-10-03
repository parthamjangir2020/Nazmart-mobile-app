import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';

class AllProductsFilter extends StatefulWidget {
  const AllProductsFilter({Key? key}) : super(key: key);

  @override
  State<AllProductsFilter> createState() => _AllProductsFilterState();
}

class _AllProductsFilterState extends State<AllProductsFilter> {
  int selectedCategory = 0;
  int selectedColor = 0;
  double rating = 4;
  RangeValues _currentRangeValues = const RangeValues(10, 80);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 2 + 80,
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
            paragraphStyleTitle('Category'),
            const SizedBox(
              height: 10,
            ),

            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                clipBehavior: Clip.none,
                children: [
                  for (int i = 0; i < 7; i++)
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        selectedCategory = i;
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: selectedCategory == i
                                ? cc.primaryColor.withOpacity(.05)
                                : Colors.white,
                            border: Border.all(
                              color: selectedCategory == i
                                  ? cc.primaryColor
                                  : cc.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            Text(
                              'Gown',
                              style: TextStyle(
                                  color: selectedCategory == i
                                      ? cc.primaryColor
                                      : cc.greyParagraph,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: selectedCategory == i
                                          ? cc.primaryColor
                                          : cc.borderColor,
                                      width: selectedCategory == i ? 4 : 1),
                                  // color: cc.primaryColor,
                                  shape: BoxShape.circle),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),

            //Color ========>
            sizedboxCustom(30),
            paragraphStyleTitle('Color:'),
            //Color circles
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                for (int i = 0; i < 4; i++)
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      selectedColor = i;
                      setState(() {});
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: selectedColor == i
                              ? Colors.white
                              : cc.primaryColor,
                          border: Border.all(
                              color: selectedColor == i
                                  ? cc.primaryColor
                                  : cc.borderColor,
                              width: selectedColor == i ? 6 : 0),
                          // color: cc.primaryColor,
                          shape: BoxShape.circle),
                    ),
                  )
              ],
            ),

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
                  child:
                      CommonHelper().borderButtonPrimary('Clear filter', () {}),
                ),
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
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
