import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var duration =  ''.obs;
  var position = ''.obs;

  var max =0.0.obs;
  var value = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  updatePosition(){
    audioPlayer.durationStream.listen((d) {
      duration!.value = d.toString().split('.')[0];
      max.value = d!.inSeconds.toDouble();

    });

    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split('.')[0];
      value.value = p.inSeconds.toDouble();
    });
  }

 changeDurationToSeconds(seconds){
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
 }
  void checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      querySongs();
    } else if (status.isDenied || status.isRestricted) {
      var result = await Permission.storage.request();
      if (result.isGranted) {
        querySongs();
      } else {
        checkPermission();
      }
    }
  }

  playSong(String? uri,index){

    playIndex.value = index;
    try{
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    }on Exception catch(e){
      print(e.toString());
    }

  }

  void querySongs() {
    audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
  }
}
