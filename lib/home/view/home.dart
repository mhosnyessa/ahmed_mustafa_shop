import 'package:ahmed_mustafa_amazon/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double height = size.height;
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.notifications_outlined),
              Container(
                width: screenWidth * 4 / 5,
                height: 45,
                color: Colors.white,
                
              ),
            ],
          ),
        ],
      ),
      appBar: AppBar(
        leading: Icon(Icons.arrow_drop_down),
        actions: [Icon(Icons.pin_drop)],
        title: Text('Egypt'),
      ),
    );
  }
}
