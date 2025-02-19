import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/admin/application/news_cubit.dart';
import 'package:news/admin/infeasturutucre/admin_add_news_repo.dart';
import 'package:news/core/bottom_navigation_bar.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
import 'package:news/features/auth/presentation/login/sign_in_form.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/features/search/application/search_news_cubit.dart';
import 'package:news/features/search/infrastructure/search_news_repositary.dart';
import 'package:news/features/search/presentation/politics_news_list.dart';
import 'package:news/features/technology_news/application/politics_news_cubit.dart';
import 'package:news/features/technology_news/infrastructure/politics_news_repositary.dart';
import 'package:news/features/catagories_picker/application/cubit/catagories_picker_cubit.dart';
import 'package:news/features/latest_news/application/latest_news_cubit.dart';
import 'package:news/features/latest_news/infrastructure/latest_news_repositary.dart';

import 'package:news/features/profile/application/cubit/profile_cubit_cubit.dart';
import 'package:news/features/sports_news/application/sport_news_cubit.dart';
import 'package:news/features/sports_news/infrastructure/sport_news_repositary.dart';

import 'features/auth/application/login_cubit/login_cubit.dart';
import 'features/auth/application/sign_up/auth_cubit.dart';
import 'features/auth/infrastructure/auth_repositary.dart';
import 'features/profile/infrastructure/profile_repositary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
<<<<<<< HEAD
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d

  final AuthRepository authRepository = AuthRepository();
  final ProfileRepo profileRepo = ProfileRepo();
  LatestNewsRepositary().fetchLatestNews();
  final LatestNewsRepositary latestNewsRepositary = LatestNewsRepositary();
  final SportNewsRepositary sportNewsRepositary = SportNewsRepositary();
  final PoliticsNewsRepositary politicsNewsRepositary =
      PoliticsNewsRepositary();
  final SearchNewsRepositary searchNewsRepositary = SearchNewsRepositary();
<<<<<<< HEAD
  final NewsRepository newsRepository = NewsRepository(firebaseFirestore,firebaseStorage);

=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(authRepository),
      ),
      BlocProvider(
        create: (context) =>
            LoginCubit(authRepository, firebaseAuth, firebaseFirestore),
      ),
      BlocProvider(
        create: (context) => ProfileCubit(profileRepo)..fetchUserProfile(),
      ),
      BlocProvider(
        create: (context) =>
            LatestNewsCubit(latestNewsRepositary)..fetchLatestNews(),
      ),
      BlocProvider(
        create: (context) =>
            SportsNewsCubit(sportNewsRepositary)..fetchSportNews(""),
      ),
      BlocProvider(
          create: (context) =>
              SearchsNewsCubit(searchNewsRepositary)..fetchSearchNews("")),
      BlocProvider(
          create: (context) => PoliticsNewsCubit(politicsNewsRepositary)),
      BlocProvider(create: (context) => CategoriesCubit()..fetchCategories()),
<<<<<<< HEAD
            BlocProvider(create: (context) => NewsCubit(newsRepository)),
=======
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme(context),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: const SignInForm(),
=======
      home: const FilterNewsScreen(),
>>>>>>> 47f703e8b9d4b63d744e69fef8c73d0b80ff435d
    );
  }
}
