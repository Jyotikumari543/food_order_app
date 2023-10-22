import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/widgets/small_text.dart';

import '../colors.dart';
import '../dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widgets.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,required this.text}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height:Dimensions.height10,),
        //comments section
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {return Icon(Icons.star,color:AppColors.mainColor, size:20 ,);}),
            ),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "1287"),
            SizedBox(width: 10,),
            SmallText(text: "Comments"),


          ],
        ),
        SizedBox(height: Dimensions.height20,),
        //time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",

                iconColor: AppColors.iconColor1),

            IconAndTextWidget(icon: Icons.location_on,
                text: "1.7km",

                iconColor: AppColors.mainColor),

            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "20min",

                iconColor: AppColors.iconColor2),

          ],
        ),
      ],
    );
  }
}
