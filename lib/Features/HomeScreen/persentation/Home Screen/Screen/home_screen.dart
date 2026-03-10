import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/Dependency%20Injection/di.dart';
import '../../../../../Core/Theme/app_colors.dart';

import '../../HomeScreen cubit/cubit.dart';
import '../../HomeScreen cubit/state.dart';
import '../Tabs/Browse Tab/browse_tab.dart';
import '../Tabs/Home Tab/home_tab.dart';
import '../Tabs/Profile Tab/profile_tab.dart';
import '../Tabs/Search Tab/search_tab.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName="homeScreen";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) =>
      getIt<HomeCubit>()..loadHomeTab(),

      child:BlocConsumer<HomeCubit,HomeStates>(
          builder: (context,state){
            return Scaffold(
              extendBody: true,
              body: returnTab(HomeCubit.get(context).state.currTabIndex),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.getDarkerPrimaryColor(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      currentIndex: HomeCubit.get(context).state.currTabIndex,

                      onTap: (value) {
                        HomeCubit.get(context).setTabIndex(value);
                      },
                      items: [
                        BottomNavigationBarItem(icon:  Icon(Icons.home_filled), label: "home_text".tr()),
                         BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: "search_text".tr()),
                         BottomNavigationBarItem(icon: Icon(Icons.explore), label: "explore_text".tr()),
                         BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile_text".tr()),
                      ],
                    ),
                  ),
                ),
              ),

            );

          },
          listener: (context,state){}
      ),
    );
  }
  Widget returnTab(int index){
    if(index==0){
      return HomeTab();
    }
    else if(index==1){
      return SearchTab();
    }
    else if(index==2){
      return BrowseTab();
    }
    return ProfileTab();
  }
}
