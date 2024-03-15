
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class tranding_song extends StatelessWidget {
  const tranding_song({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   List<Widget> sliderItem=[
   Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/a2.jpg"),fit: BoxFit.cover),
      color: divcolor,
      borderRadius: BorderRadius.circular(30),
    ),
   child: Row(
     children: [
       Expanded(
         child: Column(
          children: [
               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(10),
                     child: Container(
                      decoration: BoxDecoration(
                        color: divcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.music_note,),
                            5.widthBox,
                            Text("Tranding",style: Theme.of(context).textTheme.labelSmall,),
                          ],
                        ),
                      ),
                     ),
                   ),
                 ],
               ),
               Spacer(),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("DJ WALA BABU",style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),)

                ],
               ),
               10.heightBox,
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BADASAH",style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 12 ,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),)

                ],
               )
          ],
         ),
       ),
     ],
   ),
   ),

   ];
    return CarouselSlider(
      items: sliderItem,
      options: CarouselOptions(
        height: 321,
        aspectRatio: 16/9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index,value){},
      ),
    );
  }
}