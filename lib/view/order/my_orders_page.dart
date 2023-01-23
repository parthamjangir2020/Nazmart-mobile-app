import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon('My orders', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedboxCustom(15),
                for (int i = 0; i < 2; i++)
                  ExpandablePanel(
                    controller: ExpandableController(initialExpanded: false),
                    theme: const ExpandableThemeData(hasIcon: false),
                    header: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                capsule('Pending'),
                                const SizedBox(
                                  width: 17,
                                ),
                                AutoSizeText(
                                  '#545121',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: greyFour,
                                      // height: 2.2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                            )
                          ],
                        ),
                      ]),
                    ),
                    collapsed: const Text(''),
                    expanded: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              for (int i = 0; i < 2; i++)
                                //product ===>
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: i != 1 ? 19 : 0),
                                  child: Row(
                                    children: [
                                      //title image price
                                      Expanded(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          commonImage(
                                              "https://images.unsplash.com/photo-1560393464-5c69a73c5770?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fHByb2R1Y3R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                                              55,
                                              55),

                                          const SizedBox(
                                            width: 10,
                                          ),
                                          //title and price
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Casual summer dress',
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: blackCustomColor,
                                                      fontSize: 13,
                                                      height: 1.4,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),

                                                //Price and stock
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  "\$120",
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      //Delete button
                                      Container(
                                        height: 35,
                                        width: 35,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: borderColor),
                                        ),
                                        child: Text(
                                          'x3',
                                          style:
                                              TextStyle(color: greyParagraph),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              sizedboxCustom(20),
                              greyButton('Details', verticalPadding: 14),
                            ],
                          ),
                        ),
                        sizedboxCustom(20),
                      ],
                    ),
                  ),
              ]),
        ),
      ),
    );
  }
}
