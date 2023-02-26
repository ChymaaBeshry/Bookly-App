
import 'package:flutter/material.dart';
import 'package:bookly_app/Features/Presentation/Views/DetailsScreen/detailsScreen.dart';
import 'package:bookly_app/Core/Utilities/iconsManager.dart';
import 'package:bookly_app/Core/Utilities/colorsManager.dart';
import 'package:bookly_app/Core/Utilities/valuesManager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/bookController.dart';
import '../Controller/bookStates.dart';
import '../ViewModel/bookModel.dart';
import 'combonent.dart';
 class BookLogoWidget extends StatefulWidget{
   BookLogoWidget({required this.model,required this.isDetail,required this.width,required this.height ,required this.isArchive});
BookModel model;
bool isDetail;
   bool isArchive;
   double width;
   double height;
  @override
  State<BookLogoWidget> createState() => _BookLogoWidgetState();
}

class _BookLogoWidgetState extends State<BookLogoWidget> {
   @override
  Widget build(BuildContext context) {
     BookController bookController= BlocProvider.of<BookController>(context);
    return BlocBuilder<BookController,BookStates>(
        builder:(context,state){
          if(state is LoadingBookSates){
            return centerLoading();
          }else if(state is ErrorBookSates){
            return centerErrorText();
          }else{
            return InkWell(
                onTap: widget.isDetail==true?(){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailsScreen(model: widget.model)));

                }:null,
                child:Container(
                    margin: EdgeInsetsDirectional.all(AppSize.size10),
                    //    margin: EdgeInsetsDirectional.fromSTEB(AppSize.size10, 20,AppSize.size10 , AppSize.size10),
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.greyLightColor.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(AppSize.size30),
                      image: DecorationImage(
                        image: NetworkImage(widget.model.bookImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                    alignment: AlignmentDirectional.topEnd,
                    child: widget.isArchive==false?sharedIcon(
                        onPressed: (){
                          bookController.wishListHandle(widget.model);
                        },
                        icon:IconsManager.iconFavorite,
                        color: widget.model.isFav==true? ColorsManager.pinkColor: ColorsManager.greyLightColor
                    ):sharedIcon(
                        onPressed: (){
                          bookController.archiveHandle(widget.model);
                        },
                        icon:IconsManager.iconArchive,
                        color: widget.model.isArchive==true? ColorsManager.pinkColor: ColorsManager.greyLightColor
                    )

                )
            );
          }

     }
  );
}
 }
//            icon: Icon(IconsManager.iconFavorite,color: widget.isFav==false?ColorsManager.greyLightColor:  ColorsManager.pinkColor,size: widget.sizeIcon,),
