import 'package:bkd_presence_bloc/app/blocs/change_device/change_device_bloc.dart';
import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_appbar.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_button.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_snackbar.dart';
import 'package:bkd_presence_bloc/app/widgets/expanded_text_field.dart';
import 'package:bkd_presence_bloc/app/widgets/label_button.dart';
import 'package:bkd_presence_bloc/app/widgets/label_text.dart';
import 'package:flutter/material.dart';

class ChangeDevicePage extends StatelessWidget {
  const ChangeDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final changeDeviceBloc = context.read<ChangeDeviceBloc>();
    final UserModel arguments =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final user = arguments.data.user;
    final formKey = GlobalKey<FormState>();
    final textTheme = Themes.light.textTheme;
    final TextEditingController reasonC = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Permintaan Ubah Device",
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelText(
                width: double.infinity,
                label: "Alasan Penggantian Device",
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 8,
              ),
              ExpandedTextField(
                hintText: "Masukkan Alasan Anda...",
                controller: reasonC,
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: BlocConsumer<ChangeDeviceBloc, ChangeDeviceState>(
                  bloc: changeDeviceBloc,
                  listener: (context, state) {
                    if (state is ChangeDeviceApiSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.navigation,
                        (route) => route.isFirst,
                      );
                    } else if (state is ChangeDeviceApiFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      textTheme: textTheme,
                      width: 276,
                      height: 41,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          changeDeviceBloc.add(
                            ChangeDevice(
                              nip: user.nip,
                              officeId: user.officeId,
                              reason: reasonC.text,
                            ),
                          );
                        }
                      },
                      child: LabelButton(
                        label: "Ajukan Permintaan Ganti Device",
                        textTheme: textTheme,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
