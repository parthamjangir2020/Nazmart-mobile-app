import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

class ProductDetailsSlider extends StatefulWidget {
  const ProductDetailsSlider({Key? key}) : super(key: key);

  @override
  State<ProductDetailsSlider> createState() => _ProductDetailsSliderState();
}

class _ProductDetailsSliderState extends State<ProductDetailsSlider> {
  final PageController _pageController = PageController();
  int _selectedSlide = 0;
  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 270,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        _selectedSlide = value;
                      });
                    },
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      return CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1621109246687-10ae613f2d8e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTR8fHByb2R1Y3R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      );
                    }),
              ),
            ),

            //slider count show
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //if image gallery exists in database then show it, else show only the thumbnail image
                  for (int i = 0; i < 3; i++)
                    AnimatedContainer(
                      //slider dot /pagination
                      duration: const Duration(milliseconds: 450),
                      curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: _selectedSlide == i
                            ? cc.primaryColor // change color here to see active dot color
                            : Colors.white,
                      ),
                      width: _selectedSlide == i ? 15 : 6,
                      height: 7,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                    )
                ],
              ),
            ),
          ],
        ),

        //Slider bottom images ===================>
      ],
    );
  }
}
