import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskys/core/theme/theme_controller.dart';
import 'package:taskys/features/profile/user_details.dart';
import 'package:taskys/features/welcome/welcome_screens.dart';

import '../../core/constants/storge_key.dart';
import '../../core/services/pref_manger.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? motivationQuote;
  bool isLoading = true;
  bool isDarkMode = true;
  String? getImage;

  @override
  void initState() {
    super.initState();

    _loudData();
  }

  void _loudData() async {
    setState(() {
      username = PrefManager().getString(StorgeKey.username) ?? '';
      motivationQuote =
          PrefManager().getString('motivationQuote') ??
          'One task at a time. One step closer.';
      getImage = PrefManager().getString('image');
      isDarkMode = PrefManager().getBool('themes') ?? true;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: getImage == null
                                ? AssetImage("assets/images/profile_image.png")
                                : FileImage(
                                    File(getImage!),
                                  ),

                            radius: 60,
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showSimpleDialog(context, (XFile file) {
                                _saveImage(file);

                                setState(() {
                                  getImage = file.path;
                                });
                              });
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                border: Border.all(
                                  color: ThemeController.isDark()
                                      ? Colors.transparent
                                      : Color(0xffD1DAD6),
                                ),
                                color: ThemeController.isDark()
                                    ? Color(0xff282828)
                                    : Color(0xffFFFFFF),
                              ),
                              child: Icon(Icons.camera_alt, size: 26),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        username ?? '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 4),
                      Text(
                        motivationQuote ??
                            'One task at a time. One step closer.',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 16),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetails();
                        },
                      ),
                    );
                    if (result != null && result) {
                      _loudData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    'assets/images/users.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondaryContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    'User Details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: SvgPicture.asset(
                    'assets/images/arrow.svg',
                    colorFilter: ColorFilter.mode(
                      ThemeController.isDark()
                          ? Color(0xffC6C6C6)
                          : Color(0xff3A4640),
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                Divider(thickness: 1),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    'assets/images/mod.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondaryContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (BuildContext context, themeMode, Widget? child) {
                      return Switch(
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) async {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                Divider(thickness: 1),
                ListTile(
                  onTap: () async {
                    PrefManager().remove(StorgeKey.Tasks);
                    PrefManager().remove('motivationQuote');
                    PrefManager().remove(StorgeKey.username);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreens();
                        },
                      ),
                      (Route<dynamic> routs) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset(
                    'assets/images/log_out.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondaryContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    'Log Out',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: SvgPicture.asset(
                    'assets/images/arrow.svg',
                    colorFilter: ColorFilter.mode(
                      ThemeController.isDark()
                          ? Color(0xffC6C6C6)
                          : Color(0xff3A4640),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void showSimpleDialog(BuildContext context, Function(XFile file) onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Choss Photo ',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            SimpleDialogOption(
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text(
                    'Camera',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                getImage = image!.path;
                onSelect(image);
              },
            ),
            SimpleDialogOption(
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                getImage = image!.path;
                onSelect(image);
              },
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final setImagePath = await File(
      file.path,
    ).copy('${appDir.path}/${file.name}');

    PrefManager().setString('image', setImagePath.path);
  }
}
