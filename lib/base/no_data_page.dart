import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage({
    Key? key,
    required this.text,
    this.imgPath = "assets/images/empty-cart.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            height: MediaQuery.of(context).size.height * 0.54,
            width: MediaQuery.of(context).size.width * 0.54,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.024,
              color: Theme.of(context).disabledColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
