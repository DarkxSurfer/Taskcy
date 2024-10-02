import 'package:event_app/Utils/Constant/colors.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Container(
      height: height * 0.5,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
          top: height * 0.02, left: width * 0.04, right: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height:  height * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Taskcy',
                style: TextStyle(color: AColors.primaryLight,fontWeight: FontWeight.bold,fontSize: 50)),
              Text(
                "Building Better \n   Workplaces",
                style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor),
              ),
               SizedBox(
                height: height * 0.01),
               Text(
                  "Create a unique emotional story that \n       describes better than words",
                  style: TextStyle(fontSize: 14,color: Colors.grey.withOpacity(0.7),fontWeight: FontWeight.w500)),
              SizedBox(height:  height * 0.04),
              SizedBox(
                height:  height * 0.06,
                  width:  width *0.7,
                  child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: AColors.primaryLight,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      child: const Text('Get Started',style: TextStyle(color: Colors.white,fontSize: 20))))
            ],
          ),
        ],
      ),
    );
  }
}
