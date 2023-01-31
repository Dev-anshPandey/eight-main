import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class OrderScreen extends StatelessWidget {
  const OrderScreen  ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_dyiqnus5.json',
            height: MediaQuery.of(context).size.height*0.3,
            ),
          ),
          Text("Your order is on the way",style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.023 ),)
        ],
      ),
    );
  }
}