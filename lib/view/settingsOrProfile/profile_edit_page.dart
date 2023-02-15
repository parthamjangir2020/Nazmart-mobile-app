import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:no_name_ecommerce/services/profile_edit_service.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/settingsOrProfile/components/profile_image_pick.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
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
    // countryCode = Provider.of<ProfileService>(context, listen: false)
    //     .profileDetails
    //     .userDetails
    //     .countryCode;
    // set country code
    // Future.delayed(const Duration(milliseconds: 600), () {
    //   Provider.of<ProfileEditService>(context, listen: false)
    //       .setCountryCode(countryCode);
    // });

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
      appBar: appbarCommon('Edit profile', context, () {
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
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenPadHorizontal, vertical: 10),
              // height: screenHeight - 200,
              // alignment: Alignment.center,
              child: Consumer<ProfileEditService>(
                builder: (context, provider, child) => Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ProfileImagePick(),

                            // change image icon
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: primaryColor),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 13),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg/camera-white.svg'),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    'Change Photo',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        gapH(25),
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
                          paddingHorizontal: 20,
                          textInputAction: TextInputAction.next,
                        ),

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
                          paddingHorizontal: 20,
                          textInputAction: TextInputAction.next,
                        ),

                        //Phone
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
                          paddingHorizontal: 20,
                          textInputAction: TextInputAction.next,
                          isNumberField: true,
                        ),

                        //City
                        labelCommon("City"),
                        CustomInput(
                          controller: cityController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          hintText: "Enter your city",
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
                        labelCommon("Zipcode"),
                        CustomInput(
                          controller: zipCodeController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your zip code';
                            }
                            return null;
                          },
                          hintText: "Enter your zip code",
                          paddingHorizontal: 20,
                          textInputAction: TextInputAction.next,
                        ),

                        // Address ======>
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
                          paddingHorizontal: 20,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        buttonPrimary('Save', () async {
                          if (provider.isloading == false) {
                            if (_formKey.currentState!.validate()) {
                              showTopSnackBar(
                                  context,
                                  const CustomSnackBar.success(
                                    message:
                                        "Updating profile...It may take few seconds",
                                  ),
                                  persistent: true,
                                  onAnimationControllerInit: (controller) =>
                                      localAnimationController = controller,
                                  onTap: () {
                                    // localAnimationController.reverse();
                                  });

                              //update profile
                              var result = await provider.updateProfile(context,
                                  name: fullNameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  zip: zipCodeController.text,
                                  address: addressController.text,
                                  city: cityController.text);
                              if (result == true || result == false) {
                                localAnimationController.reverse();
                              }
                            }
                          }
                        },
                            isloading:
                                provider.isloading == false ? false : true,
                            borderRadius: 100),

                        gapH(25)
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
