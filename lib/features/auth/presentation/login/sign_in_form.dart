import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/bottom_navigation_bar.dart';
import 'package:news/features/catagories_picker/application/catagories_picker_state.dart';
import 'package:news/features/catagories_picker/application/cubit/catagories_picker_cubit.dart';
import 'package:news/features/catagories_picker/presentation/catagoreies_picker_screen.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_state.dart';
import '../../../../core/theme/app_color.dart';
import '../../application/login_cubit/login_cubit.dart';
import '../../application/login_cubit/login_state.dart';
import '../sign_up/sign_up_form.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    context.read<CategoriesCubit>().fetchCategories();
    context.read<ProfileCubit>().fetchUserProfile();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginAuthenicated) {
          // Fetch the user profile state
          final profileState = context.read<ProfileCubit>().state;

          if (profileState is ProfileLoaded) {
            final userId = profileState.userModel.id;
            print(userId);

            // Fetch categories and check if any match the user ID
            final categoriesState = context.read<CategoriesCubit>().state;

            if (categoriesState is CategoriesLoaded) {
              final userCategoryMatch = categoriesState.categories
                  .any((category) => category.userId == userId);
              print(userCategoryMatch);
              if (userCategoryMatch) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const NewsBottomNavigationBar(),
                  ),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const CategoriesPickerScreen(),
                  ),
                );
              }
            } else {
              // Handle case where categories aren't loaded yet
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CategoriesPickerScreen(),
                ),
              );
            }
          } else {
            // Handle case where profile isn't loaded yet or an error occurred
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Failed to load user profile.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        } else if (state is LoginError) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.message),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .2,
              horizontal: MediaQuery.of(context).size.height * .02,
            ),
            child: Form(
              key: formKey,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Login in",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColor.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      EmailField(
                        emailcontroller: emailController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      PasswordField(
                        passwordcontroller: passwordController,
                        onFieldSubmitted: (_) {
                          signInHandler();
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed:
                                state is LoginLoading ? null : signInHandler,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: state is LoginLoading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green,
                                    ),
                                  )
                                : const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "I don't have an account? ",
                            style: TextStyle(
                              color: AppColor.calendarHeader,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpForm(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: AppColor.calendarHeader,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInHandler() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final hashpassword = sha256.convert(utf8.encode(password)).toString();

      context.read<LoginCubit>().signInWithEmailAndPassword(
            email: email,
            password: hashpassword,
          );
    }
  }
}
