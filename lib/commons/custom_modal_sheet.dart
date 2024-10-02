import 'package:event_app/Utils/Constant/colors.dart';
import 'package:event_app/commons/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../view/Add Task Screen/add_task_screen.dart';
import '../view/CreateTeam/create_team_screen.dart';

class CustomModalSheet extends StatelessWidget {
  const CustomModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Container(
      height: height * 0.44,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        top: height * 0.02,
        left: width * 0.04,
        right: width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Divider at the top of the modal for visual cue to drag
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: width * 0.13,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
              ),

              SizedBox(height: height * 0.04),

              // Custom Containers for modal actions
              CustomContainer(
                icon: Iconsax.edit,
                text: "Create Task",
                onTap: () => Get.to(const AddTaskScreen()),
              ),
              const SizedBox(height: 10),
              const CustomContainer(
                  icon: Iconsax.add_square, text: "Create Project"),
              const SizedBox(height: 10),
              CustomContainer(
                icon: Icons.people_outline,
                text: "Create Team",
                onTap: () => Get.to(const CreateTeamScreen()),
              ),
              const SizedBox(height: 10),
              const CustomContainer(icon: Iconsax.clock, text: "Create Event"),
              SizedBox(height: height * 0.03),
              CircleAvatar(
                  radius: 25,
                  backgroundColor: AColors.primary,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 27)))
            ],
          ),
        ],
      ),
    );
  }
}
