import 'package:flutter/material.dart';
import 'package:grievance/model/Follower.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class FollowerItemWidget extends StatelessWidget {
  Follower? model;
  String userId;
  String type;
  final VoidCallback? onFollowClick;

  FollowerItemWidget(this.model,this.userId,this.type,{Key? key, this.onFollowClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(model!.followerableId);
    return GestureDetector(
      onTap: () {
        if(isUser(model!, userId)){
          navigatorKey.currentState!.pushNamed(RouteName.profileScreen,arguments: model!.users);
        }
        else if(model!.users!=null){
            navigatorKey.currentState!.pushNamed(RouteName.publicProfileScreen,arguments: model!.users);
        }
        else if(model!.company!=null){
            navigatorKey.currentState!.pushNamed(RouteName.companyProfileScreen,arguments: model!.company);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: colors.grayLight,
                image: DecorationImage(
                  image: NetworkImage((model!.company != null)
                      ?( model!.company?.logo!=null)? model!.company!.logo!:"https://fff.png"
                      : (model!.users?.image!=null)?model!.users!.image!:"https://fff.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: colors.grayLight,
                  width: 2.0,
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  (isUser(model!, userId))? "You" : "${(model!.company != null) ? model!.company!.companyName : model!.users?.name}",
                  style: boldBlack14,
                ),
                const SizedBox(height: 3),
                Text(
                  "${(model!.company != null) ? (model!.company!.users!=null) ? model!.company!.users![0].headline : "" : model!.users?.userable?.headline}",
                  style: regularGray12,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
            (!isUser(model!, userId) && (type != FollowerType.follower))?  GestureDetector(
              onTap: onFollowClick,
              child: Container(
                width: 90,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [colors.firstColor, colors.secondColor]),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                  (model!.company != null)
                      ? (model!.company!.follow!)
                          ? "Unfollow"
                          : "Follow"
                      : (model!.users!=null && model!.users!.follow!=null && model!.users!.follow!)
                          ? "Unfollow"
                          : "Follow",
                  style: regularWhite12,
                )),
              ),
            ):Container( width: 90,),
          ],
        ),
      ),
    );
  }

  bool isUser(Follower model,String id){
    // print("sss"+ model.users!.id.toString());
    // print("sss"+ userId);
    if(type == FollowerType.follower){
      if(model.userId==userId){
        return true;
      }
    }else{
      if(model.followerableId==userId){
        return true;
      }
    }
    return false;
  }
}
