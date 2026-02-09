import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _onboardingSeenKey = 'onboarding_seen';

  static Future<void> setOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, true);
  }

  static Future<bool> isOnboardingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingSeenKey) ?? false;
  }
}
