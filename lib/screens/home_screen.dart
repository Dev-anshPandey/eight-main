import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eight/provider/bottom_provier.dart';
import 'package:eight/provider/cart_provider.dart';
import 'package:eight/provider/categ_provider.dart';
import 'package:eight/screens/cart.dart';
import 'package:eight/screens/map.dart';
import 'package:eight/screens/order_status.dart';
import 'package:eight/widget/cart_widget.dart';
import 'package:eight/widget/sidebar.dart';
import 'package:eight/widget/wlocation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

int id = 0;
int cartid = 0;
List section = [
  Section(
    name: "Bakery",
    image: const NetworkImage(
        "https://i.ndtvimg.com/i/2017-10/bakeries_620x350_41509023137.jpg"),
  ),
  Section(
    name: "Sweets",
    image: const NetworkImage(
        "https://www.rajbhog.com/wp-content/uploads/2021/03/10-Must-Try-Rajbhog-Sweets-870x635.jpg"),
  ),
  Section(
    name: "Vegetables",
    image: const NetworkImage(
        "https://cdn.mos.cms.futurecdn.net/XM8scaSf7gWsiN9jjowikf.jpg"),
  ),
  Section(
    name: "Fruits",
    image: const NetworkImage(
        "https://img.onmanorama.com/content/dam/mm/en/food/features/images/2022/1/1/food-prevent-sun-tan.jpg"),
  )
];
List trendingList = [
  TrendingCard(
    dishString: "choleBhature2.jpg",
    dishName: "Chole Bhature",
    chiefName: "Mr. Abc Xyz",
    cost: "150",
  ),
  TrendingCard(
    dishString: "pavBhaji.jpg",
    dishName: "Pav Bhaji",
    chiefName: "Mr. Abc Xyz",
    cost: "88  ",
  ),
  TrendingCard(
    dishString: "pizza.jpg",
    dishName: "Pizza",
    chiefName: "Mr. Abc Xyz",
    cost: "199",
  ),
  TrendingCard(
    dishString: "dosa.jpg",
    dishName: "Dosa",
    chiefName: "Mr. Abc Xyz",
    cost: "199",
  ),
  TrendingCard(
    dishString: "Idli.jpg",
    dishName: "Idli Sambhar",
    chiefName: "Mr. Abc Xyz",
    cost: "151",
  ),
];
List burger = [
  TrendingCard(
    dishString: "pavBhaji.jpg",
    dishName: "Pav Bhaji",
    chiefName: "Mr. Abc Xyz",
    cost: "88  ",
  ),
  TrendingCard(
    dishString: "choleBhature2.jpg",
    dishName: "Chole Bhature",
    chiefName: "Mr. Abc Xyz",
    cost: "99",
  ),
  TrendingCard(
    dishString: "choleBhature2.jpg",
    dishName: "Chole Bhature",
    chiefName: "Mr. Abc Xyz",
    cost: "99",
  ),
  TrendingCard(
    dishString: "choleBhature2.jpg",
    dishName: "Chole Bhature",
    chiefName: "Mr. Abc Xyz",
    cost: "99",
  ),
];
List catgList = [
  trendingList,
  burger,
  trendingList,
  burger,
  trendingList,
  burger
];
List<Widget> displayScreen = [Cart(), HomeWidget(), OrderStatus()];
List _foundUsers = [];

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}

LocationMap usrloc = LocationMap();

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

String topDisplayAddress = "";
String bottomDisplayAddress = "";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _foundUsers = section;
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = section;
    } else {
      results = section
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomProvider>(
          create: ((context) => BottomProvider()),
        ),
        ChangeNotifierProvider<CartProvider>(
            create: ((context) => CartProvider()))
      ],
      child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xff8BDF85),
              child: Icon(
                Icons.search_rounded,
                size: 30,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (Builder) {
                      return FractionallySizedBox(
                        heightFactor: 0.65,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.height * 0.03,
                                  right:
                                      MediaQuery.of(context).size.height * 0.03,
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              child: TextField(
                                onChanged: (value) {
                                  _runFilter(value);
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  labelText: "Search...",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 23.0, left: 5),
                                    child: Icon(Icons.search,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        color: Colors.black),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 10, bottom: 4, left: 4, right: 0),
                                  // prefixIconConstraints: BoxConstraints(minWidth: 40,maxHeight: 45)
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: _foundUsers.length,
                                  itemBuilder: ((context, index) {
                                    return _foundUsers[index];
                                  })),
                            ),
                            // Row(
                            //   children: [
                            //     Section(
                            //       name: "Beverages",
                            //       image: NetworkImage(
                            //           "https://www.bevindustry.com/ext/resources/issues/2019/June/The-Color-Psychology-Behind-Beverage-Ingredients-Beverage-Industry.jpg?1560462971"),
                            //     ),
                            //     Section(
                            //         name: "Snacks",
                            //         image: NetworkImage(
                            //             "https://www.vegrecipesofindia.com/wp-content/uploads/2019/03/chana-chaat-recipe-1-480x270.jpg")),
                            //     Section(
                            //       name: "Chinese",
                            //       image: NetworkImage(
                            //           "https://ichef.bbci.co.uk/news/976/cpsprodpb/11ADE/production/_110541427_chinesefood.jpg"),
                            //     ),
                            //     Section(
                            //       name: "Italian",
                            //       image: NetworkImage(
                            //           "http://cdn.cnn.com/cnnnext/dam/assets/210211140150-02-classic-italian-dishes.jpg"),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      );
                    });
              }),
          appBar: AppBar(
            elevation: 0.4,
            iconTheme: const IconThemeData(color: Color(0xff8BDF85)),
            backgroundColor: Colors.white,
            title: RotationTransition(
              turns: const AlwaysStoppedAnimation(40 / 360),
              child: Text(
                "8",
                style: TextStyle(
                    color: const Color(0xff8BDF85),
                    fontSize: MediaQuery.of(context).size.height * 0.06),
              ),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.013),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  child: Icon(Icons.location_on,
                      size: MediaQuery.of(context).size.height * 0.04),
                ),
              ),
              Container(
                child: Text(topDisplayAddress),
              )
            ],
          ),
          drawer: const SideBar(),
          body: Consumer<BottomProvider>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: displayScreen[value.bottomNo]);
            },
          ),
          bottomNavigationBar: bottomNavigation()),
    );
  }
}
// Padding(
//         padding: EdgeInsets.symmetric(horizontal:18.0),

//         child: GNav(

//           activeColor:Colors.white,
//          tabBackgroundColor: Color(0xff8BDF85),
//          padding: EdgeInsets.all(10),

//           tabs: [
//              GButton(icon: Icons.shopping_cart , text: "  Cart",),
//             GButton(icon: Icons.home , text: "  Home",),
//             GButton(icon: Icons.compare_arrows, text: "  Track Order",)
//           ],
//         ),
//       )

//  Container(

//           child: NavigationBarTheme(
//             data: NavigationBarThemeData(
//               indicatorColor:  Color(0xff8BDF85),
//               labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 0))

//             ),
//             child: NavigationBar(
//               height: 50,
//               selectedIndex: 0,
//               destinations: const [
//                 NavigationDestination(
//                     icon: Icon(
//                       Icons.shopping_cart,
//                       color: Colors.white,
//                     ),
//                     label: "")
//                     ,NavigationDestination(
//                     icon: Icon(
//                       Icons.home,
//                     ),
//                     label: ""),NavigationDestination(
//                     icon: Icon(
//                       Icons.search,
//                     ),
//                     label: "")
//               ],
//             ),
//           ),
//         ));

class bottomNavigation extends StatefulWidget {
  int index = 1;
  @override
  State<bottomNavigation> createState() => _bottomNavigationState();
}

class _bottomNavigationState extends State<bottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomProvider>(
      builder: ((context, value, child) {
        final bno = Provider.of<BottomProvider>(context, listen: false);
        return BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (state) {
              bno.setBottomNo(state);
            },
            selectedFontSize: 3,
            unselectedFontSize: 3,
            currentIndex: value.bottomNo,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 25,
                ),
                activeIcon: CircleAvatar(
                  child:
                      Icon(Icons.shopping_cart, color: Colors.white, size: 25),
                  backgroundColor: Color(0xff8BDF85),
                  maxRadius: 25,
                ),
                label: "",
                backgroundColor: Color(0xff8BDF85),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.black, size: 25),
                  activeIcon: CircleAvatar(
                    child: Icon(Icons.home, color: Colors.white, size: 25),
                    backgroundColor: Color(0xff8BDF85),
                    maxRadius: 25,
                  ),
                  label: "",
                  backgroundColor: Color(0xff8BDF85)),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.compare_arrows,
                    color: Colors.black,
                    size: 25,
                  ),
                  activeIcon: CircleAvatar(
                    child: Icon(Icons.compare_arrows,
                        color: Colors.white, size: 25),
                    backgroundColor: Color(0xff8BDF85),
                    maxRadius: 25,
                  ),
                  label: "",
                  backgroundColor: Color(0xff8BDF85)),
            ]);
      }),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.height * 0.02),
          child: Text("Categories :",
              style: GoogleFonts.lato(
                fontSize: MediaQuery.of(context).size.height * 0.025,
              )),
        ),
        ChangeNotifierProvider<CatgProvider>(
            create: (context) => CatgProvider(), child: MenuCard()),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.height * 0.02),
          child: Text("Recommended :",
              style: GoogleFonts.lato(
                fontSize: MediaQuery.of(context).size.height * 0.025,
              )),
        ),
        RecWidget(
            Price: "150",
            dishName: "Chowmin",
            url:
                "https://myfoodstory.com/wp-content/uploads/2021/07/Easy-Chicken-Chow-Mein-3-500x500.jpg"),
        RecWidget(
          Price: "100",
          dishName: "French Fires",
          url:
              "https://www.mcdonalds.com/content/dam/usa/nfl/nutrition/items/regular/desktop/t-mcdonalds-Fries-Small-Medium.jpg",
        ),
        RecWidget(
          Price: "75",
          dishName: "Burger",
          url:
              "https://www.chicken.ca/wp-content/uploads/2013/05/Moist-Chicken-Burgers-1180x580.jpg",
        )
      ],
    );
  }
}

class RecWidget extends StatelessWidget {
  String? dishName;
  String? Price;
  String? url;
  RecWidget({this.dishName, this.Price, this.url});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.height * 0.016,
                right: MediaQuery.of(context).size.height * 0.01),
            height: 190,
            width: double.infinity,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.19),
                child: Row(
                  children: [
                    Container(
                        height: 190,
                        width: 0.3,
                        color: Color.fromARGB(255, 202, 197, 197)),
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Row(
                                children: [
                                  Text(dishName!,
                                      style: GoogleFonts.lato(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.020,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text("4.8 (18) ",
                                        style: GoogleFonts.lato(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018,
                                        )),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    // SizedBox(width: 20,)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "10 min ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "+ ",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Icon(
                                    Icons.delivery_dining_outlined,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.currency_rupee_sharp,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    Text(Price!,
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018,
                                        )),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(0xff8BDF85),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 50),
                              child: GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      msg: "Added to Cart");
                                },
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 30,
            child: CircleAvatar(
              radius: 67,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 65,
                backgroundImage: NetworkImage(url!),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  String? name;
  NetworkImage? image;
  Section({this.name, this.image});
  getSection() {
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.height * 0.027),
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: MediaQuery.of(context).size.height * 0.04,
            backgroundImage: image,
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.height * 0.0),
              child: Text(name!,
                  style: GoogleFonts.lato(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                  )))
        ],
      ),
    );
  }
}

class TrendingCard extends StatelessWidget {
  String? dishString;
  String? dishName;
  String? chiefName = "Mr. Abc Xyz";
  String? cost = "150";

  TrendingCard({this.dishString, this.dishName, this.chiefName, this.cost});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.height * 0.014),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.31,
        width: MediaQuery.of(context).size.width * 0.525,
        child: Card(
          child: Column(children: [
            Builder(builder: (context) {
              return FutureBuilder(
                future: getImage(context, dishString!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(0.1),
                      child: Container(
                          height: 170,
                          width: 400,
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
            // Image(
            //     fit: BoxFit.cover,
            //     height: MediaQuery.of(context).size.height * 0.2,
            //     width: MediaQuery.of(context).size.width * 0.5,
            //     image: dishImage!),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 0),
                  child: Text(dishName!,
                      style: GoogleFonts.lato(
                        fontSize: MediaQuery.of(context).size.height * 0.019,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    height: 20,
                    width: 20,
                    image: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3461/3461974.png")),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(chiefName!,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    children: [
                      Text("4.8",
                          style: GoogleFonts.lato(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.016,
                              fontWeight: FontWeight.bold)),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Rs.",
                        style: GoogleFonts.lato(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            color: Color(0xff8BDF85),
                            fontWeight: FontWeight.bold)),
                    Text(cost!,
                        style: GoogleFonts.lato(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold)),
                  ],
                ),

                // SizedBox(
                //   width: MediaQuery.of(context).size.width*0.3,

                // ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      cart.addCI(CartItem(
                        url: dishString,
                        dishName: dishName,
                        id: cartid++,
                      ));

                      Fluttertoast.showToast(
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          msg: "Added to Cart");
                    },
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class MenuCard extends StatefulWidget {
  const MenuCard({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    final catg = Provider.of<CatgProvider>(context, listen: false);
    return Consumer<CatgProvider>(
      builder: ((context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.008),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        catg.setCatgIndex(0);
                      },
                      child: Container(
                        child: value.catgIndex == 0
                            ? DisplayType(
                                type: "Top sells",
                                image: AssetImage("assets/trending.jpg"),
                                color: Color(0xff8BDF85),
                                border: Colors.black,
                                scolor: Colors.white,
                              )
                            : DisplayType(
                                type: "Top sells",
                                color: Colors.white,
                                border: Colors.white,
                                scolor: Colors.black,
                                image: AssetImage("assets/trending.jpg"),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        catg.setCatgIndex(1);
                      },
                      child: Container(
                        child: value.catgIndex == 1
                            ? DisplayType(
                                type: "Burger",
                                image: AssetImage("assets/burger.jpg"),
                                color: Color(0xff8BDF85),
                                border: Colors.black,
                                scolor: Colors.white,
                              )
                            : DisplayType(
                                type: "Burger", //Color(0xffF6F6F6),
                                color: Colors.white,
                                border: Colors.white,
                                scolor: Colors.black,
                                image: AssetImage("assets/burger.jpg"),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        catg.setCatgIndex(2);
                      },
                      child: Container(
                        child: value.catgIndex == 2
                            ? DisplayType(
                                type: "Pizza",
                                image: AssetImage("assets/pizza.jpg"),
                                color: Color(0xff8BDF85),
                                border: Colors.black,
                                scolor: Colors.white,
                              )
                            : DisplayType(
                                type: "Pizza", //Color(0xffF6F6F6),
                                color: Colors.white,
                                border: Colors.white,
                                scolor: Colors.black,
                                image: AssetImage("assets/pizza.jpg"),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        catg.setCatgIndex(3);
                      },
                      child: Container(
                        child: value.catgIndex == 3
                            ? DisplayType(
                                type: "Sandwhich",
                                color: Color(0xff8BDF85),
                                border: Colors.black,
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/f/ff/Egg_Sandwich.jpg"))
                            : DisplayType(
                                type: "Sandwhich",
                                color: Colors.white,
                                border: Colors.white,
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/f/ff/Egg_Sandwich.jpg")),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        catg.setCatgIndex(4);
                      },
                      child: Container(
                        child: value.catgIndex == 4
                            ? DisplayType(
                                type: "Chinese",
                                color: Color(0xff8BDF85),
                                border: Colors.black,
                              )
                            : DisplayType(
                                type: "Chinese",
                                color: Colors.white,
                                border: Colors.white,
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        catg.setCatgIndex(5);
                      },
                      child: Container(
                        child: value.catgIndex == 5
                            ? DisplayType(
                                type: "South Indian",
                                color: Color(0xff8BDF85),
                                border: Colors.black,
                              )
                            : DisplayType(
                                type: "South Indian",
                                color: Colors.white,
                                border: Colors.white,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/foodscreen');
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.34,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: catgList[value.catgIndex].length,
                          itemBuilder: ((context, index) {
                            for (int i = index;
                                i < catgList[value.catgIndex].length;
                                i++) {
                              return catgList[value.catgIndex][i];
                            }
                            return Container();
                          })),
                    ))
              ]),
            )
          ],
        );
      }),
    );
  }
}

class DisplayType extends StatelessWidget {
  ImageProvider<Object>? image;
  String? type;
  Color? color;
  Color? border;
  Color? scolor;
  DisplayType({this.type, this.color, this.border, this.scolor, this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 20),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(13))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image,
                maxRadius: 10,
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                type!,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13, color: scolor),
              ),
            )),
          ],
        ),
        color: color,
      ),
    );
  }
}
