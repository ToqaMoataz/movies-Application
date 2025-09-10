import 'package:movie_app/Core/assets/app_images.dart';


class onBoardingData {
  String imagepath;
  String title;
  String? sub_title;
  onBoardingData({
    required this.title,
    required this.imagepath,
    this.sub_title,
  });
  static List<onBoardingData> onBoardingList = [
    onBoardingData(
      title: "Find Your Next \n Favorite Movie Here",
      imagepath: AppImages.Movies_posters,
      sub_title:
          "Get access to a huge library of movies \n to suit all tastes. You will surely like it.",
    ),
    onBoardingData(
      title: "Discover Movies",
      imagepath: AppImages.onboarding_image2,
      sub_title:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    ),
    onBoardingData(
      title: "Explore All Genres",
      imagepath: AppImages.onboarding_image3,
      sub_title:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    ),
    onBoardingData(
      title: "Create Watchlists",
      imagepath: AppImages.onboarding_image4,
      sub_title:
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    ),
    onBoardingData(
      title: "Rate, Review, and Learn",
      imagepath: AppImages.onboarding_image5,
      sub_title:
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    ),
    onBoardingData(
      title: "Start Watching Now",
      imagepath: AppImages.onboarding_image6,
    ),
  ];
}
