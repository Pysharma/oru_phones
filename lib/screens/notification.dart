import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Notification_EmptyState extends StatelessWidget {
  Notification_EmptyState({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 20,
          ),

        ),
        title: Text('Notification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xff090B0E),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Center(
        child: Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/notification-status.svg'),
              SizedBox(height: 24,),
              Text(
                textAlign: TextAlign.center,
                'You haven’t gotten any\nnotifications yet.',
                style: TextStyle(color : Color(0xff090B0E),fontWeight: FontWeight.w700,fontSize: 16),
              ),
              SizedBox(height: 8,),
              Text(
                textAlign: TextAlign.center,
                'We’ll alert you once something cools happens',
                style: TextStyle(color : Color(0xff546881),fontWeight: FontWeight.w400,fontSize: 14),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),

    );
  }
}