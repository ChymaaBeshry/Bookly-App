import 'package:bookly_app/Features/Presentation/Widgets/booksLogoWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Utilities/colorsManager.dart';
import '../../../../Core/Utilities/fontsManager.dart';
import '../../../../Core/Utilities/iconsManager.dart';
import '../../../../Core/Utilities/valuesManager.dart';
import '../../Controller/bookController.dart';
import '../../Controller/bookStates.dart';
import '../../Widgets/combonent.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    BookController bookController = BlocProvider.of<BookController>(context);
    return BlocBuilder<BookController,BookStates>(
     builder: (context,state){
       if(state is AddArchiveErrorBookSates){
         return centerErrorText();
       }else if(state is AddArchiveLoadingBookSates){
         return centerLoading();
       }else{
         return  Scaffold(
           body:Column(
             children: [
               SafeArea(
                 child:  ListTile(
                   trailing:sharedIcon(
                     color: ColorsManager.whiteColor,
                     icon: IconsManager.iconDelete,
                     onPressed: () {
                       bookController.deleteArchivedDatabase();
                     },
                   ) ,
                   title:Text(
                     "   Archived Books",
                     style: FontsManager.getTextStyleMedium(),
                   ),
                   subtitle:Text(
                     "   ${bookController.archiveList.length} book",
                     style: FontsManager.getTextStyleLight(color: ColorsManager.greyLightColor),
                   ) ,
                 ),
               ),
               Flexible(
                   child:decoration(
                       isBottomSheet: false,
                       widget:ListView.builder(
                         scrollDirection: Axis.vertical,
                         itemBuilder:(context,index)=>BookLogoWidget(
                           isArchive: true,
                           model: bookController.archiveList[index],
                           isDetail: true,
                           width: AppSize.size100,
                           height:  AppSize.size200,) ,
                         itemCount:bookController.archiveList.length ,
                       ),
                       marginBottom: AppSize.size10,
                       smallHeight: double.infinity ,
                       width: double.infinity)
               ),
             ],
           ),
         );
       }

     },
   );
  }
}
