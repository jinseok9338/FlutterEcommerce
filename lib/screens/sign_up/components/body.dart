import 'package:flutter/material.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/size_config.dart';

import '../signUp.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account", style: headingStyle),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () async {
                        try {
                          await signInWithGoogle();
                          Navigator.pushNamed(
                              context, CompleteProfileScreen.routeName);
                        } catch (e) {
                          error_showDialog(context);
                        }
                      },
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () async {
                        try {
                          await signInWithFacebook();
                          Navigator.pushNamed(
                              context, CompleteProfileScreen.routeName);
                        } catch (e) {
                          error_showDialog(context);
                        }
                      },
                    ),
                    SocalCard(
                      icon: "assets/icons/twitter.svg",
                      press: () async {
                        try {
                          await signInWithTwitter();
                          Navigator.pushNamed(
                              context, CompleteProfileScreen.routeName);
                        } catch (e) {
                          error_showDialog(context);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
