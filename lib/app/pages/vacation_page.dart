import 'dart:io';

import 'package:bkd_presence_bloc/app/blocs/vacation/vacation_bloc.dart';
import 'package:bkd_presence_bloc/app/constants/color_constants.dart';
import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/colon.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_appbar.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_button.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_snackbar.dart';
import 'package:bkd_presence_bloc/app/widgets/date_picker.dart';
import 'package:bkd_presence_bloc/app/widgets/expanded_text_field.dart';
import 'package:bkd_presence_bloc/app/widgets/label_button.dart';
import 'package:bkd_presence_bloc/app/widgets/label_text.dart';
import 'package:flutter/material.dart';

class VacationPage extends StatelessWidget {
  const VacationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final DateTime currentTime = arguments['currentTime'];
    final UserModel userModel = arguments['userModel'];
    final startDateC = TextEditingController();
    final endDateC = TextEditingController();
    final reasonC = TextEditingController();
    final textTheme = Themes.light.textTheme;
    final vacationBloc = context.read<VacationBloc>();
    final leaveTypeList = [
      'Cuti Tahunan',
      'Cuti Sakit',
      'Cuti Melahirkan',
      'Cuti Alasan Penting',
      'Cuti Besar',
    ];
    File? file;
    String? selectedLeaveType;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Permintaan Cuti",
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
              Row(
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
                    child: BlocConsumer<VacationBloc, VacationState>(
                      bloc: vacationBloc,
                      listener: (context, state) {
                        if (state is StartDatePicked) {
                          startDateC.text = state.currentTime;
                        } else if (state is StartDateNotPicked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content: Text(state.message),
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
                              vacationBloc.add(StartDatePicker(
                                currentTime: picked,
                              ));
                            } else {
                              vacationBloc.add(
                                StartDateNotPick(),
                              );
                            }
                          },
                          textTheme: textTheme,
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
                    child: BlocConsumer<VacationBloc, VacationState>(
                      bloc: vacationBloc,
                      listener: (context, state) {
                        if (state is EndDatePicked) {
                          endDateC.text = state.currentTime;
                        } else if (state is EndDateNotPicked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content: Text(state.message),
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
                              vacationBloc.add(EndDatePicker(
                                currentTime: picked,
                              ));
                            } else {
                              vacationBloc.add(
                                EndDateNotPick(),
                              );
                            }
                          },
                          textTheme: textTheme,
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
                children: [
                  LabelText(
                    width: 115,
                    label: "Jenis Cuti",
                    textTheme: textTheme,
                  ),
                  ColonWidget(
                    textTheme: textTheme,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      iconSize: 20,
                      items: leaveTypeList.map((e) {
                        return DropdownMenuItem<String>(
                            value: e, child: Text(e));
                      }).toList(),
                      value: selectedLeaveType,
                      onChanged: (value) {
                        selectedLeaveType = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Pilih jenis cuti',
                        hintStyle: textTheme.bodySmall!.copyWith(
                          color: ColorConstants.grey100,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
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
                    label: "Surat Cuti",
                    textTheme: textTheme,
                  ),
                  ColonWidget(
                    textTheme: textTheme,
                  ),
                  Expanded(
                    child: BlocConsumer<VacationBloc, VacationState>(
                      bloc: vacationBloc,
                      listener: (context, state) {
                        if (state is FileNotPicked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content: Text(state.message),
                              backgroundColor: ColorConstants.redColor,
                            ),
                          );
                        } else if (state is FilePicked) {
                          file = state.file;
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          onTap: () {
                            vacationBloc.add(
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
                                        : "Surat Cuti",
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
                height: 16,
              ),
              LabelText(
                width: double.infinity,
                label: "Alasan Ingin Cuti",
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 8,
              ),
              ExpandedTextField(
                controller: reasonC,
                hintText: 'Masukkan Alasan Anda...',
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: BlocConsumer<VacationBloc, VacationState>(
                  bloc: vacationBloc,
                  listener: (context, state) {
                    if (state is SendVacationApiSuccess) {
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
                    } else if (state is SendVacationApiFailed) {
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
                      height: 41,
                      width: 150,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content: const Text("Form Tidak Boleh Kosong"),
                              backgroundColor: ColorConstants.redColor,
                            ),
                          );
                        } else if (file == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar(
                              content:
                                  const Text("Surat Cuti Tidak Boleh Kosong"),
                              backgroundColor: ColorConstants.redColor,
                            ),
                          );
                        } else if (formKey.currentState!.validate() &&
                            file != null) {
                          vacationBloc.add(
                            SendVacation(
                              nip: userModel.data.user.nip,
                              officeId:
                                  userModel.data.user.office.id.toString(),
                              presenceId:
                                  userModel.data.presences!.first.id.toString(),
                              startDate: startDateC.text,
                              endDate: endDateC.text,
                              leaveType: selectedLeaveType!,
                              reason: reasonC.text,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
