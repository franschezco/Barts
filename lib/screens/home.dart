import 'package:barts/screens/player.dart';
import 'package:flutter/material.dart';
import 'package:barts/consts/colors.dart';
import 'package:barts/consts/text_style.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/playerscontroller.dart';
import 'package:flutter_animate/flutter_animate.dart';
class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        leading: Icon(Icons.sort_rounded,color: bgColor,),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search , color: bgColor,))
          ],
          title: Row(
            children: [
              Icon(Icons.headphones),
              SizedBox(width: 10,),
              Text('Barts',style: ourStyles(
                  color: whiteColor,family: 'ROCK',size: 23),),
            ],
          )
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext context, snapshot){
          if (snapshot.data == null){
            return Center(
              child: CircularProgressIndicator(),
            );}else if (snapshot.data!.isEmpty){
            return Center(
            child: Text('No song found',style: ourStyles(),),
            );

    }else{
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder:(BuildContext context,int index){
                    return Container(

                      margin: const EdgeInsets.only(bottom: 4),
                      child: Obx(()=> ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tileColor: bgColor,
                          title: Text(snapshot.data![index].displayNameWOExt,style: ourStyles(
                            family: 'ROCK',
                            size: 15,
                          ),),
                          subtitle: Text('${snapshot.data![index].artist}',style: ourStyles(
                            family: 'ROCK',
                            size: 12,
                          ),),
                          leading: QueryArtworkWidget(id: snapshot.data![index].id ,type: ArtworkType.AUDIO,
                          nullArtworkWidget: const
                            Icon(Icons.music_note,size: 32,color: whiteColor,),
                          ),
                          trailing: controller.playIndex ==index && controller.isPlaying.value ? Icon(
                            Icons.play_arrow,color: whiteColor,size: 26,
                          ): null,
                          onTap: (){
                            Get.to(()=> PlayerScreen(data: snapshot.data!,));
                           controller.playSong(snapshot.data![index].uri, index);
                          },
                        ),
                      ),
                    ).animate().fadeIn(duration: 120.ms);
                  }

              ),

            );}
          }

      ),
    );
  }
}