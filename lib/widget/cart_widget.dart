import 'package:eight/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../screens/home_screen.dart';

class CartItem extends StatefulWidget {
  String? url;
  String? dishName;
  int? id;
  CartItem({this.url, this.dishName, this.id});

  @override
  State<CartItem> createState() => _CartItemState();
}

getImage(BuildContext context, String ImageName) async {
  Image? image;
  await FireStorageService.loadImage(context, ImageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.cover,
    );
  });
  return image;
}

class _CartItemState extends State<CartItem> {
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  Razorpay? _razorpay;
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openPaymentPortal() async {
    var options = {
      'key': 'rzp_test_YjOu38M2dxdNJ5',
      'amount': 15000,
      'name': 'eight',
      'description': 'Payment',
      'prefill': {'contact': '9999999999', 'email': 'jhon@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Stack(children: [
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.035,
            left: MediaQuery.of(context).size.width * 0.005,
            right: MediaQuery.of(context).size.width * 0.035),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.008,
                      bottom: MediaQuery.of(context).size.height * 0.008,
                      left: MediaQuery.of(context).size.width * 0.008,
                      right: MediaQuery.of(context).size.width * 0.008),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.07,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height * 0.065,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.065),
                        child: Builder(builder: (context) {
                          return FutureBuilder(
                            future: getImage(context, widget.url!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Padding(
                                  padding: const EdgeInsets.all(0.1),
                                  child: Container(
                                      height: 170,
                                      width: 400,
                                      child: snapshot.data as Widget,
                                      color: Colors.grey[300]),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[200]!,
                                    child: Container(
                                        color: Colors.grey[300],
                                        width: 400,
                                        height: 170,
                                        child: Container(
                                          height: 250,
                                          width: double.infinity,
                                          color: Colors.grey[300],
                                        )));
                                // ),
                              }
                              return Container();
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.001,
                    color: Color.fromARGB(255, 202, 197, 197)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                                left:
                                    MediaQuery.of(context).size.width * 0.008),
                            child: widget.dishName!.length >= 10
                                ? Row(
                                    children: [
                                      Text(widget.dishName!.substring(0, 7),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                          )),
                                      Text("...",
                                          style: GoogleFonts.lato(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.023,
                                          ))
                                    ],
                                  )
                                : Text(widget.dishName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.023,
                                    ))),
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.07,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.029,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.009)),
                                      color: Color(0xff8BDF85)),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height *
                                            0.003),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("1",
                                    style: GoogleFonts.lato(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.009)),
                                      color: Color(0xff8BDF85)),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height *
                                            0.003),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.616,
                      child: ElevatedButton(
                        onPressed: () {
                          openPaymentPortal();
                           Navigator.pushNamed(context, '/orderscreen');
                        },
                        child: Text("₹ 150    (1)      |     NEXT",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                            )),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff8BDF85),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.019,
            left: MediaQuery.of(context).size.width * 0.9),
        child: GestureDetector(
          onTap: () {
            print("cart id is :$id");

            cart.deleteCI(widget.id!);
          },
          child: const CircleAvatar(
            backgroundColor: Color(0xff8BDF85),
            radius: 18,
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    ]);
  }
}
