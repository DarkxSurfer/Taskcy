import 'package:flutter/material.dart';

import '../Utils/Constant/colors.dart';

class TaskCustomBox extends StatelessWidget {
  const TaskCustomBox(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.backGroundColor,
      required this.title});

  final String title;
  final String startTime, endTime;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// time
          Row(
            children: [
              Text(startTime,
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),),
              SizedBox(width:  width * 0.05),
              Text('Start Time',
                style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.w500,fontSize: 17),),
            ],
          ),
          SizedBox(height: height*0.01),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: height * 0.001,
                  width: width * 0.20,
                  color: AColors.grey.withOpacity(0.4)),

              /// Task Container
              Container(
                height: height * 0.11, width: width * 0.70,
                decoration: BoxDecoration(
                    color: backGroundColor,
                    // color: const Color(0xff63B4FF),
                    borderRadius: BorderRadius.circular(15)),

                /// Under Container Texting
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07,
                      top: height * 0.02,
                      right: width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.w500)),
                      SizedBox(height: height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Stack(
                            children: [
                              Image(
                                image:
                                    AssetImage('Assets/person/Ellipse (2).png'),
                                height: 25,
                              ),
                              SizedBox(width: 80),
                              Positioned(
                                  left: 13,
                                  height: 30,
                                  child: Image(
                                      image: AssetImage(
                                          'Assets/logos/Ellipse (7).png'))),
                            ],
                          ),
                          Text('$startTime - $endTime',
                              style: const TextStyle(color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: height*0.01),

          Row(
            children: [
              Text(endTime, style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.w600,fontSize: 17)),
              SizedBox(width:  width * 0.05),
              Text('End Time', style: TextStyle(color: theme.primaryColor,fontWeight: FontWeight.w500,fontSize: 17)),
            ],
          ),
          SizedBox(height: height *0.02),
          const Divider()
        ],
      ),
    );
  }
}
