import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

class ProductDetailsIncreaseQty extends StatelessWidget {
  const ProductDetailsIncreaseQty({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //decrease quanity
              InkWell(
                onTap: () {},
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.2),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.remove,
                    color: Colors.black.withOpacity(.5),
                    size: 19,
                  ),
                ),
              ),

              //Quantity text
              Container(
                  alignment: Alignment.center,
                  child: const Text(
                    '2',
                    style: TextStyle(
                        color: greyPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),

              //increase quantity
              InkWell(
                onTap: () {},
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.2),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                    color: Colors.black.withOpacity(.5),
                    size: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
