import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/Core/Models/user_model.dart';
import 'package:movie_app/Core/Theme/app_theaming.dart';
import 'package:movie_app/Features/moviesDetails/persentation/movie_details_screen.dart';
import 'Core/Hive/hive_manager.dart';
import 'Features/Authentication/persentation/Forget Password Screen/forget_password_screen.dart';
import 'Features/Authentication/persentation/Login Screen/login_screen.dart';
import 'Features/Authentication/persentation/Regiser Screen/register_screen.dart';
import 'Features/HomeScreen/domain/user repository/user_repo.dart';
import 'Features/HomeScreen/persentation/Home Screen/home_Screen.dart';
import 'Features/Update and Delete profile/domail/update_profile_repo.dart';
import 'Features/Update and Delete profile/persentation/Update Profile Screen/update_profile_screen.dart';
import 'Features/Update and Delete profile/persentation/update and delete cubit/cubit.dart';
import 'Features/onboarding/domain/helper/preferences_helper.dart';
import 'Features/onboarding/persentation/Introduction Screen/introduction_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  await HiveManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool initialOnboardingSeen = await PreferencesHelper.isOnboardingSeen();
  User? user = FirebaseAuth.instance.currentUser;

  String initialRoute;
  if (!initialOnboardingSeen) {
    initialRoute = IntroductionScreen.routeName;
  } else if (user!=null) {
    initialRoute = HomeScreen.routeName;
  } else {
    initialRoute = LoginScreen.routeName;
  }

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheming.theme,
          routes: {
            IntroductionScreen.routeName: (context) => IntroductionScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
            MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
            UpdateProfileScreen.routeName: (context) {
              return BlocProvider(
                create: (_) => UpdateProfileCubit(UpdateProfileRepoImp(), UserRepoImp()),
                child: UpdateProfileScreen(),
              );
            },

          },
          initialRoute: initialRoute,
        );
      },
    );
  }
}
