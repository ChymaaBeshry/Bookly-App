import 'package:bookly_app/Features/Presentation/ViewModel/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Core/Utilities/colorsManager.dart';
import '../../../Core/Utilities/fontsManager.dart';
import '../../../Core/Utilities/iconsManager.dart';
import '../../../Core/Utilities/valuesManager.dart';
import '../Controller/bookController.dart';
import '../Controller/bookStates.dart';
import 'booksLogoWidget.dart';
import 'combonent.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({Key? key, required this.model}) : super(key: key);
  BookModel model;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  void initState() {
    BlocProvider.of<BookController>(context).getBookDetails(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookController bookController = BlocProvider.of<BookController>(context);
    return Container(
      height: MediaQuery.of(context).size.height/2,
      child: BlocBuilder<BookController, BookStates>(
          builder: (context, state) {
            if (state is LoadingBookSates) {
              return centerLoading();
            } else if (state is ErrorBookSates) {
              return centerErrorText();
            } else {
              return Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  decoration(
                      isBottomSheet: true,
                      widget: ListView(
                        children: [
                          ListTile(
                            leading: sharedIcon(
                                color:ColorsManager.greyLightColor,
                                icon: IconsManager.shareIcon,
                          onPressed: () async {
                            await Share.share('${widget.model.bookLink}');
                           /* await bookController.wishListHandle(
                                widget.model);*/
                          }),
                            trailing: sharedIcon(
                                icon: IconsManager.iconArchive,
                                color: widget.model.isArchive == true
                                    ? ColorsManager
                                    .pinkColor
                                    : ColorsManager.greyLightColor,
                                onPressed: () async {
                                  await bookController.archiveHandle(
                                      widget.model);
                                }),
                          ),
                          const SizedBox(
                            height: AppSize.size70,
                          ),
                          textTitle(title: "${widget.model.bookTitle}"),
                          textSubTitle(subTitle: widget.model.bookSubTitle),
                          decoration(
                              isBottomSheet: false,
                              widget: ListView.builder(
                                itemBuilder: (context, index) =>
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            textBackground(
                                                title: bookController
                                                    .bookDetails[index]
                                                ["title"]),
                                            Text(
                                              bookController
                                                  .bookDetails[index]["data"],
                                              style: FontsManager
                                                  .getTextStyleRegular(),
                                            )
                                          ],
                                        ),
                                        verticalDivider(),
                                      ],
                                    ),
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                              ),
                              smallHeight: AppSize.size100,
                              width: double.infinity,
                              marginBottom: AppSize.size0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.model.bookGooglePlay.isEmpty
                                  ?const SizedBox()
                                  : link(
                                  title: " GooglePlay ",
                                  link: widget.model.bookGooglePlay),
                              widget.model.bookPDF.isEmpty
                                  ?const SizedBox()
                                  : link(
                                  title: "PDF", link: widget.model.bookPDF),
                            ],
                          ),
                        ],
                      ),
                      marginBottom: AppSize.size100,
                      smallHeight: 1000,
                      width: double.infinity),
                  BookLogoWidget(
                    isArchive: false,
                    width: AppSize.size150,
                    model: widget.model,
                    isDetail: true,
                    height: AppSize.size200,
                  ),
                ],
              );
            }
          }),
    );
  }


 /* final box = context.findRenderObject() as RenderBox?;

  await Share.share(
  text,
  subject: subject,
  sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );*/
}
/*
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius:BorderRadiusDirectional.only(
              topStart:Radius.circular(AppSize.size30) ,
              topEnd:Radius.circular(AppSize.size30)
            ) ,

          ),*/
/*RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),*/
