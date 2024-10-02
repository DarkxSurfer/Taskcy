import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var isDark = false.obs;

  void changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

Rx<bool> isVisible = true.obs;


  void isVisibleChange(){
    isVisible.value = !isVisible.value;
  }

  var selectedIndex = 1.obs; // Observable variable to track selected index

  // Function to update the selected index
  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}





































// RxBool isVisible = true.obs;
//
// // Toggle function to change the visibility state
// void toggleVisibility() {
//   isVisible.value = !isVisible.value;
// }