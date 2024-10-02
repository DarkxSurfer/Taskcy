import 'package:flutter/material.dart';
import '../../commons/custom_container.dart';
import '../../widgets/back_arrow.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final height  = MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.05,vertical: height * 0.07),
        child: Column(
          children: [
            Row(
              children: [
                const BackArrow(),
                SizedBox(width: width * 0.24),
                Text('Language',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,color: theme.primaryColor))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Uncomment below lines if needed
            const CustomContainer(
              text: "English",
              suffixIcon: Icons.circle,
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomContainer(
              text: "Urdu",
              suffixIcon: Icons.circle_outlined,
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomContainer(
              text: "Spanish",
              suffixIcon: Icons.circle_outlined,
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomContainer(
              text: "French",
              suffixIcon: Icons.circle_outlined,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
