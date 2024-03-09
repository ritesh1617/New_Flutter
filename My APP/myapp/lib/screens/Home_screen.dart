import 'package:myapp/const/export.dart';

class home_screen extends StatelessWidget {
  var email;
  
   home_screen({super.key,required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("${email}"),
        ],
      ),
    );
  }
}