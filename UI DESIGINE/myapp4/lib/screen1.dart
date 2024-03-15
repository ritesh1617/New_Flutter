import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  State<screen> createState() => _screenState();
}

class _screenState extends State<screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text("My Diary",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            ),
            Container(
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new),
                  Icon(Icons.date_range),
                  Text("15 May",style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold,),),
                  Icon(Icons.arrow_forward_ios),
                  
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text("Mediterranean dieat",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Details",style: GoogleFonts.roboto(color: Colors.blue,fontSize: 12),),
                        Icon(Icons.arrow_forward,color: Colors.black,),
                      ],
                    ),
                  )
                ],
              ),
            ),// First Row
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10),
             child: Container(
               margin: EdgeInsets.all(16),
               height: 250,
               width: 350,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(topRight: Radius.circular(80))
               ),
               child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                       Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 60),
                              child: Text("Eaten",style: TextStyle(color: Colors.blue,fontSize: 12),),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.home),
                                SizedBox(width: 10,),
                                Text("1127"),
                                SizedBox(width: 10,),
                                Text("kcal",style: TextStyle(color: Colors.grey,fontSize: 12),),
                              ],
                            ),
                            SizedBox(height: 20,),
                             Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Text("Burned",style: TextStyle(color: Colors.blue,fontSize: 12),),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.home),
                                SizedBox(width: 10,),
                                Text("1127"),
                                SizedBox(width: 10,),
                                Text("kcal",style: TextStyle(color: Colors.grey,fontSize: 12),),
                              ],
                            ),
                          ],
                        ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top:40),
                         child: Container(
                          child: CircularPercentIndicator(
                            radius: 50,
                            lineWidth: 10,
                            percent: 0.5,
                            center: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text("1503",style: TextStyle(color: Colors.blue[300],fontSize: 20),),
                                  Text("kcal left",style: TextStyle(color: Colors.grey,fontSize: 12),),
                                  
                                ],
                              ),
                            ),
                           progressColor: Colors.blue[300],
                         
                          )
                         ),
                       )  
                      ],
                    ),
                  ),// 1 container
                  SizedBox(height: 20,),
                  Divider(height: 2,color: Colors.grey[400],),
                  SizedBox(width: 20,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:20),
                          child: Column(
                            children: [
                              Text("Carbs",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Container(
                                  height: 2,
                                  width: 50,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Text("12g left",style: TextStyle(color: Colors.grey,fontSize: 12),),
                            ],
                          ),
                        ),
                        
                         Column(
                            children: [
                              Text("Protin",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Container(
                                  height: 2,
                                  width: 50,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Text("30g left",style: TextStyle(color: Colors.grey,fontSize: 12),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Fat",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Container(
                                  height: 2,
                                  width: 50,
                                  color: Colors.yellowAccent,
                                ),
                              ),
                              Text("10g left",style: TextStyle(color: Colors.grey,fontSize: 12),),
                            ],
                          ),
                      ],
                    ),
                  )

               ],),
             ),
           ),//second Row container

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("Meals today",style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Customize",style: GoogleFonts.roboto(color: Colors.blueAccent),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                )
              ],
            ),
          ),//third row 
           

          ],
        ),
      ),
    );
  }
}