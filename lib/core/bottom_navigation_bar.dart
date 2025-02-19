import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/features/technology_news/presentation/politics_news_list.dart';
import 'package:news/features/hoempage/home_news_screen.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/presentation/profile_screen.dart';

import '../features/profile/application/cubit/profile_cubit_state.dart';

class NewsBottomNavigationBar extends StatefulWidget {
  const NewsBottomNavigationBar({super.key});

  @override
  State<NewsBottomNavigationBar> createState() =>
      _NewsBottomNavigationBarState();
}

class _NewsBottomNavigationBarState extends State<NewsBottomNavigationBar> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onNavBarTap(int index) {
    setState(() {
      currentPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.container,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: const <Widget>[
          NewsHomeScreen(),
          NewsCategories(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
<<<<<<< HEAD
        
=======
        decoration: BoxDecoration(
          color: AppColor.selectedDropDown,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: currentPageIndex,
            onTap: onNavBarTap,
            selectedItemColor: AppColor.primary,
<<<<<<< HEAD
            // unselectedItemColor: Colors.grey,
            // backgroundColor: Colors.transparent,
=======
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.transparent,
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_rounded, size: 24),
                label: '',
                tooltip: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.coffee, size: 24),
                label: '',
                tooltip: '',
              ),
<<<<<<< HEAD
        
=======
              const BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_add_rounded, size: 24),
                label: 'Incident',
                tooltip: '',
              ),
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 16,
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        context.read<ProfileCubit>().fetchUserProfile();
                        return const CircularProgressIndicator();
                      } else if (state is ProfileLoaded) {
                        return CircleAvatar(
                          backgroundImage: state.userModel.profileImageUrl !=
                                      null &&
                                  state.userModel.profileImageUrl!.isNotEmpty
                              ? NetworkImage(state.userModel.profileImageUrl!)
                              : null,
                          child: state.userModel.profileImageUrl == null ||
                                  state.userModel.profileImageUrl!.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 20,
                                )
                              : null,
                        );
                      } else {
                        return const Icon(Icons.person, size: 20);
                      }
                    },
                  ),
                ),
                label: 'Profile',
                tooltip: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
