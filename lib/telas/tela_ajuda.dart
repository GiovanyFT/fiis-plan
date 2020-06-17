import 'package:flutter/material.dart';
import 'package:native_video_view/native_video_view.dart';

class TelaAjuda extends StatefulWidget {
  @override
  _TelaAjudaState createState() => _TelaAjudaState();
}

class _TelaAjudaState extends State<TelaAjuda> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: NativeVideoView(
          keepAspectRatio: true,
          showMediaController: true,
          onCreated: (controller) {
            controller.setVideoSource(
              'assets/video/apresentando_aplicativo.mp4',
              sourceType: VideoSourceType.asset,
            );
          },
          onPrepared: (controller, info) {
            controller.play();
          },
          onError: (controller, what, extra, message) {
            print('Player Error ($what | $extra | $message)');
          },
          onCompletion: (controller) {
            print('Video completed');
          },
        ),
      ),
    );
  }

}
