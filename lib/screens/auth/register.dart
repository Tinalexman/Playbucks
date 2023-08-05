import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playbucks/utils/constants.dart';
import 'package:playbucks/utils/functions.dart';
import 'package:playbucks/utils/widgets.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _SignupState();
}

class _SignupState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _lastNameControl = TextEditingController();

  final Map<String, String> _authDetails = {
    "email": "",
    "password": "",
    "fullName": "",
  };

  bool _showPassword = false;
  bool termsRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 63.h,
              ),
              Text(
                "Playbucks",
                style:
                    context.textTheme.headlineSmall!.copyWith(color: mainGold),
              ),
              Text("welcome", style: context.textTheme.bodyLarge),
              SizedBox(height: 32.h),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Full Name",
                            style: context.textTheme.labelSmall),
                      ),
                      SizedBox(height: 5.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: _nameController,
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            showError(
                                context, "Please fill in your full name.");
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["fullName"] = value!,
                        hint: "e.g John Doe Smith",
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text("Email", style: context.textTheme.labelSmall),
                      ),
                      SizedBox(height: 5.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        controller: _emailControl,
                        type: TextInputType.emailAddress,
                        onValidate: (value) {
                          if (value!.trim().isEmpty || !value.contains("@")) {
                            showError(context, "Invalid Email Address");
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["email"] = value!,
                        hint: "e.g johnsmith@mail.com",
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password",
                            style: context.textTheme.labelSmall),
                      ),
                      SizedBox(height: 5.h),
                      SpecialForm(
                        width: 390.w,
                        height: 40.h,
                        obscure: !_showPassword,
                        controller: _controller,
                        type: TextInputType.text,
                        suffix: GestureDetector(
                            child: Icon(
                                !_showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 18.r,
                                color: Colors.grey),
                            onTap: () {
                              setState(() => _showPassword = !_showPassword);
                            }),
                        onValidate: (value) {
                          if (value!.length < 6) {
                            showError(context,
                                "Password is too short. Use at least 6 characters");
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) => _authDetails["password"] = value!,
                        hint: "********",
                      ),
                      SizedBox(
                        height: 46.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGold,
                          minimumSize: Size(390.w, 40.h),
                        ),
                        onPressed: () =>
                            context.router.pushReplacementNamed(Pages.usertype),
                        child: Text(
                          "Register",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Wrap(
                        spacing: 5.w,
                        children: [
                          Text("Already have an account?",
                              style: context.textTheme.bodyMedium),
                          GestureDetector(
                            onTap: () => context.router
                                .pushReplacementNamed(Pages.login),
                            child: Text(
                              "Sign In",
                              style: context.textTheme.labelMedium?.copyWith(
                                  color: mainGold, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 130.w, height: 1.5.h, color: mainGold),
                          Text("OR", style: context.textTheme.headlineSmall),
                          Container(
                              width: 130.w, height: 1.5.h, color: mainGold),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          side: const BorderSide(color: theme),
                          minimumSize: Size(390.w, 40.h),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/google icon.png", width: 60.w, height: 30.h),
                            Text("Register with Google", style:
                            context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
