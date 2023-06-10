import 'dart:io';

import 'package:bkd_presence_bloc/app/blocs/business_trip/business_trip_bloc.dart';
import 'package:bkd_presence_bloc/app/constants/color_constants.dart';
import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/colon.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_appbar.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_button.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_snackbar.dart';
import 'package:bkd_presence_bloc/app/widgets/date_picker.dart';
import 'package:bkd_presence_bloc/app/widgets/label_button.dart';
import 'package:bkd_presence_bloc/app/widgets/label_text.dart';
import 'package:flutter/material.dart';

class BusinessTripPage extends StatelessWidget {
  const BusinessTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    final businessTripBloc = context.read<BusinessTripBloc>();
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map;
    final DateTime currentTime = arguments['currentTime'];
    final UserModel userModel = arguments['userModel'];
    final textTheme = Themes.light.textTheme;
    final formKey = GlobalKey<FormState>();
    final startDateC = TextEditingController();
    final endDateC = TextEditingController();
    File? file;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Perjalanan Dinas",
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabelText(
                    width: 115,
                    label: "Tanggal Dimulai",
                    textTheme: textTheme,
                  ),
                  ColonWidget(
                    textTheme: textTheme,
                  ),
                  Expanded(
                    child: BlocConsumer<BusinessTripBloc, BusinessTripState>(
                      bloc: businessTripBloc,
                      listener: (context, state) {
                        if (state is StartDatePicked) {
                          startDateC.text = state.startDate;
                        }
                        if (state is StartDateNotPicked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content: const Text(
                                  "Tanggal dimulai tidak boleh kosong"),
                              backgroundColor: ColorConstants.redColor,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return DatePicker(
                          controller: startDateC,
                          hintText: "Tanggal Dimulai",
                          validator: "Tanggal dimulai tidak boleh kosong",
                          textTheme: textTheme,
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: currentTime,
                              firstDate: currentTime,
                              lastDate: DateTime(
                                currentTime.year + 5,
                              ),
                            );
                            if (picked != null) {
                              businessTripBloc.add(
                                StartDatePicker(pickedDate: picked),
                              );
                            } else {
                              businessTripBloc.add(
                                StartDateNotPick(),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabelText(
                    width: 115,
                    label: "Tanggal Berakhir",
                    textTheme: textTheme,
                  ),
                  ColonWidget(
                    textTheme: textTheme,
                  ),
                  Expanded(
                    child: BlocConsumer<BusinessTripBloc, BusinessTripState>(
                      bloc: businessTripBloc,
                      listener: (context, state) {
                        if (state is EndDatePicked) {
                          endDateC.text = state.endDate;
                        }
                        if (state is EndDateNotPicked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content: const Text(
                                  "Tanggal berakhir tidak boleh kosong"),
                              backgroundColor: ColorConstants.redColor,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return DatePicker(
                          controller: endDateC,
                          hintText: "Tanggal Berakhir",
                          validator: "Tanggal berakhir tidak boleh kosong",
                          textTheme: textTheme,
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: currentTime,
                              firstDate: currentTime,
                              lastDate: DateTime(
                                currentTime.year + 5,
                              ),
                            );
                            if (picked != null) {
                              businessTripBloc.add(
                                EndDatePicker(pickedDate: picked),
                              );
                            } else {
                              businessTripBloc.add(
                                EndDateNotPick(),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabelText(
                    width: 115,
                    label: "Surat Dinas",
                    textTheme: textTheme,
                  ),
                  ColonWidget(
                    textTheme: textTheme,
                  ),
                  Expanded(
                    child: BlocConsumer<BusinessTripBloc, BusinessTripState>(
                      bloc: businessTripBloc,
                      listener: (context, state) {
                        if (state is FilePicked) {
                          file = state.file;
                        }
                        if (state is FileNotPicked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content: const Text("File tidak boleh kosong"),
                              backgroundColor: ColorConstants.redColor,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            businessTripBloc.add(
                              PickFile(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstants.grey200,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    state is FilePicked
                                        ? state.fileName
                                        : 'Surat Dinas',
                                    style: textTheme.labelLarge!.copyWith(
                                      color: ColorConstants.grey100,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  Icons.attach_file,
                                  color: ColorConstants.grey200,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              BlocConsumer<BusinessTripBloc, BusinessTripState>(
                bloc: businessTripBloc,
                listener: (context, state) {
                  if (state is SendBusinessTripApiSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(
                        content: Text(
                          state.message,
                        ),
                        backgroundColor: ColorConstants.mainColor,
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.navigation,
                      (route) => route.isFirst,
                    );
                  }
                  if (state is SendBusinessTripApiFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(
                        content: Text(
                          state.message,
                        ),
                        backgroundColor: ColorConstants.redColor,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    height: 41,
                    width: 150,
                    onPressed: () {
                      if (!formKey.currentState!.validate() && file == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(
                            content: const Text("File tidak boleh kosong"),
                            backgroundColor: ColorConstants.redColor,
                          ),
                        );
                      } else if (file == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(
                            content: const Text("File tidak boleh kosong"),
                            backgroundColor: ColorConstants.redColor,
                          ),
                        );
                      } else if (!formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar(
                            content: const Text("Tanggal tidak boleh kosong"),
                            backgroundColor: ColorConstants.redColor,
                          ),
                        );
                      } else if (formKey.currentState!.validate() &&
                          file != null) {
                        businessTripBloc.add(
                          SendBusinessTrip(
                            nip: userModel.data.user.nip,
                            officeId: userModel.data.user.officeId,
                            presenceId:
                                userModel.data.presences!.first.id.toString(),
                            startDate: startDateC.text,
                            endDate: endDateC.text,
                            file: file!,
                          ),
                        );
                      }
                    },
                    textTheme: textTheme,
                    child: LabelButton(
                      label: "Kirim",
                      textTheme: textTheme,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
