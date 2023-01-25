import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/order/order_details_page.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';

class RefundProductsListPage extends StatefulWidget {
  const RefundProductsListPage({Key? key}) : super(key: key);

  @override
  _RefundProductsListPageState createState() => _RefundProductsListPageState();
}

class _RefundProductsListPageState extends State<RefundProductsListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon('Refund products', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: screenPadHorizontal, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const OrderDetailsPage(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              titleCommon('Women Casual Short Dress',
                                  fontsize: 15),
                              sizedboxCustom(8),
                              paragraphCommon('Order id:#7  |  Date: 12-02-17'),
                              sizedboxCustom(6),
                              paragraphCommon(
                                  'Amount: \$10  |  Status: Not refunded',
                                  color: successColor)
                            ]),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: greyFour,
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        width: 195,
        decoration: BoxDecoration(
          color: successColor,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 11,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.message_outlined,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
          paragraphCommon('Refund conversations',
              color: Colors.white, lineHeight: 1)
        ]),
      ),
    );
  }
}
