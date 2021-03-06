import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/state/AuthUser.dart';
import 'package:shop_app/state/userState.dart';
import '../../../size_config.dart';
import 'sign_form.dart';
import "../../sign_up/signUp.dart";

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthUserModel authUserModel = Provider.of<AuthUserModel>(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () async {
                        try {
                          Map<AuthUser, dynamic> user =
                              await signInWithGoogle();
                          authUserModel.setUser(user);
                          print(authUserModel.authUser);
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        } catch (e) {
                          error_showDialog(context);
                        }
                      }, //Todo Make Sign in with google account
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () async {
                        try {
                          await signInWithFacebook();
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        } catch (e) {
                          error_showDialog(context);
                        }
                      }, //Todo Make Sign in with facebook account
                    ),
                    SocalCard(
                      icon: "assets/icons/twitter.svg",
                      press: () async {
                        try {
                          await signInWithTwitter();
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        } catch (e) {
                          print(e);
                          error_showDialog(context);
                        }
                      }, //Todo Make Sign in with twitter account
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
