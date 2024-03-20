import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/services/network_caller.dart';
import 'package:untitled/data/utility/app_url.dart';
import 'package:untitled/presentation/constant/image_constants.dart';
import 'package:untitled/presentation/utiles/custom_appbar.dart';
import 'package:untitled/presentation/utiles/submit_button_widget.dart';
import '../../data/provider/language_provider.dart';
import '../utiles/custom_snackbar.dart';
import 'authenication/profile_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _addTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var currentLanguage = languageProvider.currentLanguage;

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
              key: _globalKey,
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
                                controller: _subjectController,
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
                                  controller: _descriptionController,
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
                                if (_globalKey.currentState != null && _globalKey.currentState!.validate()) {
                                  _addNewTask();
                                }
                              },
                              child: Visibility(
                                visible: _addTaskInProgress == false,
                                replacement:  const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: const SubmitButtonWidget(
                                  HIcon: Icons.keyboard_arrow_right_outlined,
                                ),
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

  Future<void> _addNewTask() async {
    _addTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "title": _subjectController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };

    final response =
    await NetworkCaller.postRequest(Urls.createTask, inputParams);

    _addTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _subjectController.clear();
      _descriptionController.clear();
      if (mounted) {
        showSnackBarMessage(context, 'New task has been added!');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Add new task failed!', true);
      }
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
