import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../payment/bloc/payment_bloc.dart';
import '../../payment/data/repository/payment_repository.dart';

class EditPaymentPage extends StatefulWidget {
  const EditPaymentPage({Key? key}) : super(key: key);
  @override
  _EditPaymentPageState createState() => _EditPaymentPageState();
}

final PaymentRepository paymentRepository = new PaymentRepository();

class _EditPaymentPageState extends State<EditPaymentPage> {
  final _form2Key = GlobalKey<FormState>();
  final bik = TextEditingController();
  final currentaccount = TextEditingController();
  @override
  void dispose() {
    bik.dispose();
    currentaccount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
        create: (context) => PaymentBloc(
              paymentRepository: paymentRepository,
            )..add(PaymentFetchEvent()),
        child:
            BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
          if (state is PaymentLoading) {
            return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is PaymentError) {
            return Center(child: Text(state.message));
          }
          if (state is PaymentLoaded) {
            return Scaffold(
                body: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(top: 18, right: 12, left: 12),
                    child: Form(
                        key: _form2Key,
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 12, right: 12),
                                    child: TextFormField(
                                      maxLength: 9,
                                      keyboardType: TextInputType.phone,
                                      controller: bik,
                                      decoration: InputDecoration(
                                        hintText: "Бик",
                                        labelText: state.payment.bik,
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (val) => val!.length < 9
                                          ? 'Введите корректный бик'
                                          : null,
                                    )),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Container(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 12, right: 12),
                                    child: TextFormField(
                                      maxLength: 20,
                                      keyboardType: TextInputType.phone,
                                      controller: currentaccount,
                                      decoration: InputDecoration(
                                        hintText: "Расчетный счет",
                                        labelText: state.payment.currentAccount,
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (val) => val!.length < 20
                                          ? 'Введите корректный расчетный счет'
                                          : null,
                                    )),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.65,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      _editPayment(context);
                                                    },
                                                    child:
                                                        const Text("Сохранить"),
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ))),
                                                  ))),
                                          const SizedBox(
                                            width: 25.0,
                                          ),
                                          Container(
                                              child: OutlinedButton(
                                            onPressed: () {
                                              context.goNamed('exit');
                                            },
                                            child: const Text("Назад"),
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ))),
                                          )),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                        ])
                                  ]))
                            ]))));
          }
          return Container();
        }));
  }

  void _editPayment(context) {
    if (_form2Key.currentState!.validate()) {
      BlocProvider.of<PaymentBloc>(context).add(
        EditPaymentFetchEvent(
          bik.text,
          currentaccount.text,
        ),
      );
      print(_editPayment);
    }
  }
}
