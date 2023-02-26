import 'package:bookly_app/Core/Utilities/colorsManager.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/Features/Presentation/Widgets/bookDetailsWidget.dart';
import 'package:bookly_app/Core/Utilities/valuesManager.dart';
import 'package:bookly_app/Features/Presentation/Widgets/booksLogoWidget.dart';
import 'package:bookly_app/Core/Utilities/fontsManager.dart';
import 'package:bookly_app/Core/Utilities/StringManager.dart';
import 'package:bookly_app/Core/Utilities/imagesManager.dart';
import 'package:bookly_app/Core/Utilities/iconsManager.dart';
import 'package:bookly_app/Features/Presentation/Widgets/combonent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/bookController.dart';
import '../../Controller/bookStates.dart';
import '../../Widgets/drawerWidget.dart';
import '../../Widgets/inputWidget.dart';
import '../ArchiveScreen/archiveSreen.dart';



class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key }) : super(key: key);


  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
GlobalKey searchKey=GlobalKey();
TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: Drawer(
        backgroundColor: ColorsManager.backGroundColor,
        child:DrawerWidget(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(ImagesManager.logo,height: 25,),
        actions: [
          sharedIcon(
              color:ColorsManager.whiteColor,
              icon: IconsManager.iconArchive,
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveScreen()));

              }
          ) ,
          ]
      ),
      body:BlocBuilder<BookController,BookStates>(
        builder: (context,state){
          BookController bookController=BlocProvider.of<BookController>(context);
          if(state is ErrorBookSates){
            return centerErrorText();
          }else if(state is LoadingBookSates){
            return centerLoading();
          }else{
            return  ListView(
                scrollDirection: Axis.vertical,
                children: [
                  decoration(
                      widget:Text("  \"READING BOOKS MAKES YOU BETTER.\"   ",style: FontsManager.getTextStyleBold(size: AppSize.size15 ,color: ColorsManager.yellowColor,isFontStyle: false),textAlign: TextAlign.center,) ,
                      marginBottom: 0,
                      smallHeight: 30,
                      width: double.infinity,
                      isBottomSheet: false),
                  Text(StringsManager.bestSeller,style: FontsManager.getTextStyleBold(size: AppSize.size30 ,color: ColorsManager.pinkColor,isFontStyle: false)),
                  Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(vertical: AppSize.size20),
                    child: ListView.builder(
                      scrollDirection:Axis.horizontal,
                      itemCount: bookController.books.length,
                      itemBuilder:(BuildContext context,index )=>
                          BookLogoWidget(isArchive: false,model:bookController.books[index],isDetail:true,width: AppSize.size100,height: AppSize.size100 ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("  Search By ",style: FontsManager.getTextStyleLight(size: AppSize.size30 ,color: ColorsManager.pinkColor,isFontStyle: false)),
                      Icon(IconsManager.iconSearch,color:  ColorsManager.pinkColor,),

                    ],
                  ),
                  Container(
                    height: AppSize.size50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for(int i=0; i<4;i++)
                          InkWell(
                            onTap: (){
                              bookController.getSelectedSearch(i);
                            },
                            child: textBackground(
                              title:bookController.searchTitle[i] ,
                            ),
                          ),
                      ],
                    ),
                  ),
                  bookController.isSearch==true? InputField(
                    model: InputModel(
                        key: searchKey,
                        controller: searchController,
                        prefix: IconsManager.iconSearch,
                        validator:(searchController){},
                        title:"search by.....",
                        onSubmitted: (){
                          bookController.searchBy(searchController.text);
                          bookController.isSearch=false;
                        }
                    ),
                  ):SizedBox(),

                  for(int i =0; i<bookController.searchList.length; i++)
                    BookDetailsWidget(bookController.searchList[i]),






                ]
            );

          }
        })

    );
  }
}
