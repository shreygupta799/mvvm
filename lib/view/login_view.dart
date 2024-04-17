import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm/res/componenets/round_button.dart';
import 'package:mvvm/utils/routes/routesName.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  ValueNotifier<bool> obsecurePass = ValueNotifier<bool>(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    obsecurePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
              controller: emailController,
              focusNode: emailFocus,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusNode(context, emailFocus, passwordFocus);
              }),
          ValueListenableBuilder(
            valueListenable: obsecurePass,
            builder: (context, value, child) {
              return TextFormField(
                controller: passwordController,
                focusNode: passwordFocus,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(obsecurePass.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      obsecurePass.value = !obsecurePass.value;
                    },
                  ),
                ),
                obscureText: obsecurePass.value,
                onFieldSubmitted: (value) {
                  passwordFocus.unfocus();
                },
              );
            },
          ),
          SizedBox(height: height * .1),
          RoundButton(
              title: 'click',
              loading: authViewModel.loading,
              onPress: () {
                if (emailController.text.isEmpty) {
                  Utils.flushbarErrorMessage('Enter Email', context);
                } else if (passwordController.text.isEmpty) {
                  Utils.flushbarErrorMessage('Enter Password', context);
                } else if (passwordController.text.length < 6) {
                  Utils.flushbarErrorMessage(
                      'Password must be 6 characters', context);
                } else {
                  Map data = {
                    'email': emailController.text.toString(),
                    'password': passwordController.text.toString()
                  };
                  authViewModel.loginApi(data, context);
                  //Navigator.pushNamed(context, RoutesName.home);
                }
              }),
        ],
      ),
    ));
  }
}
