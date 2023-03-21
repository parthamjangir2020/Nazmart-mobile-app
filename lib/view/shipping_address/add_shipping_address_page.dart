import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/profile_edit_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/services/shipping_services/add_remove_shipping_address_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:provider/provider.dart';

class AddShippingAddressPage extends StatefulWidget {
  const AddShippingAddressPage({Key? key}) : super(key: key);

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  // String? countryCode;

  late AnimationController localAnimationController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

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
    // zipCodeController.text = Provider.of<ProfileService>(context, listen: false)
    //         .profileDetails
    //         ?.userDetails
    //         .po ??
    //     '';
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
      appBar: appbarCommon('', context, () {
        Provider.of<ProfileEditService>(context, listen: false).setDefault();
        Navigator.pop(context);
      }, centerTitle: false),
      body: WillPopScope(
        onWillPop: () {
          Provider.of<ProfileEditService>(context, listen: false).setDefault();
          return Future.value(true);
        },
        child: Listener(
          onPointerDown: (_) {
            hideKeyboard(context);
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenPadHorizontal, vertical: 10),
              child: Consumer<TranslateStringService>(
                builder: (context, ln, child) =>
                    Consumer<AddRemoveShippingAddressService>(
                  builder: (context, provider, child) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                            paddingHorizontal: 20,
                            textInputAction: TextInputAction.next,
                          ),

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
                            paddingHorizontal: 20,
                            textInputAction: TextInputAction.next,
                          ),

                          //Phone
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
                            paddingHorizontal: 20,
                            textInputAction: TextInputAction.next,
                            isNumberField: true,
                          ),

                          //City
                          labelCommon(ConstString.city),
                          CustomInput(
                            controller: cityController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln
                                    .getString(ConstString.plzEnterYourCity);
                              }
                              return null;
                            },
                            hintText: ln.getString(ConstString.enterYourCity),
                            paddingHorizontal: 20,
                            textInputAction: TextInputAction.next,
                          ),

                          // IntlPhoneField(
                          //   controller: phoneController,
                          //   decoration: SignupHelper().phoneFieldDecoration(),
                          //   initialCountryCode: countryCode,
                          //   onChanged: (phone) {
                          //     provider.setCountryCode(phone.countryISOCode);
                          //   },
                          // ),

                          //Country dropdown =====>

                          const CountryStatesDropdowns(),

                          // Zip ======>
                          gapH(18),
                          labelCommon(ConstString.zipCode),
                          CustomInput(
                            controller: zipCodeController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return ln.getString(ConstString.plzEnterZip);
                              }
                              return null;
                            },
                            hintText: ln.getString(ConstString.enterZip),
                            paddingHorizontal: 20,
                            textInputAction: TextInputAction.next,
                          ),

                          // Address ======>
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
                            paddingHorizontal: 20,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          buttonPrimary(ConstString.save, () async {
                            if (provider.isloading == false) {
                              if (_formKey.currentState!.validate()) {
                                await provider.addAddress(context,
                                    name: fullNameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    zip: zipCodeController.text,
                                    address: addressController.text,
                                    city: cityController.text);
                              }
                            }
                          }, isloading: provider.isloading, borderRadius: 100),

                          gapH(25)
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
