import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airplane/cubit/transaction_cubit/transaction_cubit.dart';
import 'package:flutter_airplane/theme/theme.dart';
import 'package:flutter_airplane/ui/widgets/transaction_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransactions(user?.email ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionSuccess) {
          if (state.transactions.length == 0) {
            return Center(
              child: Text(
                'You don\'t have a transaction',
                style: greenTextStyle.copyWith(fontSize: 14),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: state.transactions.length,
                padding: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin, top:defaultMargin, bottom: 80
                ),
                itemBuilder: (context, index) {
                  return TransactionCard(
                    state.transactions[index],
                  );
                }
            );
          }
        }

        return Center(
          child: Text('Transaction Page'),
        );
      },
    );
  }
}
