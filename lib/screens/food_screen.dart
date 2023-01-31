import 'package:eight/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodScreen extends StatelessWidget {
  FoodDetail foodDetail = FoodDetail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.height * 0.009)),
                        color: Color(0xff8BDF85)),
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0, top: 40),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          MediaQuery.of(context).size.height * 0.009)),
                      color: Color(0xff8BDF85)),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.height * 0.01),
            child: Builder(builder: (context) {
              return FutureBuilder(
                future: getImage(context, "choleBhature2.jpg"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(0.1),
                      child: Container(
                          height: 250,
                          width: double.infinity,
                          child: snapshot.data as Widget,
                          color: Colors.grey[300]),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                            color: Colors.grey[300],
                            width: double.infinity,
                            height: 250,
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
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 8, left: 8),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: foodDetail.foodTitle(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final food = snapshot.data.toString();
                        return Text(food!,
                            style: GoogleFonts.lato(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.bold));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[200]!,
                            child: Container(
                                color: Colors.grey[300],
                                width: 150,
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.025,
                                  width: 150,
                                  color: Colors.grey[300],
                                )));
                      }
                      return Container();
                    }),
                // Text("Chole  Bhature ",
                //     style: GoogleFonts.lato(
                //         fontSize: MediaQuery.of(context).size.height * 0.025,
                //         fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Image(
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.02,
                    width: MediaQuery.of(context).size.width * 0.05,
                    image: const NetworkImage(
                        "https://m.media-amazon.com/images/I/31LIK7w2iTL._SX355_.jpg"),
                  ),
                ),
                //                Row(
                //   children: [
                //     Text("4.8  ",
                //         style: GoogleFonts.lato(
                //             fontSize:
                //                 MediaQuery.of(context).size.height * 0.025,
                //             fontWeight: FontWeight.bold)),
                //     const Icon(
                //       Icons.star,
                //       color: Colors.yellow,
                //       size: 30,
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, bottom: 20),
            child: Row(
              children: const [
                Icon(Icons.star, color: Colors.yellow, size: 25),
                Icon(Icons.star, color: Colors.yellow, size: 25),
                Icon(Icons.star, color: Colors.yellow, size: 25),
                Icon(Icons.star, color: Colors.yellow, size: 25),
                Icon(Icons.star_half, color: Colors.yellow, size: 25)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 8, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.currency_rupee_sharp,
                      color: Color(0xff8BDF85),
                      size: 25,
                    ),
                    FutureBuilder(
                        future: foodDetail.foodPrice(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final food = snapshot.data.toString();
                            return Text(food!,
                                style: GoogleFonts.lato(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.035,
                                    fontWeight: FontWeight.bold));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[200]!,
                                child: Container(
                                    color: Colors.grey[300],
                                    width: 50,
                                    height: MediaQuery.of(context).size.height *
                                        0.035,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.035,
                                      width: 50,
                                      color: Colors.grey[300],
                                    )));
                          }
                          return Container();
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 22.0, top: 0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context).size.height * 0.009)),
                            color: Color(0xff8BDF85)),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.003),
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
                                MediaQuery.of(context).size.height * 0.015,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery.of(context).size.height * 0.009)),
                            color: Color(0xff8BDF85)),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.003),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.015,
                top: MediaQuery.of(context).size.height * 0.015),
            child: Text("Ingredients - ",
                style: GoogleFonts.lato(
                    fontSize: MediaQuery.of(context).size.height * 0.020,
                    color: Colors.grey)),
          ),
          FutureBuilder(
              future: foodDetail.Ingredients(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String ingredients = snapshot.data
                      .toString()
                      .replaceAll('[', "")
                      .replaceAll(']', "");
                  List Ingredients = ingredients.split(',');
                  return Container(
                    height: 170,
                    width: double.infinity,
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        scrollDirection: Axis.vertical,
                        itemCount: Ingredients.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              // top: MediaQuery.of(context).size.height * 0.008),
                            ),
                            child: Row(
                              children: [
                                index == 0
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text("• ",
                                            style: GoogleFonts.lato(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.017,
                                                color: Colors.grey)),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Text("•",
                                            style: GoogleFonts.lato(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.017,
                                                color: Colors.grey)),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(Ingredients[index],
                                      style: GoogleFonts.lato(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.017,
                                          color: Colors.grey)),
                                ),
                              ],
                            ),
                          );
                        })),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[200]!,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: 10,
                                  top: 10),
                              color: Colors.grey[300],
                              width: 60,
                              height:
                                  MediaQuery.of(context).size.height * 0.017,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                                width: 60,
                                color: Colors.grey[300],
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: 10),
                              color: Colors.grey[300],
                              width: 60,
                              height:
                                  MediaQuery.of(context).size.height * 0.017,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                                width: 60,
                                color: Colors.grey[300],
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: 10),
                              color: Colors.grey[300],
                              width: 60,
                              height:
                                  MediaQuery.of(context).size.height * 0.017,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                                width: 60,
                                color: Colors.grey[300],
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: 10),
                              color: Colors.grey[300],
                              width: 60,
                              height:
                                  MediaQuery.of(context).size.height * 0.017,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                                width: 60,
                                color: Colors.grey[300],
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: 10),
                              color: Colors.grey[300],
                              width: 60,
                              height:
                                  MediaQuery.of(context).size.height * 0.017,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                                width: 60,
                                color: Colors.grey[300],
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              color: Colors.grey[300],
                              width: 60,
                              height:
                                  MediaQuery.of(context).size.height * 0.017,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                                width: 60,
                                color: Colors.grey[300],
                              )),
                        ],
                      ));
                }
                return Container();
              }),
          
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.height * 0.04,
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    height: 25,
                    width: 25,
                    image: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3461/3461974.png")),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                FutureBuilder(
                    future: foodDetail.ChiefName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final food = snapshot.data.toString();
                        return Text(food!,
                            style: GoogleFonts.lato(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                            ));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[200]!,
                            child: Container(
                                color: Colors.grey[300],
                                width: 120,
                                height:
                                    MediaQuery.of(context).size.height * 0.018,
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.018,
                                  width: 120,
                                  color: Colors.grey[300],
                                )));
                      }
                      return Container();
                    }),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("₹ 150    |     ADD TO CART",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.018,
                    )),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xff8BDF85),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FoodDetail {
  foodTitle() async {
    final foods =
        FirebaseFirestore.instance.collection('foods').doc("CholeBhature");
    final snapshot = await foods.get();
    if (snapshot.exists) {
      return snapshot.data()!['title'];
    }
  }

  foodPrice() async {
    final foods =
        FirebaseFirestore.instance.collection('foods').doc("CholeBhature");
    final snapshot = await foods.get();
    if (snapshot.exists) {
      return snapshot.data()!['cost'];
    }
  }

  ChiefName() async {
    final foods =
        FirebaseFirestore.instance.collection('foods').doc("CholeBhature");
    final snapshot = await foods.get();
    if (snapshot.exists) {
      return snapshot.data()!['chief'];
    }
  }

  Ingredients() async {
    final foods =
        FirebaseFirestore.instance.collection('foods').doc("CholeBhature");
    final snapshot = await foods.get();
    if (snapshot.exists) {
      return snapshot.data()!['Ingredients'];
    }
  }
}
