import 'package:flutter/material.dart';
import 'package:flutter_airplane/models/transaction_model.dart';
import 'package:flutter_airplane/theme/theme.dart';
import 'package:intl/intl.dart';

import 'booking_details_item.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: kWhiteColor,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(0),
          title: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(transaction.destination.imageUrl),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.destination.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      transaction.destination.city,
                      style: greyTextStyle.copyWith(
                        fontWeight: light,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOTE: BOOKING DETAILS TEXT
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Booking Details',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),

                // NOTE: BOOKING DETAILS ITEMS
                BookingDetailsItem(
                  title: 'Traveler',
                  valueText: '${transaction.amountOfTraveler} person',
                  valueColor: kBlackColor,
                ),
                BookingDetailsItem(
                  title: 'Seat',
                  valueText: transaction.selectedSeats,
                  valueColor: kBlackColor,
                ),
                BookingDetailsItem(
                  title: 'Insurance',
                  valueText: transaction.insurance ? 'YES' : 'NO',
                  valueColor: transaction.insurance ? kGreenColor : kRedColor,
                ),
                BookingDetailsItem(
                  title: 'Refundable',
                  valueText: transaction.refundable ? 'YES' : 'NO',
                  valueColor: transaction.refundable ? kGreenColor : kRedColor,
                ),

                BookingDetailsItem(
                  title: 'VAT',
                  valueText: '${(transaction.vat * 100).toStringAsFixed(0)}%',
                  valueColor: kBlackColor,
                ),

                BookingDetailsItem(
                  title: 'Price',
                  valueText: NumberFormat.currency(
                    locale: 'id',
                    symbol: 'IDR ',
                    decimalDigits: 0,
                  ).format(transaction.price),
                  valueColor: kBlackColor,
                ),

                BookingDetailsItem(
                  title: 'Grand Total',
                  valueText: NumberFormat.currency(
                    locale: 'id',
                    symbol: 'IDR ',
                    decimalDigits: 0,
                  ).format(transaction.grandTotal),
                  valueColor: kPrimaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
