import 'package:bookly_app/Core/Utilities/colorsManager.dart';
import 'package:bookly_app/Features/Presentation/Views/ArchiveScreen/archiveSreen.dart';
import 'package:bookly_app/Features/Presentation/Views/WishLishScreen/wishLishScreen.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/Features/Presentation/Views/HomeBegeScreen/homePageScreen.dart';
import 'package:bookly_app/Features/Presentation/Views/SplashScreen/splashScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Features/Presentation/Controller/blocObserver.dart';
import 'Features/Presentation/Controller/bookController.dart';
void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=> BookController(),),
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
            textTheme:GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme) ,
            scaffoldBackgroundColor: ColorsManager.backGroundColor,
            appBarTheme: const AppBarTheme(
              color: ColorsManager.backGroundColor,
            ),

        ),
        routes: {
          'splash': (context) => const SplashScreen(),
          'home': (context) =>  const HomePageScreen(),
          'wishList': (context) => const WishListScreen(),
          'archive': (context) =>  const ArchiveScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: const HomePageScreen(),
      ),
    );
  }
}
