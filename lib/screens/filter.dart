import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, dynamic> filtersData = {};
  bool isLoading = false;
  int selectedIndex = 0; // Variable to store the selected index

  @override
  void initState() {
    super.initState();
    fetchFiltersData();
  }

  Future<void> fetchFiltersData() async {
    setState(() {
      isLoading = true;
    });

    var url =
        "https://dev2be.oruphones.com/api/v1/global/assignment/getFilters?isLimited=true";
    var response = await http.get(Uri.parse(url));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      filtersData = Map<String, dynamic>.from(data['filters']);

      filtersData["Warranty"] = ["Brand Warranty", "Seller Warranty"];

      // Remove the "All" option from the "Verification" section
      filtersData["condition"]?.remove("All");

      // Add the "Verification" options separately
      filtersData["Verification"] = ["Verified", "Not Verified"];

      // Add the "All" option to sections other than "Verification"
      filtersData.forEach((key, value) {
        if (key != "Verification") {
          value.insert(0, "All");
        }
      });
    } else {
      setState(() {
        filtersData = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 2.0,color: Colors.white),

              ),
              child: Stack(
                children : <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 22,
                    ),

                  ),


                ],
              ),
            ),
          ),

        ),

        SizedBox(height: 20,),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: kToolbarHeight + MediaQuery.of(context).padding.top,
                    color: Colors.white, // Set the background color of the custom row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filters', // Centered text "Filter"
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Implement the logic to clear filters
                          },
                          child: Text(
                            'Clear Filter',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      itemCount: filtersData.length + 1, // Add 1 for the "Apply" button
                      itemBuilder: (context, index) {
                        if (index == filtersData.length) {
                          // Display the "Apply" button
                          return Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FractionallySizedBox(
                                widthFactor: 1, // Adjust the width of the button as needed
                                child: Container(
                                  height: 48,
                                  child: MaterialButton(
                                    color: Colors.black87,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0), // Set the desired border radius here
                                    ),
                                    onPressed: () {
                                      // TODO: Implement the apply filter logic
                                    },
                                    child: Text('APPLY',
                                      style: TextStyle(
                                      fontSize: 17, // Set the desired text size here
                                      fontWeight: FontWeight.w400,)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Display the filter options
                          String filterType = filtersData.keys.toList()[index];
                          List<dynamic> filterOptions = filtersData[filterType] ?? [];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filterType,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 80,
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 40,
                                    ),
                                    itemCount: filterOptions.length,
                                    itemBuilder: (context, index) {
                                      return getCard(filterOptions[index].toString(), index);
                                    },
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getCard(String filterOption, int index) {
    bool isSelected = index == selectedIndex;
    Color grey300Color = Colors.grey[300]!;
    Color borderColor = isSelected ? Colors.grey : grey300Color;
    return Card(
      elevation: 0.8,
      color: isSelected ? Colors.white54 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: borderColor,
          // Border color based on selection
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          // on tapping the item in the homescreen
        },
        child: Center(
          child: Text(
            filterOption,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

