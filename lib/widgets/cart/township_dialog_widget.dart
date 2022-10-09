import 'package:citymall/controller/cart_controller.dart';
import 'package:citymall/model/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TownshipDialogWidget extends StatelessWidget {
  final Division division;
  const TownshipDialogWidget({
    Key? key,
    required this.division,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController _controller = Get.find();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 400,
        height: MediaQuery.of(Get.context!).size.height,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(),
            bottom: BorderSide(),
            left: BorderSide(),
            right: BorderSide(),
          ),
          color: Colors.white,
        ),
        child: ListView(
          children: division.townShipMap.entries.map((map) {
            return SizedBox(
              height: map.value.length * 50,
              child: ListView.builder(
                  primary: false,
                  itemCount: map.value.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        _controller.setTownShipNameAndShip(
                          name: map.value[index],
                          fee: map.key,
                        );
                        //Pop this dialog
                        Get.back();
                        Get.back();
                      },
                      child: Text(
                        map.value[index],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }),
            );
          }).toList(),
        ),
      ),
    );
  }
}
