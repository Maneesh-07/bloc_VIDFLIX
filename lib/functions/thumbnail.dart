import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// ignore: must_be_immutable
class ThumbnailWidget extends StatelessWidget {
  ThumbnailWidget({super.key, required this.videoPath});
  String videoPath;
  String? img;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getThumbnail('/$videoPath'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return snapshot.hasData
            ? Image.file(
                File(snapshot.data!),
                fit: BoxFit.cover,
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                child: Center(child: Image.asset("assets/images/vidflix.png")),
              );
      },
    );
  }

  Future<String> getThumbnail(String video) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: video,
      thumbnailPath: (await getTemporaryDirectory()).path,
      quality: 100,
    );
    return fileName!;
  }
}
