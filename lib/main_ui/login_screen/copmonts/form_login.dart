import 'package:awarake/bloc/auth_cubit/auth_cubit.dart';
import 'package:awarake/helpers/helper_function.dart';
import 'package:awarake/helpers/styles.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/functions.dart';
import '../../../user_ui/navigation_screen/navigation_screen.dart';
import '../../../widgets/Buttons.dart';
import '../../otp_screen/otp_screen.dart';
import '../../signup_screen/signup_screen.dart';

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

String userName = "";

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              buildTextFieldPhone(),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthCubit.get(context).isCheckedUserName
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
                      text: "دخول".tr(),
                      onPress: () {
                        if (userName.trim().length == 14 &&
                            userName.trim().startsWith("+20") &&
                            userName.isNotEmpty) {
                          AuthCubit.get(context)
                              .checkUserName(phone: userName, context: context);
                        } else {
                          HelperFunction.slt.notifyUser(
                              context: context,
                              message: "رقم الهاتف غير صحيح".tr(),
                              color: Colors.black45);
                        }
                      },
                      color: homeColor,
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  TextFormField buildTextFieldPhone() => TextFormField(
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
            RegExp("[٠-٩]"),
          ),
        ],
        maxLength: 11,
        onChanged: (value) {
          userName = "+20" + value.toString();
        },
        validator: (value) {
          return null;
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: "pnuB", fontSize: 15, color: Colors.black),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          hintText: "أدخل رقم الهاتف ".tr(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      );
}
