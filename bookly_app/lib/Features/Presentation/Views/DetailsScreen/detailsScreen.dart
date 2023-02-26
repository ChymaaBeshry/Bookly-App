import 'package:bookly_app/Core/Utilities/colorsManager.dart';
import 'package:bookly_app/Features/Presentation/Widgets/combonent.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/Core/Utilities/valuesManager.dart';
import 'package:bookly_app/Features/Presentation/Widgets/booksLogoWidget.dart';
import 'package:bookly_app/Core/Utilities/fontsManager.dart';
import 'package:bookly_app/Core/Utilities/iconsManager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/bookController.dart';
import '../../ViewModel/bookModel.dart';
import '../../Widgets/bottomSheet.dart';
import '../ArchiveScreen/archiveSreen.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.model}) : super(key: key);
  BookModel model;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<BookController>(context).getCategoryForModel(widget.model);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookController bookController = BlocProvider.of<BookController>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            sharedIcon(
              color:ColorsManager.whiteColor ,
              icon:IconsManager.iconArchive,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveScreen()));

              },
            )
          ],
        ),
        body: ListView(
          children: [
            Column(children: [
              Container(
                  height: AppSize.size250,
                  child: BookLogoWidget(
                      isArchive: false,
                      model: widget.model,
                      isDetail: true,
                      width: AppSize.size200,
                      height: AppSize.size350)),
              Text(
                "\n ${widget.model.bookTitle}",
                style: FontsManager.getTextStyleBold(
                    color: ColorsManager.whiteColor, size: AppSize.size30),
                textAlign: TextAlign.center,
              ),
              Text(
                "\n${widget.model.bookSubTitle}\n",
                style: FontsManager.getTextStyleMedium(),
                textAlign: TextAlign.center,

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        IconsManager.iconStar,
                        size: 20,
                        color: ColorsManager.yellowColor,
                      ),
                      Text(
                        " ${widget.model.bookRating}  ",
                        style: FontsManager.getTextStyleLight(),
                      ),
                    ],
                  ),
                  Row(
                    children:  [
                      Icon(
                        IconsManager.iconEye,
                        size: 20,
                        color: ColorsManager.yellowColor,
                      ),
                      Text(
                        " 23910",
                        style: FontsManager.getTextStyleLight(),

                      ),
                    ],
                  ),
                ],
              ),
              sharedButton(
                        title: "for Details",
                        width: AppSize.size250,
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              backgroundColor: ColorsManager.transparentColor,
                              elevation: AppSize.size10,
                              enableDrag: true,
                              builder: (BuildContext context) {
                                return  BottomSheetWidget(model: widget.model,);
                              });
                        }),

              Container(
                height: AppSize.size150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookController.categoryList.length,
                  itemBuilder: (context, index) => BookLogoWidget(
                      isArchive: false,
                      model: bookController.categoryList[index],
                      isDetail: true,
                      width: AppSize.size100,
                      height: AppSize.size350),
                ),
              ),
            ]),
          ],
        ));
  }
}
