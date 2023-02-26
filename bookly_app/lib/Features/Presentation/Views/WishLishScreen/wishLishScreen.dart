import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Utilities/colorsManager.dart';
import '../../../../Core/Utilities/fontsManager.dart';
import '../../../../Core/Utilities/iconsManager.dart';
import '../../../../Core/Utilities/valuesManager.dart';
import '../../Controller/bookController.dart';
import '../../Controller/bookStates.dart';
import '../../Widgets/booksLogoWidget.dart';
import '../../Widgets/combonent.dart';
class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
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
                        bookController.deleteWishListDatabase();
                      },
                    ) ,
                    title:Text(
                      "   WishListed Books",
                      style: FontsManager.getTextStyleMedium(),
                    ),
                    subtitle:Text(
                      "   ${bookController.wishListList.length} book",
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
                            isArchive: false,
                            model: bookController.wishListList[index],
                            isDetail: false,
                            width: AppSize.size100,
                            height:  AppSize.size250,) ,
                          itemCount:bookController.wishListList.length ,
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
