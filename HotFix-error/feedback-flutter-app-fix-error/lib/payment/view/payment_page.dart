import 'package:feedback24_app/payment/data/repository/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/payment_bloc.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({Key? key}) : super(key: key);
  final PaymentRepository paymentRepository = new PaymentRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (context) => PaymentBloc(
        paymentRepository: paymentRepository,
      )..add(PaymentFetchEvent()),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
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
            return ListView(children: <Widget>[
              Column(
                children: [
                  buildPaymentItem(
                    title: 'Бик: ',
                    body: state.payment.bik.toString(),
                  ),
                  buildPaymentItem(
                    title: 'Рассчетный счет: ',
                    body: state.payment.currentAccount.toString(),
                  ),
                ],
              )
            ]);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildPaymentItem({
    required String title,
    required String body,
  }) =>
      Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              body,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
                width: 350,
                height: 28,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  )),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ]))
          ]));
}
