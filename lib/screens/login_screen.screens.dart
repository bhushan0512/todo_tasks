import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:todo/providers/auth_provider.dart';
import 'package:todo/constants/MyAppColors.dart';
import 'package:todo/constants/MyAppStyles.dart';
import 'package:todo/widgets/my_button.dart';
import 'package:todo/widgets/my_textformfield.dart';

//I'm just going to make a single screen for both login and signup to save time. (I'm lazy)

enum Status {
  login,
  signUp,
}

Status type = Status.login;

class LoginPage extends StatefulWidget {
  static const routename = '/LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;

  void loading() {
    if (mounted) {
      // Check if the widget is still in the widget tree
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  void _switchType() {
    if (type == Status.signUp) {
      setState(() {
        type = Status.login;
      });
    } else {
      setState(() {
        type = Status.signUp;
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: UIColor.Grey,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Consumer(builder: (context, ref, _) {
            final auth = ref.watch(authenticationProvider);

            Future<void> _onPressedFunction() async {
              if (!_formKey.currentState!.validate()) {
                return;
              }

              loading(); // Start loading

              try {
                if (type == Status.login) {
                  await auth.signInWithEmailAndPassword(
                      _email.text, _password.text, context);
                } else {
                  await auth.signUpWithEmailAndPassword(
                      _email.text, _password.text, context);
                }
              } catch (e) {
                // Handle error
                print('Error: $e');
              } finally {
                if (mounted) {
                  // Check if the widget is still in the widget tree
                  loading(); // Stop loading
                }
              }
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 120.h),
                    SizedBox(
                        height: 150.h,
                        child: SvgPicture.asset(
                          "assets/logo.svg",
                        )),
                    SizedBox(height: 30.h),
                    MyTextField(
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        onTap: () => _email.clear(),
                        child: Icon(
                          PhosphorIcons.xCircle(PhosphorIconsStyle.fill),
                          color: UIColor.DarkGrey,
                          size: 25.h,
                        ),
                      ),
                      inputAction: TextInputAction.next,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    SizedBox(height: 8.h),
                    MyTextField(
                      inputAction: type == Status.signUp
                          ? TextInputAction.next
                          : TextInputAction.done,
                      controller: _password,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password is too short!';
                        }
                        return null;
                      },
                      hintText: 'Password',
                    ),
                    if (type == Status.signUp)
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: MyTextField(
                          obscureText: true,
                          validator: (value) {
                            if (value != _password.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          },
                          controller: null,
                          hintText: 'Confirm password',
                        ),
                      ),
                    _isLoading
                        ? Container(
                            margin: EdgeInsets.only(top: 8.h),
                            child: MyButton(
                                onTap: () {},
                                child: SpinKitWave(
                                  size: 30,
                                  color: Colors.black,
                                )))
                        : Container(
                            margin: EdgeInsets.only(top: 8.h),
                            child: MyButton(
                              onTap: _onPressedFunction,
                              child: Text(
                                type == Status.login ? 'Log in' : 'Sign up',
                                style:
                                    MyAppStyles().buttonText(fontSize: 18.sp),
                              ),
                            ),
                          ),
                    SizedBox(height: 30.h),
                    RichText(
                      text: TextSpan(
                        text: type == Status.login
                            ? 'Don\'t have an account? '
                            : 'Already have an account? ',
                        style: MyAppStyles().blackRegularInter(fontSize: 14.sp),
                        children: [
                          TextSpan(
                              text: type == Status.login
                                  ? 'Sign up now'
                                  : 'Log in',
                              style: MyAppStyles()
                                  .greenRegularInter(fontSize: 14.sp),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _switchType();
                                })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
