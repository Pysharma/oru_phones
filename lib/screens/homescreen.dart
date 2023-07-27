import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/customappbar.dart';
import 'brandsection.dart';
import 'filter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });

    var url =
        "https://dev2be.oruphones.com/api/v1/global/assignment/getListings?page=2&limit=10";
    var response = await http.get(Uri.parse(url));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var items = data['listings'];
      setState(() {
        users = items;
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black45, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your Subtitle Here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item 2 tap
              },
            ),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuyTopBrandsSection(),
                SizedBox(height: 16,),
                ShopBySection(),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, ),
                        children: [
                          TextSpan(text: "Best Deals Near You",style: TextStyle(
                              color: Colors.black54,
                          )),
                          TextSpan(text: " "),
                          TextSpan(
                            text: "India",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.amber,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showFilterScreen(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sort',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(
                            Icons.compare_arrows,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    child: getBody()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        return getCard(users[index]);
      }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 255
    ),
    );
  }

  Widget getCard(index) {
    var bannerImage = index["defaultImage"]["fullImage"];
    var listingNumPrice = index["listingNumPrice"];
    var deviceCondition = index["deviceCondition"];
    var deviceStorage = index["deviceStorage"];
    var listingLocation= index["listingLocation"];
    var listingDate = index["listingDate"];
    var model = index["model"];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: InkWell(
        onTap: () {
          // on tapping the item in the homescreen
      },
        child: Card(
          child: Stack(
            children: [
              Positioned(
                top: 8,
                right: 1,
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.network(
                      bannerImage.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹$listingNumPrice",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4,),
                        Text(
                          model,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$deviceStorage",
                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Condition: $deviceCondition",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              listingLocation,
                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),
                            ),
                            Text(
                              listingDate,
                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        // Add other widgets as per your UI requirements
                      ],
                    ),
                  ),
                ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showFilterScreen(BuildContext context) async {
    String? selectedOption = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent, // Set the background color of the modal bottom sheet to transparent
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: FilterScreen(),
        );
      },
    );
  }



}
