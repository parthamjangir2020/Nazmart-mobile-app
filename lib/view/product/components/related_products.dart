// import 'package:flutter/material.dart';
// import 'package:no_name_ecommerce/services/product_details_service.dart';
// import 'package:no_name_ecommerce/view/home/components/product_card.dart';
// import 'package:no_name_ecommerce/view/home/components/section_title.dart';
// import 'package:no_name_ecommerce/view/product/product_details_page.dart';
// import 'package:provider/provider.dart';

// class RelatedProducts extends StatelessWidget {
//   const RelatedProducts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProductDetailsService>(
//       builder: (context, provider, child) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionTitle(
//             title: 'Related products',
//             hasSeeAllBtn: false,
//           ),
//           const SizedBox(
//             height: 18,
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 5),
//             height: 295,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               clipBehavior: Clip.none,
//               children: [
//                 for (int i = 0; i < provider.productDetails!.relatedProducts.length; i++)
//                   ProductCard(
//                       imageLink:
//                           provider.productDetails.relatedProducts[i].,
//                       title: 'Black T-Shirt',
//                       width: 180,
//                       marginRight: 20,
//                       pressed: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute<void>(
//                             builder: (BuildContext context) =>
//                                 const ProductDetailsPage(
//                               productId: '239',
//                             ),
//                           ),
//                         );
//                       },
//                       price: 32.99,
//                       camapaignId: 1)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
