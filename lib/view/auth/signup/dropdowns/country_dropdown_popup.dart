import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/dropdowns_services/country_dropdown_service.dart';
import 'package:no_name_ecommerce/services/dropdowns_services/state_dropdown_services.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CountryDropdownPopup extends StatelessWidget {
  const CountryDropdownPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: true);

    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: context.watch<CountryDropdownService>().currentPage > 1
            ? false
            : true,
        onRefresh: () async {
          final result =
              await Provider.of<CountryDropdownService>(context, listen: false)
                  .fetchCountries(context);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<CountryDropdownService>(context, listen: false)
                  .fetchCountries(context);
          if (result) {
            debugPrint('loadcomplete ran');
            //loadcomplete function loads the data again
            refreshController.loadComplete();
          } else {
            debugPrint('no more data');
            refreshController.loadNoData();

            Future.delayed(const Duration(seconds: 1), () {
              //it will reset footer no data state to idle and will let us load again
              refreshController.resetNoData();
            });
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<CountryDropdownService>(
              builder: (context, p, child) => Column(
                children: [
                  gapH(30),
                  CustomInput(
                    hintText: 'Search country',
                    paddingHorizontal: 17,
                    icon: 'assets/icons/search.png',
                    onChanged: (v) {
                      p.searchCountry(context, v, isSearching: true);
                    },
                  ),
                  gapH(10),
                  p.countryDropdownList.isNotEmpty
                      ? p.countryDropdownList[0] != 'Select Country'
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: p.countryDropdownList.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    p.setCountryValue(p.countryDropdownList[i]);

                                    //                         // setting the id of selected value
                                    p.setSelectedCountryId(
                                        p.countryDropdownIndexList[
                                            p.countryDropdownList.indexOf(
                                                p.countryDropdownList[i])]);

                                    Navigator.pop(context);

                                    Provider.of<StateDropdownService>(context,
                                            listen: false)
                                        .setStateDefault();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom:
                                                BorderSide(color: greyFive))),
                                    child: paragraphCommon(
                                      '${p.countryDropdownList[i]}',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                );
                              })
                          : paragraphCommon('No country found')
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [showLoading(primaryColor)],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
