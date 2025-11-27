import 'package:flutter/material.dart';
import 'package:taskys/core/widgets/custom_text_from_filed.dart';

import '../core/services/pref_manger.dart';

class UserDetails extends StatefulWidget {
  UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController motivationQuoteController = TextEditingController();


  final GlobalKey<FormState> _key = GlobalKey<FormState>();


  void getPreferences() async {

    userNameController.text =  PrefManager().getString('username') ?? '';
    motivationQuoteController.text = PrefManager().getString('motivationQuote') ?? 'One task at a time. One step closer.';
  }

  @override
  void initState()  {
    super.initState();
    getPreferences();
  }
  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    motivationQuoteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFromFiled(
                controller: userNameController,
                hintText: 'Usama Elgendy',
                titelText: 'User Name',
                validator: (valuo) {
                  if (valuo!.isEmpty) {
                    return 'Please enter your name';
                  }
                },
                bordrSide: true,
              ),
              SizedBox(height: 20),
              CustomTextFromFiled(
                controller: motivationQuoteController,
                hintText: 'One task at a time. One step closer.',
                titelText: 'Motivation Quote',
                validator: (valuo) {
                  if (valuo!.isEmpty) {
                    return 'Please enter your Motivation Quote';
                  }
                },
                maxLines: 5,
                bordrSide: true,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate())  {

                    await PrefManager().setString('username', userNameController.text);
                    await PrefManager().setString('motivationQuote', motivationQuoteController.text);

                    Navigator.pop(context,true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xffFFFCFC),
                  backgroundColor: Color(0xff15B86C),
                  fixedSize: Size(MediaQuery
                      .of(context)
                      .size
                      .width, 40),
                ),
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
