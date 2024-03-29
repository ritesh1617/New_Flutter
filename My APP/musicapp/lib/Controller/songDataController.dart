import 'package:musicapp/const/export.dart';



class songdataController extends GetxController{
  final audioQuery=OnAudioQuery();
 
  RxList<SongModel> localsongList=<SongModel>[].obs;

  RxBool isDeviceSong =false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storagePermission();
  }

  void getLocalSongs()async{
    localsongList.value=await audioQuery.querySongs(
      ignoreCase: true,
      orderType:OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
  }
  void storagePermission()async{
     try {
      var perm=await Permission.storage.request();
      if(perm.isGranted){
        print("Permission granted");
        getLocalSongs();
      }else{
        print("Permission denied");
        await Permission.storage.request();
      }
     }catch(ex){
      print(ex);
     }
  }
}