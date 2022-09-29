import 'package:flutter/material.dart';
/* 
import '../../../../constant/constant.dart';
import '../../../widget/order/cash_on_delivery.dart';
import '../../../widget/order/pre_pay.dart'; */

class UserOrderView extends StatelessWidget {
  const UserOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("အော်ဒါများ",
                style: TextStyle(
                  color: Colors.black,
                ))),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        /* bottom: TabBar(
              unselectedLabelColor: Colors.grey.shade400,
              labelColor: Colors.grey.shade700,
              tabs: [
                Tab(
                  child: Text(
                    "Cash On Deli",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Tab(
                  child: Text(
                    "Pre-Pay",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]), */
      ),
      body:
          Container(), /* TabBarView(
          children: [
            CashOnDelivery(),
            PrePay(),
          ],
        ), */
    );
  }
}
