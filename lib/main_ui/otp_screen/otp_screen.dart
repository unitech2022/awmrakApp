import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../bloc/auth_cubit/auth_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../user_ui/navigation_screen/navigation_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';

class OtpScreen extends StatelessWidget {
  final String code, phone;

  OtpScreen({Key? key, required this.code, required this.phone})
      : super(key: key);

  String newCode = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {




          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/logo_husain.jpg",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        color: Colors.yellow,
                        elevation: 2.5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //     width: double.infinity,
                            //     height: MediaQuery.of(context).size.height * .35,
                            //     child: ImageAndLogo(
                            //         rightMargen: 30,
                            //         fontSize: 45,
                            //         title2: 'الهاتف'.tr(),
                            //         title1: 'تأكيد رقم'.tr(),
                            //         image: "assets/images/back_login_e.png")),
                            const SizedBox(
                              height: 35,
                            ),
                            TextWidget(
                              width: double.infinity,
                              text:  "ادخل رمز التحقق المرسل على جوالك",
                              fontSize: 16,
                              fontFamliy: "pnuR",
                              color: Colors.black,
                            ),
                            TextWidget(
                              width: double.infinity,
                              text: code ,
                              fontSize: 16,
                              fontFamliy: "pnuR",
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            // todo :

                            SizedBox(
                              width: 200,
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: PinCodeTextField(
                                  appContext: context,
                                  pastedTextStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  length: 4,
                                  obscureText: false,
                                  obscuringCharacter: '*',
                                  textStyle: const TextStyle(color: Colors.black),
                                  blinkWhenObscuring: true,
                                  animationType: AnimationType.fade,
                                  validator: (v) {
                                    if (v.toString().length < 3) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(9),
                                    fieldHeight: 50,
                                    fieldWidth: 35,
                                    inactiveColor: const Color(0xFFE2E2E2),
                                    inactiveFillColor: const Color(0xFFE2E2E2),
                                    borderWidth: 1,
                                    selectedFillColor: const Color(0xFFE2E2E2),
                                    activeFillColor: Colors.white,
                                  ),
                                  cursorColor: Colors.black,
                                  animationDuration: const Duration(milliseconds: 300),
                                  backgroundColor: Colors.transparent,
                                  enableActiveFill: true,
                                  keyboardType: TextInputType.number,
                                  onCompleted: (v) {
                                    newCode = v;
                                    printFunction(newCode);
                                  },
                                  onChanged: (value) {
                                    printFunction(value);
                                  },
                                  beforeTextPaste: (text) {
                                    printFunction("Allowing to paste $text");
                                    return true;
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 25,
                            ),
                            state is LoginAuthStateLoad
                                ? const SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomButton(
                                height: 50,
                                fontFamily: "pnuM",
                                color: homeColor,
                                isCustomColor: true,
                                onPress: () {
                                  if(newCode == code){
                                    AuthCubit.get(context).loginUser(userName: phone, code: newCode,context: context);

                                  }else{
                                    HelperFunction.slt.notifyUser(context: context,
                                        color: Colors.grey,message: "الكود غير صحيح");
                                  }

                                },
                                text: "دخول",
                                textColor: homeColor,
                                redius: 5,
                                fontSize: 18,
                                isBorder: false,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }}