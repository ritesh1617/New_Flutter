import 'package:travelapp/const/export.dart';

class Muisc_list extends StatefulWidget {
  const Muisc_list({Key? key}) : super(key: key);

  @override
  State<Muisc_list> createState() => _Muisc_listState();
}

class _Muisc_listState extends State<Muisc_list> {
  late List isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(20, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, int index) {
                  return Card(
                    child: music_list_container(
                      musicname: "Ritesh",
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isSelected[index] = !isSelected[index];                    
                          });
                        },
                        icon: isSelected[index]
                            ? Icon(Icons.pause, size: 40)
                            : Icon(Icons.play_arrow, size: 40),
                      ),
                      color: litered,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
