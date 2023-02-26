
import 'package:bookly_app/Core/Utilities/valuesManager.dart';
import 'package:bookly_app/Features/Presentation/Views/ArchiveScreen/archiveSreen.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/Core/Utilities/colorsManager.dart';
import 'package:bookly_app/Core/Utilities/fontsManager.dart';
import 'package:bookly_app/Core/Utilities/iconsManager.dart';
import 'package:bookly_app/Features/Presentation/Widgets/combonent.dart';
class MoreSettingsForUser extends StatelessWidget {
  final IconData icon1;
  final String title;
  final String title2;
  final bool isIconNavigate;
  final String screen;

   MoreSettingsForUser({
     required this.icon1,
     required this.title,
     required this.title2,
     required this.isIconNavigate ,
     required this.screen,
     Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon1,),
              Text(title),
            ],
          ),
          Row(
              children: [
                Text(title2,style: FontsManager.getTextStyleLight(color: ColorsManager.pinkColor,size: AppSize.size15),),
               isIconNavigate == true? sharedIcon(
                  icon:IconsManager.iconRight,
                  onPressed: (){
                    Navigator.pushNamed(context, screen);
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=> screen));
                  },
                 color: ColorsManager.whiteColor
                )
                   :Switch(
                 onChanged: (x){},
                 value: false,
                 autofocus: true,
                 activeColor: ColorsManager.pinkColor,
                 focusColor: ColorsManager.greyColor,
                 splashRadius: 20,
               ),
              ]
          ),
        ],
      ),
    );
  }
    /* return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListTile(
          leading:  Icon(icon1,),
          title: Row(
            children: [
              Text(title,style: FontsManager.getTextStyleMedium(),),
            ],
          ),
          trailing:Switch(
            onChanged: (x){},
            value: true,
            key:switchState ,
            autofocus: true,
            activeColor: ColorsManager.pinkColor,
            focusColor: ColorsManager.greyColor,
            hoverColor: ColorsManager.yellowColor,
            splashRadius: 20,

          )

      ),
    );
  }
}*/
  }