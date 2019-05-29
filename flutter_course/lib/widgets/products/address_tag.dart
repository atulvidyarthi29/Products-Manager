import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String address;

  AddressTag(this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(address),
    );
  }
}
