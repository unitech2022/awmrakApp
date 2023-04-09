import 'package:awarake/bloc/auth_cubit/auth_cubit.dart';
import 'package:awarake/helpers/helper_function.dart';
import 'package:awarake/main_ui/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../widgets/Buttons.dart';
import '../../widgets/custom_text_field.dart';
import '../otp_screen/otp_screen.dart';
import '../privacy_policy/privacy_policy_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String phone;

  SignUpScreen(this.phone);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();

  final _controllerPhone = TextEditingController();

  final _controllerEmail = TextEditingController();

  final _controllerFullName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhone.text = widget.phone;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerFullName.dispose();
    _controllerEmail.dispose();
    _controllerPhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ValidateAuthStateError) {
              Future.delayed(Duration.zero, () {
                HelperFunction.slt.notifyUser(
                    color: Colors.grey, message: state.error, context: context);
              });
            }

            if (state is RegisterAuthStateSuccess) {
              Future.delayed(Duration.zero, () {
                pushPage(
                    context: context,
                    page: LoginScreen());
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/logo_icon.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),

                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: const Color(0xffFEEE00),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                const Text(
                                  'حساب جديد',
                                  style: TextStyle(
                                    fontFamily: 'pnuB',
                                    fontSize: 32,
                                    color: Color(0xff200e32),
                                    height: 1.40625,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: KTextColor.withOpacity(.5)),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: CircleAvatar(
                                            radius: 20.0,
                                            child: Image.asset(
                                                "assets/images/flag.png"),
                                          )),
                                      Container(
                                        child: const Text(
                                          'مصر 20+',
                                          style: TextStyle(
                                            fontFamily: 'pnuM',
                                            fontSize: 16,
                                            color: Color(0xff878787),
                                            letterSpacing: 0.8,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomFormField(
                                  headingText: "Email",
                                  hintText: "الاسم بالكامل",
                                  obsecureText: false,
                                  suffixIcon: const SizedBox(),
                                  controller: _controllerFullName,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomFormField(
                                  headingText: "Password",
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.text,
                                  hintText: "البريد الالكترونى",
                                  obsecureText: false,
                                  suffixIcon: const SizedBox(),
                                  controller: _controllerEmail,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomFormField(
                                  headingText: "Password",
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.phone,
                                  hintText: "رقم التلفون",
                                  obsecureText: false,
                                  suffixIcon: const SizedBox(),
                                  controller: _controllerPhone,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: Checkbox(
                                        tristate: false,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: const BorderSide(
                                                color: Colors.white, width: 2)),
                                        checkColor: Colors.white,
                                        activeColor: homeColor,
                                        value: AuthCubit.get(context).isChecked,
                                        onChanged: (value) {
                                          AuthCubit.get(context).changeCheckBox(value!);
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        pushPage(
                                            context: context,
                                            page: PrivacyPolicyScreen()
                                        );
                                      },
                                      child: const Text(
                                        "أوافق علي الشروط والأحكام",
                                        style: TextStyle(
                                            color: Colors.black, fontFamily: "pnuL"),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                               /* Row(
                                  children: [
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () {
                                        AuthCubit.get(context)
                                            .currentStatusState(0);
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: AuthCubit.get(context)
                                                        .currentStatus ==
                                                    0
                                                ? Colors.green
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Center(
                                          child: Text(
                                            'مستخدم',
                                            style: TextStyle(
                                              fontFamily: 'pnuM',
                                              fontSize: 16,
                                              color: AuthCubit.get(context)
                                                          .currentStatus ==
                                                      0
                                                  ? Colors.white
                                                  : const Color(0xff878787),
                                              letterSpacing: 0.8,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: GestureDetector(
                                      onTap: () {
                                        AuthCubit.get(context)
                                            .currentStatusState(1);
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: AuthCubit.get(context)
                                                        .currentStatus ==
                                                    1
                                                ? Colors.green
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Center(
                                          child: Text(
                                            'مقدم خدمة',
                                            style: TextStyle(
                                              fontFamily: 'pnuM',
                                              fontSize: 16,
                                              color: AuthCubit.get(context)
                                                          .currentStatus ==
                                                      1
                                                  ? Colors.white
                                                  : Color(0xff878787),
                                              letterSpacing: 0.8,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),*/
                                AuthCubit.get(context).isRegisterLoad
                                    ? const SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : DefaultButton(
                                        colorText: const Color(0xffffffff),
                                        height: 50,
                                        text: "التالى ",
                                        onPress: () {
                                          if (isValidate(context)) {
                                            AuthCubit.get(context)
                                                .registerUser(
                                                email: _controllerEmail
                                                    .text
                                                    .trim(),
                                                userName: _controllerPhone
                                                    .text
                                                    .trim(),
                                                fullName:
                                                _controllerFullName
                                                    .text
                                                    .trim(),
                                                role: "user");
                                          }
                                          // Navigator.of(context).pushNamed(ValidateNumberScreen.id);
                                        },
                                        color: homeColor,
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  bool isValidate(BuildContext context) {
    if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل رقم الهاتف");
      return false;
    } else if (_controllerFullName.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل الاسم كاملا");
      return false;
    } else if (_controllerEmail.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل الايميل");
      return false;
    } else if (!AuthCubit.get(context).isChecked) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.grey, message: "يجب الموافقة علي سياسة الخصوصية");
      return false;
    }

    else {
      return true;
    }
  }
}
