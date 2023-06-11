import 'package:barts/consts/colors.dart';
import 'package:barts/consts/text_style.dart';
import 'package:barts/controllers/playerscontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;
   PlayerScreen({Key? key,required this.data}) : super(key: key);

  var controller = Get.find<PlayerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar( ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child:  Obx(()=>  Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: QueryArtworkWidget(id: data[controller.playIndex.value].id ,type: ArtworkType.AUDIO,
                artworkHeight: double.infinity,artworkWidth: double.infinity,
              nullArtworkWidget: Icon(Icons.music_note,size: 48,color: whiteColor,),
              ),),
            )),
            SizedBox(height: 12,),

            Expanded(child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
            decoration: BoxDecoration(
                color: whiteColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))
            ),
              child: Obx(()=> Column(
                  children: [
                    Text(data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyles(color: bgDarkColor,family: 'rock',size: 23),).animate().fadeIn(duration: 40.ms),
                    SizedBox(height: 12,),
                    Text(data[controller.playIndex.value].artist.toString(),style: ourStyles(color: bgDarkColor,family: 'rock',size: 18),),
                    SizedBox(height: 12,),
                    Obx(()=> Row(
                        children: [
                          Text(controller.position.value,textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,style: ourStyles(color: bgDarkColor),),
                          Expanded(child:

                          Slider(
                              thumbColor: slideColor,
                              activeColor: slideColor,
                              inactiveColor: bgColor,
                              min:Duration(seconds: 0).inSeconds.toDouble(),
                              max: controller.max.value,

                              value: controller.value.value, onChanged: (newValue){
                                controller.changeDurationToSeconds(newValue.toInt());
                                newValue = newValue;
                          })).animate().fadeIn(duration: 120.ms),
                          Text(controller.duration.value,style: ourStyles(color: bgDarkColor),),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      IconButton(onPressed: (){
                        controller.playSong(data[controller.playIndex.value-1].uri, controller.playIndex.value-1);
                      }, icon: Icon(Icons.skip_previous_rounded , size: 40,color: bgDarkColor,)),
                      Obx(()=> CircleAvatar(
                          radius: 35,
                          backgroundColor: bgDarkColor,
                            child: Transform.scale(
                              scale:2.5,
                                child: IconButton(onPressed: (){
                                  if(controller.isPlaying.value){
                                    controller.audioPlayer.pause();
                                    controller.isPlaying(false);
                                  }else{
                                    controller.audioPlayer.play();
                                    controller.isPlaying(true);

                                  }

                                }, icon:controller.isPlaying.value ?Icon(Icons.pause): Icon(Icons.play_arrow_rounded,color: whiteColor,)))),
                      ),
                      IconButton(onPressed: (){
                        controller.playSong(data[controller.playIndex.value + 1].uri, controller.playIndex.value+1);
                      }, icon: Icon(Icons.skip_next_rounded, size: 40,color: bgDarkColor)),
                    ],)
                  ]
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
