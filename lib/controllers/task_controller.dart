import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs; // Observing a list of tasks

  void addTask(Task task) {
    tasks.add(task);
  }
}
