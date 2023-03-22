import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/order/components/free_ship_option.dart';
import 'package:no_name_ecommerce/view/order/components/shipping_option.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var enteredDeliveryAddress =
        Provider.of<DeliveryAddressService>(context, listen: false)
            .enteredDeliveryAddress;

    if (enteredDeliveryAddress == null) {
      addressFromProfile();
    } else {
      addressNewEntered(enteredDeliveryAddress);
    }
  }

  addressNewEntered(address) {
    fullNameController.text = address['name'];
    emailController.text = address['email'];
    phoneController.text = address['phone'];
    cityController.text = address['city'];
    zipController.text = address['zip'];
    addressController.text = address['address'];
  }

//==================>
  addressFromProfile() {
    fullNameController.text =
        Provider.of<ProfileService>(context, listen: false)
                .profileDetails
                ?.userDetails
                .name ??
            '';

    emailController.text = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .email ??
        '';

    phoneController.text = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .mobile ??
        '';
    // zipController.text = Provider.of<ProfileService>(context, listen: false)
    //         .profileDetails
    //         ?.userDetails
    //         ?.zipcode ??
    // '';
    addressController.text = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .address ??
        '';
    cityController.text = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            ?.userDetails
            .city ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon('Delivery address', context, () {
        Navigator.pop(context);
      }),
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Consumer<TranslateStringService>(
            builder: (context, ln, child) => Consumer<DeliveryAddressService>(
              builder: (context, dProvider, child) => Consumer<CartService>(
                builder: (context, cProvider, child) => Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenPadHorizontal, vertical: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CountryStatesDropdowns(),

                          gapH(20),
                          //Name ============>
                          labelCommon(ConstString.fullName),

                          CustomInput(
                            controller: fullNameController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln
                                    .getString(ConstString.plzEnterFullName);
                              }
                              return null;
                            },
                            hintText: ln.getString(ConstString.enterFullName),
                            // icon: 'assets/icons/user.png',
                            paddingHorizontal: 17,
                            textInputAction: TextInputAction.next,
                          ),
                          gapH(5),

                          //Email ============>
                          labelCommon(ConstString.email),

                          CustomInput(
                            controller: emailController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln.getString(ConstString.plzEnterEmail);
                              }
                              return null;
                            },
                            hintText: ln.getString(ConstString.enterEmail),
                            // icon: 'assets/icons/email-grey.png',
                            paddingHorizontal: 17,
                            textInputAction: TextInputAction.next,
                          ),
                          gapH(5),

                          //Phone ============>
                          labelCommon(ConstString.phone),

                          CustomInput(
                            controller: phoneController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln.getString(ConstString.plzEnterPhone);
                              }
                              return null;
                            },
                            hintText:
                                ln.getString(ConstString.enterPhoneNumber),
                            isNumberField: true,
                            // icon: 'assets/icons/email-grey.png',
                            paddingHorizontal: 17,
                            textInputAction: TextInputAction.next,
                          ),

                          gapH(10),

                          //City /town ============>
                          labelCommon(ConstString.cityTown),

                          CustomInput(
                            controller: cityController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln
                                    .getString(ConstString.plzEnterCityTown);
                              }
                              return null;
                            },
                            hintText: ln.getString(ConstString.enterCityTown),
                            // icon: 'assets/icons/email-grey.png',
                            paddingHorizontal: 17,
                            textInputAction: TextInputAction.next,
                          ),

                          gapH(5),

                          //Zip code ============>
                          // labelCommon(ConstString.zipCode),

                          // CustomInput(
                          //   controller: zipController,
                          //   validation: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return ln.getString(ConstString.plzEnterZip);
                          //     }
                          //     return null;
                          //   },
                          //   hintText: ln.getString(ConstString.enterZip),
                          //   paddingHorizontal: 17,
                          //   textInputAction: TextInputAction.next,
                          // ),

                          // gapH(5),

                          //Zip code ============>
                          labelCommon(ConstString.address),

                          CustomInput(
                            controller: addressController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln
                                    .getString(ConstString.plzEnterAddress);
                              }
                              return null;
                            },
                            hintText: ln.getString(ConstString.enterAddress),
                            paddingHorizontal: 17,
                            textInputAction: TextInputAction.next,
                          ),

                          gapH(5),
                          // Shipping options

                          dProvider.shippingCostDetails != null
                              ? dProvider.hasError != true
                                  ? Column(
                                      children: [
                                        //default shipping
                                        InkWell(
                                          onTap: () {
                                            var minOrder = dProvider
                                                    .shippingCostDetails
                                                    ?.defaultShippingOptions
                                                    .options
                                                    ?.minimumOrderAmount ??
                                                0;
                                            var couponNeeded =
                                                dProvider.checkIfCouponNeed(
                                                    dProvider
                                                        .shippingCostDetails
                                                        ?.defaultShippingOptions
                                                        .options
                                                        ?.coupon,
                                                    context);
                                            if (cProvider.subTotal < minOrder) {
                                              showToast(
                                                  ln.getString(
                                                          ConstString.minimum) +
                                                      ' \$$minOrder ' +
                                                      ln.getString(ConstString
                                                          .orderIsNeeded),
                                                  Colors.black);
                                              return;
                                            } else if (couponNeeded) {
                                              showToast(
                                                  ln.getString(
                                                      ConstString.couponNeeded),
                                                  Colors.black);
                                              return;
                                            }

                                            dProvider.setShipIdAndCosts(
                                                dProvider
                                                    .shippingCostDetails
                                                    ?.defaultShippingOptions
                                                    .options
                                                    ?.shippingMethodId,
                                                dProvider
                                                        .shippingCostDetails
                                                        ?.defaultShippingOptions
                                                        .options
                                                        ?.cost ??
                                                    0,
                                                dProvider
                                                    .shippingCostDetails
                                                    ?.defaultShippingOptions
                                                    .name,
                                                context);

                                            setState(() {
                                              dProvider
                                                  .setSelectedShipIndex(-1);
                                            });
                                          },
                                          child: FreeShipOption(
                                            selectedShipping:
                                                dProvider.selectedShippingIndex,
                                          ),
                                        ),

                                        //Other shipping option ======>
                                        for (int i = 0;
                                            i <
                                                dProvider.shippingCostDetails!
                                                    .shippingOptions.length;
                                            i++)
                                          if (dProvider.shippingCostDetails!
                                                  .shippingOptions[i].id !=
                                              dProvider.shippingCostDetails!
                                                  .defaultShippingOptions.id)
                                            InkWell(
                                              onTap: () {
                                                var minOrder = dProvider
                                                        .shippingCostDetails
                                                        ?.shippingOptions[i]
                                                        .options
                                                        ?.minimumOrderAmount ??
                                                    0;
                                                var couponNeeded =
                                                    dProvider.checkIfCouponNeed(
                                                        dProvider
                                                            .shippingCostDetails
                                                            ?.shippingOptions[i]
                                                            .options
                                                            ?.coupon,
                                                        context);
                                                if (cProvider.subTotal <
                                                    minOrder) {
                                                  showToast(
                                                      ln.getString(ConstString
                                                              .minimum) +
                                                          ' \$$minOrder ' +
                                                          ln.getString(ConstString
                                                              .orderIsNeeded),
                                                      Colors.black);
                                                  return;
                                                } else if (couponNeeded) {
                                                  showToast(
                                                      ln.getString(ConstString
                                                          .couponNeeded),
                                                      Colors.black);

                                                  return;
                                                }
                                                dProvider.setShipIdAndCosts(
                                                    dProvider
                                                        .shippingCostDetails
                                                        ?.shippingOptions[i]
                                                        .options
                                                        ?.shippingMethodId,
                                                    dProvider
                                                        .shippingCostDetails
                                                        ?.shippingOptions[i]
                                                        .options
                                                        ?.cost,
                                                    dProvider
                                                        .shippingCostDetails
                                                        ?.shippingOptions[i]
                                                        .name,
                                                    context);

                                                dProvider
                                                    .setSelectedShipIndex(i);
                                              },
                                              child: ShippingOption(
                                                  selectedShipping: dProvider
                                                      .selectedShippingIndex,
                                                  dProvider: dProvider,
                                                  i: i),
                                            ),
                                      ],
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        ln.getString(
                                            ConstString.noShippingAvailable),
                                        style: const TextStyle(
                                            color: warningColor),
                                      ),
                                    )
                              : Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: showLoading(primaryColor),
                                ),
                          gapH(10),
                          buttonPrimary(ConstString.save, () {
                            if (_formKey.currentState!.validate()) {
                              if (dProvider.vatLoading == true) {
                                return;
                              }

                              // var stateId = Provider.of<CountryStatesService>(
                              //         context,
                              //         listen: false)
                              //     .selectedStateId;
                              // if (stateId == '0') {
                              //   showToast(
                              //       ln.getString(ConstString.plzSelectState),
                              //       Colors.black);
                              //   return;
                              // }
                              dProvider.enteredDeliveryAddress = {
                                'name': fullNameController.text,
                                'email': emailController.text,
                                'phone': phoneController.text,
                                'city': cityController.text,
                                // 'zip': zipController.text,
                                'address': addressController.text
                              };
                              Navigator.pop(context);
                            }
                          },
                              isloading:
                                  dProvider.vatLoading == false ? false : true),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
