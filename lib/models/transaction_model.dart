import 'package:flutter_airplane/models/destination_model.dart';
import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final String userEmail;
  final DestinationModel destination;
  final int amountOfTraveler;
  final String selectedSeats;
  final bool insurance;
  final bool refundable;
  final double vat;
  final int price;
  final int grandTotal;
  final DateTime createdAt;

  TransactionModel({
    this.id = '',
    this.userEmail = '',
    required this.destination,
    this.amountOfTraveler = 0,
    this.selectedSeats = '',
    this.insurance = false,
    this.refundable = false,
    this.vat = 0,
    this.price = 0,
    this.grandTotal = 0,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      TransactionModel(
        id: id,
        userEmail: json['userEmail'],
        destination: DestinationModel.fromJson(
            json['destination']['id'], json['destination']),
        amountOfTraveler: json['amountOfTraveler'],
        selectedSeats: json['selectedSeats'],
        insurance: json['insurance'],
        refundable: json['refundable'],
        vat: json['vat'],
        price: json['price'],
        grandTotal: json['grandTotal'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  @override
  List<Object?> get props => [
        destination,
        userEmail,
        amountOfTraveler,
        selectedSeats,
        insurance,
        refundable,
        vat,
        price,
        grandTotal,
        createdAt,
      ];
}
