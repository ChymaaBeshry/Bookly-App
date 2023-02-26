import 'package:bookly_app/Core/Utilities/fontsManager.dart';
import 'package:bookly_app/Core/Utilities/StringManager.dart';
import 'package:bookly_app/Core/Utilities/colorsManager.dart';
import 'package:bookly_app/Core/Utilities/iconsManager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../../../Core/Utilities/valuesManager.dart';


List<Map<String,dynamic>> accountSectionDetails=
[
  {
    "icon1":IconsManager.iconFavorite,
    "title":"   Wish List",
    "title2":"31 ",
    "status":true,
    "screen":"wishList"
  },
  {
    "icon1":IconsManager.iconArchive,
    "title":"   My Book",
    "title2":" 12",
    "status":true,
    "screen":"archive"
  },
  {
    "icon1":IconsManager.iconLanguage,
    "title":"   Language",
    "title2":"English",
    "status":false,
    "screen":"wishList"
  },
  {
    "icon1":IconsManager.iconTheme,
    "title":"   Theme",
    "title2":"Dark",
    "status":false,
    "screen":""
  },

];
Link link({required String link, required String title}) => Link(
    uri: Uri.parse(link),
    target: LinkTarget.blank,
    builder: (BuildContext ctx, FollowLink? openLink) {
      return sharedButton(
          title: title, onTap: openLink!, width: AppSize.size100);
    });
Padding accountSection(IconData icon1,String title,String title2)=>Padding(
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
          Text(title2,style: FontsManager.getTextStyleLight(color: ColorsManager.pinkColor),),
          IconButton(
            icon: Icon(IconsManager.iconRight),
            onPressed: (){},
          )
              ]
          ),
        ],
      ),
);
Center centerLoading()=>const Center(
  child: CircularProgressIndicator(
    color: ColorsManager.pinkColor,
  ),
);

Center centerErrorText()=>const Center(
  child: Text(StringsManager.somethingWentWrong),
);
Padding divider(Color color) => Padding(
  padding: const EdgeInsets.only(bottom: AppSize.size15),
  child: Divider(
    height: AppSize.sizeD1,
    color: color,
    thickness: AppSize.sizeD1,
    endIndent: AppSize.size25,
    indent: AppSize.size25,
  ),
);
Container textBackground({required String title}) =>   Container(
    margin: EdgeInsetsDirectional.all(AppSize.size10),
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(AppSize.size15),
      color: ColorsManager.greyLightColor,
    ),
    alignment: Alignment.center,
    height: AppSize.size40,
    width: AppSize.size100,
    child: Text(
      title,
      style: FontsManager.getTextStyleLight(
        color: ColorsManager.yellowColor,
      ),
        textAlign: TextAlign.center
    ),
  );

IconButton sharedIcon(
    {required IconData icon,
      required Function onPressed,
      required Color color,
    }) {
  return IconButton(
      padding: const EdgeInsetsDirectional.all(AppSize.size5),
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        icon,
        color: color,
      ));
}
InkWell sharedButton({required String title, required Function onTap,required double width})=> InkWell(
  onTap:(){
    onTap();
  },
  child:   Container(
    margin: const EdgeInsetsDirectional.all(
        MarginSizeManager.m10),
    alignment: AlignmentDirectional.center,
    height: AppSize.size50,
    width: width,
    decoration: BoxDecoration(
      color: ColorsManager.pinkColor,
      borderRadius: BorderRadiusDirectional.circular(
          AppSize.size20),
    ),
    child: Text(title,
      style: FontsManager.getTextStyleMedium(
          color: ColorsManager.whiteColor),),
  ),
);

Text textTitle({required String title})=> Text( title, overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleBold(size: AppSize.size20,),textAlign: TextAlign.center,);
Text textSubTitle({required String subTitle})=> Text( subTitle, overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleMedium(),textAlign: TextAlign.center);
Container decoration(
    {required Widget widget,
      required double marginBottom,
      required double smallHeight,
      required double width,
      required bool isBottomSheet

    }) =>
    Container(
      margin: EdgeInsets.only(
          bottom:isBottomSheet==true?AppSize.size0: marginBottom ,
          top:isBottomSheet==true?marginBottom:AppSize.size15 ,
          left:AppSize.size5 ,
          right:AppSize.size5
      ),
      padding: const EdgeInsets.all(AppSize.sizeD1),
      height: smallHeight+AppSize.size20,
      width: width,
      decoration: BoxDecoration(
          color: ColorsManager.blackColor,
          borderRadius: BorderRadius.circular(AppSize.size20)),
      child: Container(
        padding:const EdgeInsets.all(AppSize.size15) ,
        height: smallHeight,
        width: AppSize.size250,
        decoration: BoxDecoration(
            color: ColorsManager.backGroundColor,
            borderRadius: BorderRadius.circular(AppSize.size20)),
        child: widget,
      ),
    );

Container verticalDivider()=>Container(
  height: AppSize.size70,
  width: AppSize.sizeD1,
  color: ColorsManager.greyColor,
);