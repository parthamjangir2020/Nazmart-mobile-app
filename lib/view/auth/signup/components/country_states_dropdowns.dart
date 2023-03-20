import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/country_states_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class CountryStatesDropdowns extends StatefulWidget {
  const CountryStatesDropdowns({Key? key}) : super(key: key);

  @override
  State<CountryStatesDropdowns> createState() => _CountryStatesDropdownsState();
}

class _CountryStatesDropdownsState extends State<CountryStatesDropdowns> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //fetch country
    Provider.of<CountryStatesService>(context, listen: false)
        .fetchCountries(context);

    return Consumer<CountryStatesService>(
        builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //dropdown and search box
                const SizedBox(
                  width: 17,
                ),

                // Country dropdown ===============>
                labelCommon(ConstString.chooseCountry),
                provider.countryDropdownList.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: greyFive),
                          borderRadius:
                              BorderRadius.circular(globalBorderRadius),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            // menuMaxHeight: 200,
                            // isExpanded: true,
                            value: provider.selectedCountry,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: const TextStyle(color: greyFour),
                            onChanged: (newValue) {
                              provider.setCountryValue(newValue);

                              // setting the id of selected value
                              provider.setSelectedCountryId(
                                  provider.countryDropdownIndexList[provider
                                      .countryDropdownList
                                      .indexOf(newValue!)]);

                              //fetch states based on selected country
                              provider.fetchState(
                                  provider.selectedCountryId, context);
                            },
                            items: provider.countryDropdownList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: greyPrimary.withOpacity(.8)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [showLoading(primaryColor)],
                      ),

                const SizedBox(
                  height: 22,
                ),
                // States dropdown ===============>
                labelCommon(ConstString.chooseStates),
                provider.statesDropdownList.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: greyFive),
                          borderRadius:
                              BorderRadius.circular(globalBorderRadius),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            // menuMaxHeight: 200,
                            // isExpanded: true,
                            value: provider.selectedState,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: const TextStyle(color: greyFour),
                            onChanged: (newValue) {
                              provider.setStatesValue(newValue);

                              //setting the id of selected value
                              provider.setSelectedStatesId(
                                  provider.statesDropdownIndexList[provider
                                      .statesDropdownList
                                      .indexOf(newValue!)]);
                              // //fetch area based on selected country and state

                              // provider.fetchCity(provider.selectedCountryId,
                              //     provider.selectedStateId, context);

                              // print(provider.statesDropdownIndexList[provider
                              //     .statesDropdownList
                              //     .indexOf(newValue)]);
                            },
                            items: provider.statesDropdownList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: greyPrimary.withOpacity(.8)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [showLoading(primaryColor)],
                      ),
              ],
            ));
  }
}
