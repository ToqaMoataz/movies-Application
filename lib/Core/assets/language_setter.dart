import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageChanger{

  static void changeLan(BuildContext context, {String? lang}) {
    if(lang!=null){
      if(lang=="language_ar"){
        context.setLocale(const Locale('ar'));
      }
      else{
        context.setLocale(const Locale('en'));
      }
    }
    else{
      if (context.locale.languageCode == 'ar') {
        context.setLocale(const Locale('en'));
      } else {
        context.setLocale(const Locale('ar'));
      }
    }
  }
}
