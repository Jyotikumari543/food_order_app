import 'package:flutter/material.dart';
import 'package:food_order_app/widgets/big_text.dart';
import '../../dimensions.dart';
import '../../widgets/app_icon.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;

  AccountWidget({
    Key? key,
    required this.bigText,
    required this.appIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.width10,
        bottom: Dimensions.width10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white54, // Background color for the entire widget
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
