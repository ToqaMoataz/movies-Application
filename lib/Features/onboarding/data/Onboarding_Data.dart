import 'package:movie_app/Core/assets/app_images.dart';


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
      title: "Find Your Next \n Favorite Movie Here",
      imagePath: AppImages.moviesPosters,
      subTitle:
          "Get access to a huge library of movies \n to suit all tastes. You will surely like it.",
    ),
    OnBoardingData(
      title: "Discover Movies",
      imagePath: AppImages.onboardingImage2,
      subTitle:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    ),
    OnBoardingData(
      title: "Explore All Genres",
      imagePath: AppImages.onboardingImage3,
      subTitle:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    ),
    OnBoardingData(
      title: "Create Watchlists",
      imagePath: AppImages.onboardingImage4,
      subTitle:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    ),
    OnBoardingData(
      title: "Rate, Review, and Learn",
      imagePath: AppImages.onboardingImage5,
      subTitle:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    OnBoardingData(
      title: "Start Watching Now",
      imagePath: AppImages.onboardingImage6,
    ),
  ];
}
