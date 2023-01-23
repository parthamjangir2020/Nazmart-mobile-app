import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class ColorAndSize extends StatefulWidget {
  const ColorAndSize({Key? key}) : super(key: key);

  @override
  State<ColorAndSize> createState() => _ColorAndSizeState();
}

class _ColorAndSizeState extends State<ColorAndSize> {
  int selectedColor = -1;
  int selectedSize = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Size ================>

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 18,
                ),
                paragraphStyleTitle('Size:'),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffF2F4F7),
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: Row(
                    children: [
                      for (int i = 0; i < 3; i++)
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            selectedSize = i;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: i != 2 ? 12 : 0),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: selectedSize == i
                                    ? primaryColor
                                    : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: selectedSize == i
                                        ? Colors.transparent
                                        : greyFive)),
                            child: Text(
                              "X",
                              style: TextStyle(
                                  color: selectedSize == i
                                      ? Colors.white
                                      : greyParagraph,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            //color ============>
            sizedboxCustom(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                paragraphStyleTitle('Color:'),
                sizedboxCustom(12),
                // Container(
                //   margin: const EdgeInsets.only(top: 5),
                //   height: 37,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     clipBehavior: Clip.none,
                //     children: [
                //       for (int i = 0; i < 3; i++)
                //         InkWell(
                //           highlightColor: Colors.transparent,
                //           splashColor: Colors.transparent,
                //           onTap: () {
                //             selectedColor = i;
                //             setState(() {});
                //           },
                //           child: Container(
                //             margin: const EdgeInsets.only(right: 12),
                //             alignment: Alignment.center,
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 10, vertical: 2),
                //             decoration: BoxDecoration(
                //                 color: selectedColor == i
                //                     ? primaryColor
                //                     : Colors.white,
                //                 borderRadius: BorderRadius.circular(7),
                //                 border: Border.all(
                //                     color: selectedColor == i
                //                         ? Colors.transparent
                //                         : greyFive)),
                //             child: Text(
                //               "Red",
                //               style: TextStyle(
                //                   color: selectedColor == i
                //                       ? Colors.white
                //                       : greyParagraph,
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //           ),
                //         )
                //     ],
                //   ),
                // ),
              ],
            ),

            //Color circles
            // const SizedBox(
            //   height: 8,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                  color: const Color(0xffF2F4F7),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectedColor = i;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: i != 2 ? 10 : 0),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Color(0xff8479E1), shape: BoxShape.circle),
                        child: selectedColor == i
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : Container(),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
