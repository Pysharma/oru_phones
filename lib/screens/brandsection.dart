import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuyTopBrandsSection extends StatelessWidget {
  final List<String> brandImages = [
    "assets/mbr_apple.png",
    "assets/mbr_oneplus.png",
    "assets/mbr_oppo.png",
    "assets/mbr_moto.png",
    "assets/mbr_realme.png",
    "assets/mbr_apple.png",
    "assets/mbr_oneplus.png",
    "assets/mbr_oppo.png",
    "assets/mbr_moto.png",
    "assets/mbr_realme.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Buy Top Brands",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Colors.black87),
          ),
          SizedBox(height: 16),
          Container(
            height: 52,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 80,
              ),
              itemCount: brandImages.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0.8,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                          child: Image.asset(brandImages[index],height: 38,),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class ShopBySection extends StatelessWidget {
  final List<Map<String, String>> shopImages = [
    {"name": "Bestselling Mobiles", "image": "assets/best-selling-mobiles (1).svg"},
    {"name": "Verified Devices only", "image": "assets/verified-mobils.svg"},
    {"name": "Like New Condition", "image": "assets/like-new.svg"},
    {"name": "Phones with Warranty", "image": "assets/warranty.svg"},
    {"name": "Shop By Price", "image": "assets/price.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            "Shop By",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Colors.black54),
          ),
          SizedBox(height: 8),
          Container(
            child: SizedBox(
              height: 180,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shopImages.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Card(
                    margin: EdgeInsets.only(right: 12,top: 12,bottom: 20),
                    elevation: 0,
                    color: Colors.white,

                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Card(
                            elevation:2,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(shopImages[index]["image"]!,height: 50),
                            ),
                          ),
                          Text(shopImages[index]["name"]! ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
