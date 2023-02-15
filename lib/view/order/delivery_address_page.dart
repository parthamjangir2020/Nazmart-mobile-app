import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/country_states_service.dart';
import 'package:no_name_ecommerce/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/order/components/free_ship_option.dart';
import 'package:no_name_ecommerce/view/order/components/shipping_option.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
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
    // fullNameController.text =
    //     Provider.of<ProfileService>(context, listen: false)
    //             .profileDetails
    //             .userDetails
    //             .name ??
    //         '';

    // emailController.text = Provider.of<ProfileService>(context, listen: false)
    //         .profileDetails
    //         .userDetails
    //         .email ??
    //     '';

    // phoneController.text = Provider.of<ProfileService>(context, listen: false)
    //         .profileDetails
    //         .userDetails
    //         .phone ??
    //     '';
    // zipController.text = Provider.of<ProfileService>(context, listen: false)
    //         .profileDetails
    //         .userDetails
    //         .zipcode ??
    //     '';
    // addressController.text = Provider.of<ProfileService>(context, listen: false)
    //         .profileDetails
    //         .userDetails
    //         .address ??
    //     '';
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
          child: Consumer<DeliveryAddressService>(
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
                        labelCommon("Full name"),

                        CustomInput(
                          controller: fullNameController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          hintText: "Enter your full name",
                          // icon: 'assets/icons/user.png',
                          paddingHorizontal: 17,
                          textInputAction: TextInputAction.next,
                        ),
                        gapH(5),

                        //Email ============>
                        labelCommon("Email"),

                        CustomInput(
                          controller: emailController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          hintText: "Enter your email",
                          // icon: 'assets/icons/email-grey.png',
                          paddingHorizontal: 17,
                          textInputAction: TextInputAction.next,
                        ),
                        gapH(5),

                        //Phone ============>
                        labelCommon("Phone"),

                        CustomInput(
                          controller: phoneController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          hintText: "Enter your phone",
                          isNumberField: true,
                          // icon: 'assets/icons/email-grey.png',
                          paddingHorizontal: 17,
                          textInputAction: TextInputAction.next,
                        ),

                        gapH(10),

                        //City /town ============>
                        labelCommon("City/Town"),

                        CustomInput(
                          controller: cityController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your city or town';
                            }
                            return null;
                          },
                          hintText: "Enter your city/town",
                          // icon: 'assets/icons/email-grey.png',
                          paddingHorizontal: 17,
                          textInputAction: TextInputAction.next,
                        ),

                        gapH(5),

                        //Zip code ============>
                        labelCommon("Zip code"),

                        CustomInput(
                          controller: zipController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your zip code';
                            }
                            return null;
                          },
                          hintText: "Enter your zip code",
                          // icon: 'assets/icons/email-grey.png',
                          paddingHorizontal: 17,
                          textInputAction: TextInputAction.next,
                        ),

                        gapH(5),

                        //Zip code ============>
                        labelCommon("Address"),

                        CustomInput(
                          controller: addressController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          hintText: "Enter your address",
                          // icon: 'assets/icons/email-grey.png',
                          paddingHorizontal: 17,
                          textInputAction: TextInputAction.next,
                        ),

                        gapH(5),
                        // Shipping options

                        dProvider.shippingCostDetails != null
                            ? dProvider.shippingCostDetails != 'error'
                                ? Column(
                                    children: [
                                      //default shipping
                                      InkWell(
                                        onTap: () {
                                          var minOrder = dProvider
                                              .shippingCostDetails
                                              .defaultShipping
                                              .options
                                              .minimumOrderAmount;
                                          var couponNeeded =
                                              dProvider.checkIfCouponNeed(
                                                  dProvider
                                                      .shippingCostDetails
                                                      .defaultShipping
                                                      .options
                                                      .coupon,
                                                  context);
                                          if (cProvider.subTotal < minOrder) {
                                            showToast(
                                                'Minimum \$$minOrder order is needed',
                                                Colors.black);
                                            return;
                                          } else if (couponNeeded) {
                                            return;
                                          }

                                          dProvider.setShipIdAndCosts(
                                              dProvider
                                                  .shippingCostDetails
                                                  .defaultShipping
                                                  .options
                                                  .shippingMethodId,
                                              dProvider.shippingCostDetails
                                                  .defaultShipping.options.cost,
                                              dProvider.shippingCostDetails
                                                  .defaultShipping.name,
                                              context);

                                          setState(() {
                                            dProvider.setSelectedShipIndex(-1);
                                          });
                                        },
                                        child: FreeShipOption(
                                          selectedShipping:
                                              dProvider.selectedShippingIndex,
                                          dProvider: dProvider,
                                        ),
                                      ),

                                      //Other shipping option ======>
                                      for (int i = 0;
                                          i <
                                              dProvider.shippingCostDetails
                                                  .shippingOptions.length;
                                          i++)
                                        InkWell(
                                          onTap: () {
                                            var minOrder = dProvider
                                                .shippingCostDetails
                                                .shippingOptions[i]
                                                .options
                                                .minimumOrderAmount;
                                            var couponNeeded =
                                                dProvider.checkIfCouponNeed(
                                                    dProvider
                                                        .shippingCostDetails
                                                        .shippingOptions[i]
                                                        .options
                                                        .coupon,
                                                    context);
                                            if (cProvider.subTotal < minOrder) {
                                              showToast(
                                                  'Minimum \$$minOrder order is needed',
                                                  Colors.black);
                                              return;
                                            } else if (couponNeeded) {
                                              showToast('Coupon is needed',
                                                  Colors.black);

                                              return;
                                            }
                                            dProvider.setShipIdAndCosts(
                                                dProvider
                                                    .shippingCostDetails
                                                    .shippingOptions[i]
                                                    .options
                                                    .shippingMethodId,
                                                dProvider
                                                    .shippingCostDetails
                                                    .shippingOptions[i]
                                                    .options
                                                    .cost,
                                                dProvider.shippingCostDetails
                                                    .shippingOptions[i].name,
                                                context);

                                            dProvider.setSelectedShipIndex(i);
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
                                    child: const Text(
                                      'No shipping option available',
                                      style: TextStyle(color: warningColor),
                                    ),
                                  )
                            : Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: showLoading(primaryColor),
                              ),
                        gapH(10),
                        buttonPrimary("Save", () {
                          if (_formKey.currentState!.validate()) {
                            if (dProvider.vatLoading == true) {
                              return;
                            }

                            var stateId = Provider.of<CountryStatesService>(
                                    context,
                                    listen: false)
                                .selectedStateId;
                            if (stateId == '0') {
                              showToast('Please select a state', Colors.black);
                              return;
                            }
                            dProvider.enteredDeliveryAddress = {
                              'name': fullNameController.text,
                              'email': emailController.text,
                              'phone': phoneController.text,
                              'city': cityController.text,
                              'zip': zipController.text,
                              'address': addressController.text
                            };

                            dProvider.fetchShippingCostAndVat(context);
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
    );
  }
}
