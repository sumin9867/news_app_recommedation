import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:news/admin/presentation/admin_add_news.dart';
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
import 'package:news/core/bottom_navigation_bar.dart';
import 'package:news/features/catagories_picker/application/catagories_picker_state.dart';
import 'package:news/features/catagories_picker/application/cubit/catagories_picker_cubit.dart';
import 'package:news/features/catagories_picker/presentation/catagoreies_picker_screen.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_state.dart';
<<<<<<< HEAD
import 'package:news/features/auth/application/login_cubit/login_cubit.dart';
import 'package:news/features/auth/application/login_cubit/login_state.dart';


import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../sign_up/sign_up_form.dart';
=======
import '../../../../core/theme/app_color.dart';
import '../../application/login_cubit/login_cubit.dart';
import '../../application/login_cubit/login_state.dart';
import '../sign_up/sign_up_form.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d

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
<<<<<<< HEAD
          final userModel = state.userModel;

          // Check if the user is an admin
          if (userModel.admin == true) {
            // Navigate to the admin screen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AdminPanelScreen(), // Replace with your actual admin screen
              ),
            );
          } else {
            // Navigate to the normal user screen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NewsBottomNavigationBar(),
              ),
            );
          }
        } else if (state is LoginAdmin) {
          // Handle the admin login state (this state is already emitted in the cubit for admin users)
          final userModel = state.userModel;
          
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdminPanelScreen(), // Admin dashboard screen
            ),
          );
        } else if (state is LoginError) {
          // Handle any login errors
=======
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
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
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
<<<<<<< HEAD
        } else if (state is LoginUnAuthenicated) {
          // Handle the case where the user is unauthenticated (e.g., show login screen again)
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignInForm(), // Go back to the login screen
            ),
          );
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
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
<<<<<<< HEAD
                          color: Colors.blue, // Adjust your color here
=======
                          color: AppColor.primary,
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
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
<<<<<<< HEAD
                            onPressed: state is LoginLoading ? null : signInHandler,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Adjust your color here
=======
                            onPressed:
                                state is LoginLoading ? null : signInHandler,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: state is LoginLoading
                                ? const CircularProgressIndicator(
<<<<<<< HEAD
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
=======
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green,
                                    ),
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
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
<<<<<<< HEAD
                              color: Colors.blueGrey, // Adjust your color here
=======
                              color: AppColor.calendarHeader,
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
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
<<<<<<< HEAD
                                color: Colors.blueGrey, // Adjust your color here
=======
                                color: AppColor.calendarHeader,
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
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
