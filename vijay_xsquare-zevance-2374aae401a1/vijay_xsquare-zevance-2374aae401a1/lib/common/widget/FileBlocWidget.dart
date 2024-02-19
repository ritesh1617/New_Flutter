import 'package:flutter/material.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:video_player/video_player.dart';

class FileBlocWidget extends StatelessWidget {
  FileData? selectedFile;
  String lable = "";
  String url = "";
  String mediaType = "";
  final VoidCallback? onRemove;

  FileBlocWidget(this.selectedFile,
      {Key? key, this.lable = "", this.url = "", this.mediaType = "",this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(top: 10,right: 10),
          decoration: BoxDecoration(
              color: colors.whiteTemp,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: colors.primary,
                  blurRadius: 1.0,
                )
              ]),
          child: Center(
            child: (selectedFile == null && url == "")
                ? (lable == "")
                    ? Icon(
                        Icons.add_outlined,
                        size: 20,
                        color: colors.grayTemp,
                      )
                    : Text(
                        lable,
                        style: regularGray12,
                        textAlign: TextAlign.center,
                      )
                : (selectedFile != null &&
                        selectedFile!.type == CustomFileType.photo)
                    ? Image.file(selectedFile!.file, fit: BoxFit.cover)
                    : (selectedFile != null &&
                            selectedFile!.type == CustomFileType.video)
                        ? Stack(
                            children: [
                              VideoPlayer(
                                  VideoPlayerController.file(selectedFile!.file)
                                    ..initialize()),
                              Center(
                                  child: Image.asset(
                                Images.ic_video,
                                width: 35,
                                height: 35,
                              ))
                            ],
                          )
                        : (selectedFile != null &&
                                selectedFile!.type == CustomFileType.audio)
                            ? Center(
                                child: Image.asset(
                                Images.ic_audio,
                                width: 50,
                                height: 50,
                              ))
                            : (selectedFile != null &&
                                    selectedFile!.type == CustomFileType.pdf)
                                ? Center(
                                    child: Image.asset(
                                    Images.ic_file,
                                    width: 50,
                                    height: 50,
                                  ))
                                : (url != "" && mediaType == CustomFileType.photo)
                                    ? FadeInImage(
                                        fadeInDuration:
                                            const Duration(milliseconds: 150),
                                        image: NetworkImage(url),
                                        fit: BoxFit.cover,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                                  Images.rectangle_placeholder,
                                                  fit: BoxFit.cover,
                                                ),
                                        placeholderErrorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                                  Images.rectangle_placeholder,
                                                  fit: BoxFit.cover,
                                                ),
                                        placeholder: const AssetImage(
                                            Images.rectangle_placeholder))
                                    : (url != "" &&
                                            mediaType == CustomFileType.video)
                                        ? Stack(
                                            children: [
                                              VideoPlayer(
                                                  VideoPlayerController.file(
                                                      selectedFile!.file)
                                                    ..initialize()),
                                              Center(
                                                  child: Image.asset(
                                                Images.ic_video,
                                                width: 35,
                                                height: 35,
                                              ))
                                            ],
                                          )
                                        : (url != "" &&
                                                mediaType == CustomFileType.audio)
                                            ? Center(
                                                child: Image.asset(
                                                Images.ic_audio,
                                                width: 50,
                                                height: 50,
                                              ))
                                            : (url != "" &&
                                                    mediaType == CustomFileType.pdf)
                                                ? Center(
                                                    child: Image.asset(
                                                    Images.ic_file,
                                                    width: 50,
                                                    height: 50,
                                                  ))
                                                : Container(),
          ),
        ),
        (selectedFile!=null)? Positioned(right:0,child: GestureDetector(
            onTap: onRemove,
            child: Image.asset(Images.icon_delete,width: 30,height: 30,))):Container()
      ],
    );
  }
}
