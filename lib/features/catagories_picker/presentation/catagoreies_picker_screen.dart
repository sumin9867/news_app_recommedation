import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/bottom_navigation_bar.dart';
import 'package:news/core/theme/app_color.dart';
import 'package:news/core/theme/responsive_size.dart';
import 'package:news/features/catagories_picker/application/catagories_picker_state.dart';
import 'package:news/features/catagories_picker/application/cubit/catagories_picker_cubit.dart';
import 'package:news/features/catagories_picker/domain/catogories_pciker_model.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/profile/application/cubit/profile_cubit_state.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CategoriesPickerScreen extends StatefulWidget {
  const CategoriesPickerScreen({super.key});

  @override
  State<CategoriesPickerScreen> createState() => _CategoriesPickerScreenState();
}

class _CategoriesPickerScreenState extends State<CategoriesPickerScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().fetchUserProfile();
    super.initState();
  }

  final List<String> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    final categories = [
      'sports',
      'business',
      'entertainment',
      'science',
      'health',
      'world',
      'environment',
      'food',
    ];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ScreenUtils.getHeight(context, .09),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtils.getWidth(context, .01)),
            child: Text(
              "Select Your Preferred Categories",
              style: TextStyle(
                fontSize: ScreenUtils.getHeight(context, .04),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategories.contains(category);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedCategories.remove(category);
                        } else {
                          _selectedCategories.add(category);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black
                            : const Color.fromARGB(255, 217, 216, 216),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.count(
                  2,
                  index.isEven ? 1.5 : 1,
                ),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
          ),
          BlocListener<CategoriesCubit, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesSuccess) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const NewsBottomNavigationBar(),
                  ),
                );
              } else if (state is CategoriesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.only(
                      bottom: ScreenUtils.getHeight(context, .02)),
                  child: ElevatedButton(
                    onPressed: _selectedCategories.length >= 3
                        ? () {
                            final profileState =
                                context.read<ProfileCubit>().state;
                            String userId = "";
                            if (profileState is ProfileLoaded) {
                              userId = profileState.userModel.id;
                            }

                            context.read<CategoriesCubit>().saveCategories(
                                userCategories: UserCategoriesModel(
                                    userId: userId,
                                    categories: _selectedCategories));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColor.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtils.getWidth(context, .08),
                          vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Let's Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
