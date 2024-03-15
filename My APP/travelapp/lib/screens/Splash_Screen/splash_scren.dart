import 'package:travelapp/const/export.dart';


class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Get.offAll(()=>home());
    });
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 146, 7, 170),
      body:Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Lottie.asset("assets/Animation - 1710401108592.json"),
               Text("SET MOOD WITH \n    GOOD MUSIC",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
               SizedBox(height: 10,),
               Lottie.asset("assets/Animation - 1710402271057.json"),
            ],
                
          ),
        ),
      )
    );
  }
}
 