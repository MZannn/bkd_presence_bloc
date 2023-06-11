import 'dart:io';

import 'package:bkd_presence_bloc/app/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:bkd_presence_bloc/app/constants/color_constants.dart';
import 'package:bkd_presence_bloc/app/constants/initial_name.dart';
import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_appbar.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_button.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_snackbar.dart';
import 'package:bkd_presence_bloc/app/widgets/label_button.dart';
import 'package:bkd_presence_bloc/app/widgets/label_text_2.dart';
import 'package:flutter/material.dart';

import '../services/api_constant.dart';
import '../widgets/custom_disabled_text_field.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfBloc = context.read<EditProfileBloc>();
    final formKey = GlobalKey<FormState>();
    final UserModel arguments =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final user = arguments.data.user;
    final TextEditingController nameC = TextEditingController(text: user.name);
    final TextEditingController positionC =
        TextEditingController(text: user.position);
    final TextEditingController phoneNumC =
        TextEditingController(text: user.phoneNumber);
    final textTheme = Themes.light.textTheme;
    File? file;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Edit Profile",
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BlocConsumer<EditProfileBloc, EditProfileState>(
                  bloc: editProfBloc,
                  listener: (context, state) {
                    if (state is ImagePicked) {
                      file = state.file;
                    } else if (state is ImageNotPicked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          content: Text(state.message),
                          backgroundColor: ColorConstants.redColor,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Stack(
                      children: [
                        Container(
                          height: 105,
                          width: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(
                              color: ColorConstants.mainColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 90,
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: user.profilePhotoPath == null &&
                                        state is ImagePicked
                                    ? Image.file(
                                        state.file,
                                        fit: BoxFit.cover,
                                      )
                                    : user.profilePhotoPath != null
                                        ? Image.network(
                                            "${ApiConstants.baseUrl}/storage/${user.profilePhotoPath}",
                                            fit: BoxFit.cover,
                                          )
                                        : CircleAvatar(
                                            backgroundColor:
                                                ColorConstants.mainColor,
                                            child: Text(
                                              initialName(user.name),
                                              style:
                                                  textTheme.bodyLarge!.copyWith(
                                                fontSize: 28,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            editProfBloc.add(PickImage());
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
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              LabelText2(label: "Nama", textTheme: textTheme),
              const SizedBox(
                height: 8,
              ),
              CustomDisabledTextField(
                controller: nameC,
                enabled: false,
                hintText: "Nama",
                filled: true,
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 8,
              ),
              LabelText2(label: "Jabatan", textTheme: textTheme),
              const SizedBox(
                height: 8,
              ),
              CustomDisabledTextField(
                controller: positionC,
                enabled: false,
                hintText: "Nama",
                filled: true,
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 8,
              ),
              LabelText2(label: "No Hp", textTheme: textTheme),
              const SizedBox(
                height: 8,
              ),
              CustomDisabledTextField(
                controller: phoneNumC,
                enabled: true,
                hintText: "No Hp",
                filled: false,
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 32,
              ),
              Center(
                child: BlocConsumer<EditProfileBloc, EditProfileState>(
                  bloc: editProfBloc,
                  listener: (context, state) {
                    if (state is EditProfileSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          content: Text(state.message),
                          backgroundColor: ColorConstants.mainColor,
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.navigation,
                        (route) => route.isFirst,
                      );
                    } else if (state is EditProfileFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          content: Text(state.message),
                          backgroundColor: ColorConstants.redColor,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        textTheme: textTheme,
                        width: 150,
                        height: 41,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            editProfBloc.add(
                              EditProfile(
                                phoneNumber: phoneNumC.text,
                                file: file,
                              ),
                            );
                          }
                        },
                        child:
                            LabelButton(label: "Simpan", textTheme: textTheme));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
