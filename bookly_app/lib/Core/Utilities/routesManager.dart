import 'package:flutter/material.dart';
import 'package:bookly_app/Features/Presentation/Views/HomeBegeScreen/homePageScreen.dart';
import 'package:bookly_app/Features/Presentation/Views/DetailsScreen/detailsScreen.dart';
import 'package:bookly_app/Features/Presentation/Views/SplashScreen/splashScreen.dart';
import 'package:bookly_app/Core/Utilities/StringManager.dart';

/*class Routes{
  static const String homePageScreen= "home";
  static const String detailPageScreen= "detail";
  static const String splashScreen= "splash";

}

class RoutesGenerator{

  static dynamic getRouteScreen(RouteSettings routeSettings){
     switch(routeSettings.name){
       case Routes.homePageScreen:
         return MaterialPageRoute(builder: (_)=> const HomePageScreen());
       case Routes.detailPageScreen:
         return MaterialPageRoute(builder: (_)=>  DetailsScreen());
       case Routes.splashScreen:
         return MaterialPageRoute(builder: (_)=>  SplashScreen());
       default:
         return getNoFoundPage();
     }
  }


 static dynamic getNoFoundPage(){
    return MaterialPageRoute(builder: (_)=> Scaffold(
      appBar: AppBar(title: const Text(StringsManager.noFoundPage),),
      body:const  Center(
        child: Text(StringsManager.noFoundPage),
      ),
    ),
    );

  }

}*/