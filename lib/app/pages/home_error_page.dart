import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class HomeErrorPage extends StatelessWidget {
  const HomeErrorPage({super.key, required this.onRefresh});
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Data User Tidak Berhasil Diload Silahkan Refresh Kembali atau Tekan Tombol Refresh Dibawah ini",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  onPressed: onRefresh,
                  height: 41,
                  width: 150,
                  textTheme: textTheme,
                  child: Text(
                    "Refresh",
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
