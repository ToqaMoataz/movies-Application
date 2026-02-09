import 'package:flutter/material.dart';
import 'package:movie_app/Core/Theme/app_colors.dart';
import 'package:movie_app/Features/onboarding/data/Onboarding_Data.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.onboardingData,
    this.onButtonPressed,
    this.onBackPressed,
    this.buttonText,
    this.pageIndex,
  });
  final OnBoardingData onboardingData;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onBackPressed;
  final String? buttonText;
  final int? pageIndex;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: Image.asset(onboardingData.imagePath, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,

            decoration: pageIndex == 0
                ? BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.getBackgroundColor().withOpacity(0.10),
                        AppColors.getBackgroundColor(),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  )
                : BoxDecoration(
                    color: AppColors.getBackgroundColor(),
                    borderRadius: BorderRadius.circular(16),
                  ),
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  onboardingData.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                if (onboardingData.subTitle != null)
                  Text(
                    textAlign: TextAlign.start,
                    onboardingData.subTitle!,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                SizedBox(height: screenHeight * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF6BD00),
                      minimumSize: Size(double.infinity, screenHeight * 0.07),
                    ),
                    child: Text(
                      buttonText ?? "Next",
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                onBackPressed != null
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onBackPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.getBackgroundColor(),
                            side: BorderSide(color: AppColors.getAccentColor()),
                          ),
                          child: Text(
                            "back",
                            style: TextStyle(
                              fontSize: screenHeight * 0.03,
                              color: AppColors.getAccentColor(),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
