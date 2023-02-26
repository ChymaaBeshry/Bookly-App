import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/Utilities/colorsManager.dart';
import '../../../Core/Utilities/fontsManager.dart';
import '../../../Core/Utilities/iconsManager.dart';
import '../../../Core/Utilities/imagesManager.dart';
import '../../../Core/Utilities/valuesManager.dart';
import '../Controller/bookController.dart';
import 'combonent.dart';
import 'moreSettingsForUser.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("\n  WELCOME ",style: FontsManager.getTextStyleBold(size: AppSize.size30,color: ColorsManager.pinkColor),),
            Padding(
              padding: const EdgeInsets.all(PaddingSizeManager.p10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                   child: Icon(IconsManager.iconAccount,size: AppSize.size70,),
                   // backgroundImage: AssetImage(ImagesManager.logo),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("\n\n  Rana Tarek",style: FontsManager.getTextStyleSemiBold(size: AppSize.size20),),
                      Text("  aranatarek@gmail.com\n\n",style: FontsManager.getTextStyleLight(),),
                    ],
                  ),
                ],
              ),
            ),
            divider(ColorsManager.greyLightColor),
            Text("  \n  MY ACCOUNT",style:FontsManager.getTextStyleSemiBold(),),
            Column(
              children: [
                for(int i=0 ;i<accountSectionDetails.length;i++)
                  MoreSettingsForUser(
                    title: accountSectionDetails[i]["title"],
                    icon1: accountSectionDetails[i]["icon1"],
                    isIconNavigate:accountSectionDetails[i]["status"],
                    screen:  accountSectionDetails[i]["screen"] ,
                    title2: accountSectionDetails[i]["title2"],
                  ),

              ],
            ),

          ],
        ),

      ],
    );
  }
}
