import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:perfin_app/features/home/presentation/widgets/list_money_history.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.red.shade200,
            child: const Icon(Icons.remove),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.green.shade200,
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 20),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: getIt<HomeCubit>()..getUserData(),
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.showInfo('retrieving data..');
          } else if (state.isSuccess) {
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.isSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // header
                      Text(
                        'hi, ${state.userData?.email}!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'your total money is \$${state.userData?.totalMoney}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Divider(),
                      const Text(
                        'history',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      if (state.userMoney == [] || state.userMoney!.isEmpty)
                        const Expanded(
                          child: Center(
                            child: Text(
                              'please input your money log',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      else if (state.userMoney!.isNotEmpty)
                        ListMoneyHistory(money: state.userMoney!)
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
