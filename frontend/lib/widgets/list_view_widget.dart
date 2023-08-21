import 'package:flutter/material.dart';

class ScrollableW extends StatelessWidget {
  final String mainText;
  final String subText;
  final Widget iconImage;

  const ScrollableW({
    Key? key, 
    required this.mainText, 
    required this.subText, 
    required this.iconImage}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70, 
      height: 350,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 187, width: 180,
                child: ClipRRect(clipBehavior: Clip.hardEdge ,child: iconImage)),
            ],
          ),
          const SizedBox(height: 13,),
          Text(mainText, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 19, color: Colors.blueGrey),),
          const SizedBox(height: 8,),
          Text(subText, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold), textAlign: TextAlign.center)
        ]
      ),
    );
  }
}
