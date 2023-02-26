
import 'package:bookly_app/Features/Presentation/Controller/bookController.dart';
import 'package:bookly_app/Features/Presentation/ViewModel/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/Core/Utilities/iconsManager.dart';
import 'package:bookly_app/Core/Utilities/colorsManager.dart';
import 'package:bookly_app/Core/Utilities/valuesManager.dart';
import 'package:bookly_app/Core/Utilities/fontsManager.dart';
import 'package:bookly_app/Features/Presentation/Widgets/booksLogoWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'combonent.dart';

class BookDetailsWidget extends StatelessWidget{
  BookDetailsWidget(this.model,{Key? key}) : super(key: key);
BookModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.all(AppSize.size10),
        height: 375,
        width: 202,
        child:Stack(
          children: [
            Positioned(
              left:0 ,
              bottom:0 ,
              right:0 ,
              child: Container(
                height: 280,
                width: double.infinity,
                decoration:BoxDecoration(
                  color: ColorsManager.backGroundColor,
                  borderRadius: BorderRadiusDirectional.circular(29),
                  boxShadow: [
                    BoxShadow(
                      color:ColorsManager.whiteColor.withOpacity(0.5) ,
                      blurRadius: 33,
                      offset:Offset(0 ,10) ,
                      blurStyle: BlurStyle.outer
                    )
                  ]
                ),
              ),
            ),
            BookLogoWidget(isArchive: false,model: model,isDetail: true,width:AppSize.size150,height: AppSize.size170),
            Positioned(
              top: 100,
                right: 10,
                child:Column(
                   children: [
                     Text( "Pages ${model.bookPageNumber}    ", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor,),),

                     Row(
                           children: [
                             for(int i=0;i<model.bookRating;i++)
                              Icon(IconsManager.iconStar,color: ColorsManager.yellowColor, size: 15,),
                             Text( " ${model.bookRating}    ", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor,),),
                           ],
                         ),

        ]
            )
            ),
            Positioned(
              top: 210,
                left: 30,
                child: Container(
                 // color: ColorsManager.whiteColor,
                  height: 160,
                  width: 250,
                  child: Column(
                    children: [
                        textTitle(title: model.bookTitle),
                        textSubTitle(subTitle:model.bookSubTitle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          model.bookGooglePlay.isEmpty
                              ?const SizedBox()
                              : link(
                              title: " GooglePlay ",
                              link: "https://play.google.com/store/books/details?id=${model.bookId}&pli=1&key=${BlocProvider.of<BookController>(context).apiKey}"),
                          model.bookPDF.isEmpty
                              ?const SizedBox()
                              : link(
                              title: "PDF", link: model.bookPDF),
                        ],
                      ),

                    ],
                  ),
                )
            ),
      ]
        ),
    );
  }


}
/* Link(
              uri: Uri.parse(
                  'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return textBackground(title:"read",onTap: openLink;);
              },
            ), Link(
      uri: Uri.parse(
          'https://pub.dev/documentation/url_launcher/latest/link/link-library.html'),
      target: LinkTarget.blank,
      builder: (BuildContext ctx, FollowLink? openLink) {
        return   textBackground(title:"download",onTap: (){
          openLink;
         // _launchUrl(model.bookGooglePlay);
          print("DDDDDDDDDDDDDDDDDDdddddddddd");
        });
      },
    ),*/












// Column(
//             children: [
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   BookLogoWidget(model: model,isDetail: true,width: AppSize.size100,hieght: AppSize.size250),
//                  Column(
//                    children: [
//                      sharedIcon(
//                        color: ColorsManager.pinkColor,
//                        onPressed:(){} ,
//                        icon:IconsManager.iconFavorite ,),
//                      Row(
//                        children: [
//                          Row(
//                            children: [
//                              Icon(IconsManager.iconStar,color: ColorsManager.yellowColor, size: 15,),
//                              Text( " ${model.bookRating}    ", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor,),),
//                            ],
//                          ),
//                          Row(
//                            children: [
//                              Icon(IconsManager.iconEye,color: ColorsManager.yellowColor, size: 15,),
//                              Text( " ${5656}", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor),),
//                            ],
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                     ],
//                   ),
//               Expanded(child: Text( model.bookTitle, overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleBold(size: AppSize.size20),)),
//               Expanded(child: Text( model.bookSubTitle, overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleMedium(color: ColorsManager.greyLightColor),)),
//               // Text( "${230} EGP", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor,size: AppSize.size15),),
//               Row(
//                 children: [
//                   textBackground("download"),
//                   textBackground("read"),
//                 ],
//               ),
// 
//             ],
//               ),
//Row(
//           children: [
//             BookLogoWidget(model: model,isDetail: true),
//             Column(
//              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(child: Text( model.bookTitle, overflow: TextOverflow.ellipsis, maxLines:1,style: FontsManager.getTextStyleBold(size: AppSize.size20),)),
//                 Expanded(child: Text( model.bookSubTitle, overflow: TextOverflow.ellipsis, maxLines:1,style: FontsManager.getTextStyleMedium(color: ColorsManager.greyLightColor),)),
//                 Text( "${230} EGP", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor,size: AppSize.size15),),
//                 Row(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(IconsManager.iconStar,color: ColorsManager.yellowColor, size: 15,),
//                             Text( " ${model.bookRating}    ", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor,),),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(IconsManager.iconEye,color: ColorsManager.yellowColor, size: 15,),
//                             Text( " ${5656}", overflow: TextOverflow.ellipsis, maxLines:2,style: FontsManager.getTextStyleRegular(color: ColorsManager.greyLightColor),),
//                           ],
//                         )
//                       ],
//                     ),
//
//                   ],
//                 )
//               ],
//             ),