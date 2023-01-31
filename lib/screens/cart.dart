//https://assets4.lottiefiles.com/temp/lf20_W5bxHx.json

import 'package:eight/provider/cart_provider.dart';
import 'package:eight/widget/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
   
    return  SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          body: Consumer<CartProvider>(
            builder: ((context, value, child) {
              return value.cartItems.length==0 ?
              Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 58.0, bottom: 20),
            child: Center(
              child: Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_ry4iluja.json',
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
          ),
          Text(
            "Your cart is empty",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.023),
          )
        ],
      )
              :Column(
                children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0,top:8,bottom: 4),
                  child: Row(
                    children: [
                      Text("Total Items : ",
              style: GoogleFonts.lato(
                      fontSize: MediaQuery.of(context).size.height * 0.023,
              )),
              Text(value.cartItems.length.toString(),style: GoogleFonts.lato(
                      fontSize: MediaQuery.of(context).size.height * 0.023,
              ))
                    ],
                  ),
                ),
                
                  SizedBox(
                     height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: value.cartItems.length,
                        itemBuilder: (context, index) {
                          print(value.cartItems[index]);
                          print("Krishna");
                          return value.cartItems[index];
                        }),
                  ),
                ],
              );
            }),
          ),
        ),
      );
  }
}
//  return cart.length==0? Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 58.0, bottom: 20),
//             child: Center(
//               child: Lottie.network(
//                 'https://assets5.lottiefiles.com/packages/lf20_ry4iluja.json',
//                 height: MediaQuery.of(context).size.height * 0.25,
//               ),
//             ),
//           ),
//           Text(
//             "Your cart is empty",
//             style:
//                 TextStyle(fontSize: MediaQuery.of(context).size.height * 0.023),
//           )
//         ],
//       ):Text("Item")
//     ;