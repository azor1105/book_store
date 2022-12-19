import 'package:book_store/cubits/connectivity/connectivity_cubit.dart';
import 'package:book_store/presentation/utils/my_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadedBooksScreen extends StatelessWidget {
  const DownloadedBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      buildWhen: (previous, current) {
        return previous.connectivityResult != current.connectivityResult;
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async =>
              state.connectivityResult == ConnectivityResult.none,
          child: const Scaffold(
            backgroundColor: MyColors.white,
          ),
        );
      },
    );
  }
}
