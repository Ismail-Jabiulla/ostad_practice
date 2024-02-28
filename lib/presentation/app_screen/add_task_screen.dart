import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/presentation/constant/image_constants.dart';
import 'package:untitled/presentation/utiles/custom_appbar.dart';
import 'package:untitled/presentation/utiles/submit_button_widget.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
                          const Text(
                            'Add New Task',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Subject',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: TextFormField(
                              maxLines: 10,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          const SubmitButtonWidget(
                              HIcon: Icons.keyboard_arrow_right_outlined),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
