import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

class ProductDetailsBottom extends StatefulWidget {
  const ProductDetailsBottom({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailsBottom> createState() => _ProductDetailsBottomState();
}

class _ProductDetailsBottomState extends State<ProductDetailsBottom> {
  @override
  void initState() {
    super.initState();
  }

  bool isAddedTocart = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 17),
      decoration: const BoxDecoration(
        // color: cc.blackColor,
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Row(
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
                  'Buy now',
                  style: TextStyle(
                    color: Color(0xff667085),
                    fontSize: 14,
                  ),
                )),
          )),
          const SizedBox(
            width: 15,
          ),
          //======>
          Expanded(
            child: CommonHelper()
                .buttonPrimary('Add to cart', () {}, borderRadius: 100),
          ),
        ],
      ),
    );
  }
}
