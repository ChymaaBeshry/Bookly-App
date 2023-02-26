import 'package:flutter/material.dart';

import '../../../Core/Utilities/colorsManager.dart';
import '../../../Core/Utilities/fontsManager.dart';
import '../../../Core/Utilities/iconsManager.dart';
import '../../../Core/Utilities/valuesManager.dart';
import 'combonent.dart';

class InputModel{
  TextInputType keyboardType;
  TextEditingController controller;
  GlobalKey key;
  Function? onSubmitted=(){};
  Function? onChanged=(){};
  Function(String) validator;
  IconData prefix;
  IconData? suffix;
  String title;
  String hint;
  bool isSecure;
  bool outoCorrect;
  String  validateTitle;
  double width;
  InputModel({
    required this.key,
    required this.controller,
    this.title="",
    this.hint="",
    required this.prefix,
    this.isSecure=false,
    this.outoCorrect=true,
    this.keyboardType=TextInputType.text,
    this.onSubmitted,
    required this.validator,
    this.validateTitle="",
    this.width=double.infinity,
    this.suffix,
    this.onChanged

  });

}


class InputField extends StatefulWidget {
  InputField({Key? key,  required this.model}) : super(key: key);
  InputModel model;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical:AppSize.size10 ,
        horizontal:AppSize.size5,
      ),
      width:widget.model.width ,
      child: TextFormField(
        onChanged:(x){
         // widget.model.onChanged!();
        } ,
          keyboardType:widget.model.keyboardType,
          controller: widget.model.controller,
          key:widget.model.key ,
          onFieldSubmitted:(x){
            widget.model.onSubmitted!();
          },
          validator:(x){
            return widget.model.validator(x!.toString());

          } ,
          obscureText:widget.model.isSecure ,
          autocorrect:widget.model.outoCorrect ,
          decoration:InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.size10)),
            labelText:widget.model.title ,
            labelStyle:FontsManager.getTextStyleLight(color: ColorsManager.yellowColor) ,
            hintText:widget.model.hint ,
            hintStyle:FontsManager.getTextStyleLight(color: ColorsManager.greyLightColor,size: AppSize.size15) ,
            prefixIcon: Icon(widget.model.prefix,size: AppSize.size20,color: ColorsManager.yellowColor,),
            suffixIcon:widget.model.prefix==IconsManager.passwordIcon?sharedIcon(
                icon: IconsManager.eyeIcon,
                onPressed: (){
                  setState((){
                    widget.model.isSecure= !widget.model.isSecure;
                  });
                },
                color: ColorsManager.yellowColor) : Icon(widget.model.suffix,color: ColorsManager.yellowColor,) ,
            errorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.size20),
              borderSide:const BorderSide(
                color:ColorsManager.yellowColor,
                width: AppSize.sizeD1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.size20),
              borderSide:const BorderSide(
                color: ColorsManager.yellowColor,
                width: AppSize.sizeD1,
              ),
            ),
            enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.size20),
              borderSide:const BorderSide(
                width: AppSize.sizeD1,
                color: ColorsManager.greyLightColor,
              ),
            ),

          )



      ),
    );
  }
}
