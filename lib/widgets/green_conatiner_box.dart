import 'package:flutter/material.dart';
import '../Utils/Constant/colors.dart';

class GreenContainerBox extends StatelessWidget {
  const GreenContainerBox({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Padding(
      padding:  EdgeInsets.only(left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// time
          Container(height: height * 0.001,width: width * 0.29,color: AColors.grey.withOpacity(0.4)),

          // Text('10 am',style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.w600,fontSize: 17)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('12 pm',style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.w600,fontSize: 17)),
              // Container(height: height * 0.001,width: width * 0.20,color: AColors.grey.withOpacity(0.4)),

              /// Task Container
              Container(
                height: height * 0.11,width:  width*0.70,
                decoration: BoxDecoration(
                    color: Colors.lightGreen.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),topLeft: Radius.circular(15))),

                /// Under Container Texting
                child: Padding(
                  padding:  EdgeInsets.only(left: width * 0.07,top: height * 0.02,right: width *0.03),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mobile app Design 😍',style: TextStyle(color: Colors.white,fontSize: 16)),

                      SizedBox(height:  height * 0.01),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Image(image: AssetImage('Assets/person/Ellipse (2).png'),height: 25,),
                              SizedBox(width: 80),
                              Positioned(
                                  left: 13  ,height: 30,
                                  child: Image(image: AssetImage('Assets/logos/Ellipse (7).png'))),
                            ],
                          ),
                          Text('11am - 12am',style: TextStyle(color: Colors.white))

                        ],
                      ),



                    ],
                  ),
                ),

              )
            ],
          ),

          Container(height: height * 0.001,width: width * 0.29,color: AColors.grey.withOpacity(0.4)),

        ],
      ),
    );
  }
}
