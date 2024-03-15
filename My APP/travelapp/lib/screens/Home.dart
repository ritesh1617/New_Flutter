
import 'package:travelapp/const/export.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           CircleAvatar(
            radius: 20,
            backgroundColor: litered,
            child: Icon(Icons.music_note),
           ),
           Container(
            margin: EdgeInsets.all(12),
            child: Text("Explore",style: TextStyle(fontWeight: FontWeight.bold),),
           ),
           Container(
            margin: EdgeInsets.all(12),
            child: Icon(Icons.menu_rounded),
           ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,size: 30,),
                    hintText: "Artist,Songs,Podcasts & More",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("Browse All",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: MusicName.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing:1,mainAxisSpacing: 1 ),
                 itemBuilder: (context,int ind){
                  return Card(
                    margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                    color: Colors.amber,
                    child:InkWell(
                      onTap: (){
                        Get.offAll(()=>Muisc_list());
                      },
                      child: container_pro(
                        color: colorContainer[ind],
                        mname: "${MusicName[ind]}",
                      ),
                    ),
                  );
                 }),
  )
            ],
          ),
        ),
      ),
    );
  }
}