import 'package:bkd_presence_bloc/app/blocs/login/login_bloc.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

import '../themes/text_themes.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_snackbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    final nipC = TextEditingController();
    final passC = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final loginBloc = context.read<LoginBloc>();
    loginBloc.add(GetDeviceId());
    String deviceId = '';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 75),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      "Sistem Presensi Badan Kepegawaian Daerah Provinsi Kalimantan Tengah",
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo_bkd.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NIP", style: textTheme.labelMedium),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomFormField(
                        textTheme: textTheme,
                        passC: nipC,
                        hintText: "Masukkan NIP",
                        validator: "NIP",
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Password",
                        style: textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocSelector<LoginBloc, LoginState, bool>(
                        selector: (state) {
                          if (state is HiddenPassword) {
                            return state.isHiddenPassword;
                          } else {
                            return true;
                          }
                        },
                        builder: (context, state) {
                          return CustomFormField(
                            textTheme: textTheme,
                            passC: passC,
                            obscureText: state,
                            suffixIcon: true,
                            hintText: "Masukkan password",
                            validator: "Password",
                            onPressed: () {
                              context
                                  .read<LoginBloc>()
                                  .add(HiddenPasswordOnPressed());
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  builder: (context, state) {
                    if (state is DeviceId) {
                      deviceId = state.deviceId;
                    }
                    return CustomButton(
                      width: 150,
                      height: 41,
                      textTheme: textTheme,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginBloc.add(
                            LoginButtonOnPressed(
                              nip: nipC.text,
                              password: passC.text,
                              deviceId: deviceId,
                            ),
                          );
                        }
                      },
                      child: state is LoginLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              "Login",
                              style: textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                    );
                  },
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushReplacementNamed(context, '/navigation');
                    } else if (state is LoginError) {
                      SnackBar snackBar = CustomSnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
