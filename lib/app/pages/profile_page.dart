import 'package:bkd_presence_bloc/app/constants/initial_name.dart';
import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:bkd_presence_bloc/app/services/api_constant.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../models/user_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(
      {super.key,
      required this.userModel,
      required this.textTheme,
      required this.currentTime});
  final DateTime currentTime;
  final UserModel userModel;
  final TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    final user = userModel.data.user;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: ColorConstants.mainColor,
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.mainColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 27,
                      ),
                      Text(
                        "Profile",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 105,
                            width: 105,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 90,
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: user.profilePhotoPath == null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            initialName(user.name),
                                            style:
                                                textTheme.bodyLarge!.copyWith(
                                              fontSize: 28,
                                              color: ColorConstants.mainColor,
                                            ),
                                          ),
                                        )
                                      : Image.network(
                                          "${ApiConstants.apiUrl}/storage/${user.profilePhotoPath}",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.toNamed(Routes.editProfile, arguments: {
                              //   'name': user?.data?.user?.name,
                              //   'position': user?.data?.user?.position,
                              //   'phoneNumber': user?.data?.user?.phoneNumber,
                              //   'profilePhotoPath':
                              //       user?.data?.user?.profilePhotoPath,
                              // });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(top: 65, left: 65),
                              decoration: BoxDecoration(
                                color: ColorConstants.redColor,
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        user.position,
                        style:
                            textTheme.bodyMedium!.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Flexible(
                        child: Text(
                          user.name,
                          style: textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        user.phoneNumber,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.businessTrip,
                            arguments: {
                              'userModel': userModel,
                              'currentTime': currentTime,
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.work),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Perjalanan Dinas",
                              style: textTheme.bodyLarge!.copyWith(
                                color: const Color(0xFF383838),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.vacation,
                            arguments: {
                              'userModel': userModel,
                              'currentTime': currentTime,
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.map_rounded),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Cuti",
                              style: textTheme.bodyLarge!.copyWith(
                                color: const Color(0xFF383838),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.changeDevice,
                            arguments: userModel,
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.mobile_screen_share),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Ganti Device",
                              style: textTheme.bodyLarge!.copyWith(
                                color: const Color(0xFF383838),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
