import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_airplane/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  CollectionReference _transactionReference = 
      FirebaseFirestore.instance.collection('transactions');
  
  Future<void> createTransaction(TransactionModel transaction, User? user) async { 
    try { 
      _transactionReference.add({
        'userEmail': user!.email,
        'destination': transaction.destination.toJson(),
        'amountOfTraveler': transaction.amountOfTraveler,
        'selectedSeats': transaction.selectedSeats,
        'insurance': transaction.insurance,
        'refundable': transaction.refundable,
        'vat': transaction.vat,
        'price': transaction.price,
        'grandTotal': transaction.grandTotal,
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      });
    } catch (e) { 
      throw e;
    }
  }

  Future<List<TransactionModel>> fetchTransactions(String? email) async { 
    try {
      QuerySnapshot result = await _transactionReference
        .where('userEmail', isEqualTo: email)
        .get();

      List<TransactionModel> transactions = result.docs.map(
        (transaction) => TransactionModel.fromJson(
          transaction.id, transaction.data() as Map<String, dynamic>) 
      ).toList();

      transactions.sort(
        (TransactionModel a, TransactionModel b) =>
          b.createdAt.compareTo(a.createdAt),
      );

      return transactions;
    } catch (e) { 
      throw e;
    }
  }
}