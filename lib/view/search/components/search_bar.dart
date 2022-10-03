import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaika/search/service/search_product_service.dart';

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
        builder: (context, provider, child) => Column(
          children: [
            //Search bar and dropdown
            Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.01),
                          spreadRadius: -2,
                          blurRadius: 13,
                          offset: const Offset(0, 13)),
                    ],
                    borderRadius: BorderRadius.circular(3)),
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
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search",
                      hintStyle:
                          TextStyle(color: cc.greyPrimary.withOpacity(.8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 15)),
                )),
          ],
        ),
      ),
    );
  }
}
