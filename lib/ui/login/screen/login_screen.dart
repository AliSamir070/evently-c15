import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15/core/DialogUtils.dart';
import 'package:evently_c15/core/resources/AssetsManager.dart';
import 'package:evently_c15/core/resources/StringsManager.dart';
import 'package:evently_c15/core/resources/constants.dart';
import 'package:evently_c15/core/reusable_components/CustomButton.dart';
import 'package:evently_c15/core/reusable_components/CustomField.dart';
import 'package:evently_c15/ui/forget_password/screen/forget_password_screen.dart';
import 'package:evently_c15/ui/home/screen/home_screen.dart';
import 'package:evently_c15/ui/register/screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../ThemeProvider.dart';
import '../../../core/reusable_components/CustomSwitch.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedLanguage = 0;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    if(context.locale.languageCode=="ar"){
      selectedLanguage = 1;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManager.logo),
                  SizedBox(height: 24,),
                  CustomField(
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    hint: StringsManager.email.tr(),
                    prefix: AssetsManager.email,
                    validation: (value){
                      if(value == null || value.isEmpty){
                        return "shouldEmpty".tr();
                      }
                      if(!RegExp(emailRegex).hasMatch(value)){
                        return "Email not valid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomField(
                    keyboard: TextInputType.visiblePassword,
                    controller: passwordController,
                    hint: StringsManager.password.tr(),
                    prefix: AssetsManager.lock,
                    isPassword: true,
                    validation: (value) {
                      if(value == null || value.isEmpty){
                        return "shouldEmpty".tr();
                      }
                      if(value.length<8){
                        return "password mustn't be less than 8 char";
                      }
              
                    },
                  ),
                  SizedBox(height: 16,),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                        },
                        child: Text("forgetPass".tr(),
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 16,
                              decorationColor: Theme.of(context).colorScheme.primary,
                              decorationThickness: 2,
              
                              decoration: TextDecoration.underline
                            ),)),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    width: double.infinity,
                    child: CustomButton(title: "login".tr(), onClick: (){
                    }),
                  ),
                  SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("dontHaveAccount".tr(),style: Theme.of(context).textTheme.bodySmall,),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, RegisterScreen.routeName);
                          },
                          child: Text("createAcc".tr(),
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontSize: 16,
                                decorationColor: Theme.of(context).colorScheme.primary,
                                decorationThickness: 2,
              
                                decoration: TextDecoration.underline
                            ),)),
                    ],
                  ),
                  SizedBox(height: 24,),
                  CustomSwitch(
                      onChange: (value){
                        setState(() {
                          selectedLanguage = value;
                        });
                        if(selectedLanguage==1){
                          context.setLocale(Locale("ar"));
                        }else{
                          context.setLocale(Locale("en"));
              
                        }
                      },
                      icons:[
                        SvgPicture.asset(AssetsManager.us,
                          height: 30,
                          width: 30,
                        ),
                        SvgPicture.asset(AssetsManager.eg, height: 30,
                          width: 30,),
                      ] ,
                      current: selectedLanguage)
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
