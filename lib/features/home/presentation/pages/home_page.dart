import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:perfin_app/app.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';
import 'package:perfin_app/features/home/presentation/cubits/home_cubit.dart';
import 'package:perfin_app/features/home/presentation/cubits/money_cubit.dart';
import 'package:perfin_app/features/home/presentation/widgets/list_money_history.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  late Money _money;
  late num _totalMoney;
  final TextEditingController _moneyCtrl = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoneyCubit, MoneyState>(
      listener: (context, moneyState) {
        if (moneyState.isSuccess) {
          EasyLoading.dismiss();
          Navigator.of(context).pop();
          getIt<HomeCubit>().getUserData();
        } else if (moneyState.isLoading) {
          EasyLoading.show(status: 'processing data..');
        } else if (moneyState.isFailed) {
          EasyLoading.showError(
            'something is wrong..',
            duration: const Duration(milliseconds: 1750),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () {
                  _showDialogSignOut(context);
                },
                child: Icon(Icons.logout)),
            const SizedBox(width: 20)
          ],
        ),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          children: [
            FloatingActionButton(
              heroTag: 'fab1',
              onPressed: () {
                _showDialog(false, context);
              },
              backgroundColor: Colors.red.shade200,
              child: const Icon(Icons.remove),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: 'fab2',
              onPressed: () {
                _showDialog(true, context);
              },
              backgroundColor: Colors.green.shade200,
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: BlocConsumer<HomeCubit, HomeState>(
          bloc: getIt<HomeCubit>()..getUserData(),
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.showInfo('retrieving data..');
            } else if (state.isSuccess) {
              // initiate money
              _money = Money(
                userId: state.userData!.userId,
                totalMoney: state.userData!.totalMoney,
                isRising: false,
                money: num.parse(_moneyCtrl.text),
              );
              _totalMoney = state.userData!.totalMoney;
              EasyLoading.dismiss();
            } else if (state.isSuccessSignout) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const App(),
                ),
              );
            }
          },
          builder: (context, state) {
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.isSuccess) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
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
                          Expanded(
                              child: ListMoneyHistory(money: state.userMoney!))
                      ],
                    ),
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  void _showDialogSignOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('confirm sign out?'),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('dismiss')),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () {
                          getIt<HomeCubit>().signOut();
                        },
                        child: const Text(
                          'signout',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showDialog(bool isRising, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              child: Column(
                // direction: Axis.vertical,
                children: [
                  Text(
                    isRising
                        ? 'how much your money increased?'
                        : 'how much your money decreased?',
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _moneyCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(hintText: 'input money'),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('dismiss')),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () {
                          _money = _money.copyWith(
                            isRising: isRising,
                            money: num.parse(_moneyCtrl.text),
                          );
                          isRising
                              ? _totalMoney += num.parse(_moneyCtrl.text)
                              : _totalMoney -= num.parse(_moneyCtrl.text);
                          getIt<MoneyCubit>().changeMoney(_money, _totalMoney);
                        },
                        child: Text(
                          'ok',
                          style: TextStyle(
                            color: isRising ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
