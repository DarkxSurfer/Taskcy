import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(height: height * 0.07,width:  width * 0.1,
      decoration:  BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
          shape: BoxShape.circle
      ),
      child: Center(child: IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios,color: theme.primaryColor,size: 20))),
    );
  }
}
