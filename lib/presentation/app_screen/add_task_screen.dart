import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/data/controller/task_manage/add_task_controller.dart';
import 'package:untitled/presentation/constant/image_constants.dart';
import 'package:untitled/presentation/utiles/custom_appbar.dart';
import 'package:untitled/presentation/utiles/submit_button_widget.dart';
import '../../data/controller/language_controller.dart';
import 'authenication/profile_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final AddTaskController controller = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    var languageController = Get.find<LanguageController>();
    var currentLanguage = languageController.currentLanguage;

    return Scaffold(
      appBar: CustomAppBar(
        callBack: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset(
              AssetsPath.Background,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.background,

            child: Form(
              key: controller.globalKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            Text(
                              currentLanguage.add_newtask,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),

                            ///subject
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: TextFormField(
                                controller: controller.subjectController,
                                decoration: InputDecoration(
                                  hintText: currentLanguage.subject,
                                ),
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return "Enter your Value";
                                  }
                                  return null;
                                },
                              ),
                            ),

                            ///description
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: TextFormField(
                                  controller: controller.descriptionController,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    hintText: currentLanguage.description,
                                  ),
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return "Enter your Description";
                                    }
                                    return null;
                                  }),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),

                            GestureDetector(
                              onTap: () {
                                print("click - Add New Task");
                                if (controller.globalKey.currentState != null && controller.globalKey.currentState!.validate()) {
                                  controller.addNewTask();
                                }
                              },
                              child: GetBuilder<AddTaskController>(
                                builder: (controller) {
                                  return Visibility(
                                    visible: controller?.inProgress == false,
                                    replacement: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    ),
                                    child: const SubmitButtonWidget(
                                      HIcon: Icons.keyboard_arrow_right_outlined,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
