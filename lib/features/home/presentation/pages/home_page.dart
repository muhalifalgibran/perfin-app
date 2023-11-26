import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:perfin_app/features/home/presentation/cubits/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.showInfo('retriving data');
          } else if (state.isSuccess) {
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.isSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // header
                      Text('Hi ${state.userData?.email}'),
                    ],
                  ),
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
