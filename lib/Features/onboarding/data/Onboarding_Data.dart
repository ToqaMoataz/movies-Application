import 'package:easy_localization/easy_localization.dart';
import 'package:movie_app/Core/assets/App%20Images/app_images.dart';


class OnBoardingData {
  String imagePath;
  String title;
  String? subTitle;
  OnBoardingData({
    required this.title,
    required this.imagePath,
    this.subTitle,
  });
  static List<OnBoardingData> onBoardingList = [
    OnBoardingData(
      title: "onboarding_title_1".tr(),
      imagePath: AppImages.moviesPosters,
      subTitle:
      "onboarding_subtitle_1".tr(),
    ),
    OnBoardingData(
      title: "onboarding_title_2".tr(),
      imagePath: AppImages.onboardingImage2,
      subTitle:"onboarding_subtitle_2".tr(),
    ),
    OnBoardingData(
      title: "onboarding_title_3".tr(),
      imagePath: AppImages.onboardingImage3,
      subTitle:"onboarding_subtitle_3".tr(),
    ),
    OnBoardingData(
      title: "onboarding_title_4".tr(),
      imagePath: AppImages.onboardingImage4,
      subTitle:"onboarding_subtitle_4".tr(),
    ),
    OnBoardingData(
      title: "onboarding_title_5".tr(),
      imagePath: AppImages.onboardingImage5,
      subTitle: "onboarding_subtitle_5".tr(),
    ),
    OnBoardingData(
      title: "onboarding_title_6".tr(),
      imagePath: AppImages.onboardingImage6,
    ),
  ];
}
