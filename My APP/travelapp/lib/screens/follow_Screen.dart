
import 'package:travelapp/const/export.dart';

class follow_Screen extends StatefulWidget {
  const follow_Screen({Key? key}) : super(key: key);

  @override
  State<follow_Screen> createState() => _follow_ScreenState();
}

class _follow_ScreenState extends State<follow_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.arrow_back,size: 30,),
            SizedBox(width: 10,),
            Text("Follow Artists",style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Text("Follow Your Favarite artist.Or you can skip it\nfor now",style: TextStyle(fontSize: 16),),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: artistname.length,
                itemBuilder: (context,int ind){
              return Card(
                  child: follow_screen_container(
                       artistname: "${artistname[ind]}",
                       follow: "Follow"
                         
                  ),
              );
            }))
          ],
        ),
      ),
    );
  }
}