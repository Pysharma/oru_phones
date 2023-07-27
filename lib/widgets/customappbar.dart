import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/notification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(130);
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<String> availableOptions = [];

  List users = [];

  bool isLoading = false;

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      elevation: 0,
      backgroundColor: Color(0xff121212),
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SvgPicture.asset(
          'assets/logo_white.svg',
           width: 70,
           height: null,

        ),
      ),

      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28.0),
          bottomRight: Radius.circular(28.0),
        ),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: TextButton(
            onPressed: () {
              // Handle button press here
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'India',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.location_on,
                  size: 22,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 14,top: 4),
          child: Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Notification_EmptyState()));
              }, icon:
              Icon(
                Icons.notifications_none,
                size: 26,
                color: Colors.white,
              ),),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          )
          ,
        ),

      ],
      iconTheme: IconThemeData(color: Colors.white),

      bottom: PreferredSize(

        preferredSize: Size.fromHeight(52),
        child: Container(
          height: 46,
          margin: EdgeInsets.only(left: 12,right: 12,bottom: 8),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 4,left: 8),
              hintText: 'Search with brand and models..',
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              if (value.length == 3) {
                _searchEvents(value);
              }
            },
          ),
        ),
      ),

    );
  }

  void _showBottomPopupMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            itemCount: availableOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(availableOptions[index]),
                onTap: () {
                  // Update the search field with the selected option.
                  _searchController.text = availableOptions[index];
                  Navigator.of(context).pop(); // Close the bottom popup menu.
                },
              );
            },
          ),
        );
      },
    );
  }

  _searchEvents([String? query]) async {

    List<String> dummyOptions = [
      "Apple iPhone",
      "Samsung Galaxy",
      "Google Pixel",
      "OnePlus",
      "Xiaomi Redmi",
      "Nokia",
      // Add more phone options here.
    ];

    availableOptions = dummyOptions
        .where((option) =>
        option.toLowerCase().contains(query?.toLowerCase() as Pattern))
        .toList();

    // Show the bottom popup menu with the filtered options.
    _showBottomPopupMenu(context);

    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));

    if (query != null && query.isNotEmpty) {
      List filteredUsers = users.where((user) {
        return user["model"].toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        users = filteredUsers;
      });
    }

    setState(() {
      isLoading = false;
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
    }else {
      setState(() {
        users = [];
      });
    }
  }
}
