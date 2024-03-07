
import 'package:flutter/material.dart';

class grid_screen extends StatefulWidget {
  const grid_screen({super.key});

  @override
  State<grid_screen> createState() => _grid_screenState();
}

class _grid_screenState extends State<grid_screen> {

 final List imageurl=[
  "https://images.unsplash.com/photo-1589217157232-464b505b197f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YXBwbGV8ZW58MHx8MHx8fDA%3D",
  "https://plus.unsplash.com/premium_photo-1675731118092-c42fd9bd5164?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2hlcnJ5fGVufDB8fDB8fHww",
  "https://plus.unsplash.com/premium_photo-1692809723174-cf104ee8e903?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Z3JhcGVzfGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1423483641154-5411ec9c0ddf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Z3JhcGVzfGVufDB8fDB8fHww",
  "https://media.istockphoto.com/id/157430678/photo/three-potatoes.webp?b=1&s=170667a&w=0&k=20&c=3ziiiyDXmYzP-5v9QNn4PSH0Y7CGaq5FC_OaBCZ_dRA=",
  "https://images.unsplash.com/photo-1561136594-7f68413baa99?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dG9tYXRvfGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YmFuYW5hfGVufDB8fDB8fHww"
 ];

   List _hasBeenPressed = List.generate(7, (index) => false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: imageurl.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
        itemBuilder: (context,int ind){
          return Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 90,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("${imageurl[ind]}"),fit: BoxFit.cover)
                    ),
                  ),
                ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart,color: Colors.black,size: 40,)),
                   IconButton(onPressed: (){
                    setState(() {
                      _hasBeenPressed[ind]=!_hasBeenPressed[ind];

                    });
                   }, icon: Icon(Icons.favorite,color: _hasBeenPressed[ind]?Colors.red : Colors.white,size: 40,)),
                 ],
               ),

              ],
            ),

          );
        }
        ),
    );
  }
}