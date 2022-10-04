import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:no_name_ecommerce/services/search_product_service.dart';
import 'package:no_name_ecommerce/view/search/components/product_filter.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../utils/constant_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    TextEditingController searchController = TextEditingController();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Consumer<SearchProductService>(
        builder: (context, provider, child) => Row(
          children: [
            //Search bar and dropdown
            Expanded(
              child: TextFormField(
                controller: searchController,
                autofocus: false,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    provider.searchProducts(context, isSearching: true);
                  }
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    provider.setSearchText(value);
                    provider.searchProducts(context, isSearching: true);
                  }
                },
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  hintStyle: TextStyle(color: cc.greyPrimary.withOpacity(.8)),
                  contentPadding: const EdgeInsets.fromLTRB(18, 15, 10, 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ConstantColors().inputFieldBorderColor),
                      borderRadius: BorderRadius.circular(7)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ConstantColors().primaryColor),
                      borderRadius: BorderRadius.circular(7)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                          BorderSide(color: ConstantColors().warningColor)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ConstantColors().primaryColor),
                      borderRadius: BorderRadius.circular(7)),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => const ProductFilter(),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: cc.inputFieldBorderColor)),
                  child: SvgPicture.asset(
                    'assets/svg/filter.svg',
                    height: 23,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
