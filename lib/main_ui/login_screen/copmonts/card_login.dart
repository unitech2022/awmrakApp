import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'form_login.dart';


class CardLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: const Color(0xffFEEE00),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2.5,

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                'تسجيل الدخول'.tr(),
                style: const TextStyle(
                  fontFamily: 'pnuB',
                  fontSize: 32,
                  color: Colors.black,
                  height: 1.40625,
                ),
                textHeightBehavior:
                const TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
              FormLogin(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}