import 'package:flutter/material.dart';
import 'package:movie_app/Features/onboarding/data/Onboarding_Data.dart';
import '../../../Authentication/persentation/Login Screen/login_screen.dart';
import '../../domain/helper/preferences_helper.dart';
import 'Onboarding_Page.dart';

class IntroductionScreen extends StatefulWidget {
  static const String routeName = "introductionScreen";
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  void goToNextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
    );
  }

  void onButtonPressed() async {
    if (currentIndex < onBoardingData.onBoardingList.length - 1) {
      goToNextPage();
    } else {
      await PreferencesHelper.setOnboardingSeen();
      Navigator.of(
        context,
        rootNavigator: true,
      ).pushReplacementNamed(LoginScreen.routeName);
      // TO Do آخر صفحة → Finish
      // print("Finish pressed!");
    }
  }

  void goToPreviousPage() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      currentIndex = pageController.page?.toInt() ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onBoardingData.onBoardingList.length,
              itemBuilder: (context, index) => OnboardingPage(
                onboardingData: onBoardingData.onBoardingList[index],
                pageIndex: index,
                onButtonPressed: onButtonPressed,
                buttonText: index == 0
                    ? "Explore Now"
                    : index == onBoardingData.onBoardingList.length - 1
                    ? "Finish"
                    : "Next",
                onBackPressed: (currentIndex == 1 || currentIndex == 0)
                    ? null
                    : goToPreviousPage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
