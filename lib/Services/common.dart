
import 'package:flutter/material.dart';

class Common{
  static bool isDialogOpen = false;
  static buildShowDialog(BuildContext context) {
    // if(isDialogOpen == false) {
    //   isDialogOpen = true;
      Future.delayed(Duration.zero, () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
      });

   // }
  }

  static hideDialog(BuildContext context)
  {

      isDialogOpen = false;
      Future.delayed(Duration.zero, () {
        Navigator.pop(context);
      });

  }
}
