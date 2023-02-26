
import 'package:bookly_app/Core/Utilities/StringManager.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/Core/Utilities/valuesManager.dart';
import 'package:bookly_app/Core/Utilities/imagesManager.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                     InkWell(
                         onTap: (){
                           Navigator.pushNamed(context, "home");
                         },
                         child:Container(
                         width: AppSize.size250,
                          child: Image.asset(ImagesManager.logo),
    )
                     ),
                    Text(StringsManager.titlelogo,textAlign: TextAlign.center,)
                  ]

          ),

    );
  }
}

