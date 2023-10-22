import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:get/get.dart';

void ShowCustomMessage(String message,{bool isError=true,String title="Error"}){
  Get.snackbar(title,message,
  titleText: BigText(text: title,color: Colors.white,),
    messageText: Text(message,style: const TextStyle(
      color: Colors.white,

    ),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent


  );

}