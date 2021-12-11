import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_airplane/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_airplane/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void createTransaction(TransactionModel transaction, User? user) async {  
    try {
      emit(TransactionLoading());
      await TransactionService().createTransaction(transaction, user);
      emit(TransactionSuccess([]));

    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void fetchTransactions(String? email) async {
    try {
      emit(TransactionLoading());

      List<TransactionModel> transactions =
          await TransactionService().fetchTransactions(email);

      emit(TransactionSuccess(transactions));
      
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
