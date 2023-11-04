import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/font_manager.dart';
import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/features/profile/profile_view_model.dart';
import 'package:flutter_task/features/profile/widget/profile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel profileViewModel = ProfileViewModel();
  @override
  void initState() {
    super.initState();
    profileViewModel.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: AppSize.h24, horizontal: AppSize.w10),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: AppSize.w120,
                      height: AppSize.h120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.h60),
                          child: Image(
                            fit: BoxFit.cover,
                            width: AppSize.w120,
                            height: AppSize.h120,
                            image: AssetImage(
                              ImageResources.placeholder,
                            ),
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: ColorResources.orangeColor),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(profileViewModel.user?.username ?? "name",
                    style: Theme.of(context).textTheme.headlineMedium),
                Text(profileViewModel.user?.email ?? "email",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => {}, //got to UpdateProfileScreen()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.primaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Center(
                        child: Text("Edit Profile",
                            style: FontManager.getBoldStyle(
                                fontSize: 18.sp, color: Colors.white))),
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                /// -- MENU
                ProfileMenuWidget(
                    title: "Settings", icon: Icons.settings, onPress: () {}),
                ProfileMenuWidget(
                    title: "Billing Details",
                    icon: Icons.wallet,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: "User Management",
                    icon: Icons.supervised_user_circle_outlined,
                    onPress: () {}),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Information", icon: Icons.info, onPress: () {}),
                ProfileMenuWidget(
                    title: "Logout",
                    icon: Icons.logout,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
