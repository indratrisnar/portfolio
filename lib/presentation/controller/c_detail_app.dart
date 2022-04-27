import 'package:get/get.dart';
import 'package:portfolio/data/model/m_app.dart';
import 'package:portfolio/data/source/fire_app.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CDetailApp extends GetxController {
  final Rx<MApp> _mApp = MApp().obs;
  MApp get mApp => _mApp.value;
  void setMApp(String id) async {
    _mApp.value = (await FireApp.whereId(id) ?? MApp());
    await setupYTController(mApp.id);
  }

  final Rx<YoutubePlayerController> _controllerYT = YoutubePlayerController(
    initialVideoId: '1qCrl2-lzTk&t=1s',
    params: const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
      autoPlay: false,
    ),
  ).obs;
  YoutubePlayerController get controllerYT => _controllerYT.value;

  Future<void> setupYTController(String? id) async {
    _controllerYT.value = YoutubePlayerController(
      initialVideoId: _mApp.value.youtube ?? '1qCrl2-lzTk&t=1s',
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        autoPlay: false,
      ),
    );
  }
}
