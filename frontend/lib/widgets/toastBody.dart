import 'package:flutter/material.dart';

showToast(BuildContext context, bool isSuccess, String text){
  ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

      // Create a SnackBar object.
      SnackBar snackBar =  SnackBar(duration: Duration(seconds: 4),
        width: MediaQuery.of(context).size.width * .63,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal( left: Radius.circular(40), right: Radius.circular(40))),
        content: Text(text),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      );

      scaffoldMessenger.showSnackBar(snackBar);
}