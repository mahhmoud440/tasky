import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskys/core/constants/storge_key.dart';

import '../../core/services/pref_manger.dart';
import '../navigation/main_screen.dart';

class WelcomeScreens extends StatelessWidget {
  WelcomeScreens({super.key});

  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/logos.svg",
                      width: 42,
                      height: 42,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 116),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To Tasky ',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      "assets/images/waving_han.svg",
                      width: 42,
                      height: 42,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(fontSize: 16),
                ),
                SizedBox(height: 24),
                SvgPicture.asset(
                  "assets/images/welcom.svg",
                  width: 214,
                  height: 204,
                ),
                SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFCFC),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: nameController,
                    style: Theme.of(context).textTheme.labelMedium,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'e.g. Sarah Khalid',

                    ),
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        PrefManager().setString(
                          StorgeKey.username,
                          nameController.value.text,
                        );
                        nameController.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MainScreen();
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter your name')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    ),
                    child: Text(
                      'Let’s Get Started',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
