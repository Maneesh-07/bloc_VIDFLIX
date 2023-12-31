import 'dart:async';
import 'dart:io';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:bloc_VIDFLIX/functions/all_functions.dart';
import 'package:bloc_VIDFLIX/model/model_file.dart';
import 'package:bloc_VIDFLIX/widgets/appbarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

// ignore: must_be_immutable
class VideoShowingPage extends StatefulWidget {
  VideoShowingPage(
      {super.key,
      required this.index,
      required this.fromList,
      required this.seekFrom});
  int index;
  List fromList;
  int seekFrom;

  @override
  State<VideoShowingPage> createState() => _VideoShowingPage();
}

bool isPotrait = true;

Future setLandscape() async {
  await Wakelock.enable();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  AutoOrientation.landscapeAutoMode();
  isPotrait = false;
}

Future setPotrait() async {
  await Wakelock.enable();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  AutoOrientation.portraitUpMode();
  isPotrait = true;
}

bool isVisible = true;

class _VideoShowingPage extends State<VideoShowingPage> {
  late VideoPlayerController controller;
  String playingVideoPath = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //..................................need to give
    playingVideoPath = widget.fromList[widget.index];
    controller = VideoPlayerController.file(File(playingVideoPath))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        controller.seekTo(Duration(seconds: widget.seekFrom));
        setPlayingOrientation();
      });
  }

  //orientation for land to protrait

  setPlayingOrientation() async {
    await controller.play();

    // if (controller.value.isPlaying) {
    //   log('playing...........');
    //   if (controller.value.size.width > controller.value.size.height) {
    //     log('landscape...........');
    //     setLandscape();
    //   } else {
    //     log('potrait...........');
    //     setPotrait();
    //   }
    // } else {
    //   log('not playing.........');
    // }
  }

  @override
  void dispose() {
    storeLastPlayed();

    setAllOrientationToDefault();
    addToPlayedHistory(playingVideoPath, controller.value.position.inSeconds,
        controller.value.duration.inSeconds);
    controller.dispose();

    super.dispose();
  }

  storeLastPlayed() async {
    final lastPlayedBox = Hive.box<LastPlayed>('last_played');
    final lastPlayedModel = LastPlayed(
        video: playingVideoPath, position: controller.value.position.inSeconds);
    await lastPlayedBox.clear();
    await lastPlayedBox.add(lastPlayedModel);
  }

  Future setAllOrientationToDefault() async {
    await AutoOrientation.portraitUpMode();
    await Wakelock.disable();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    isPotrait = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Colors.black,
            child: controller != null && controller.value.isInitialized
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        if (isVisible == false) {
                          isVisible = true;
                          Future.delayed(const Duration(seconds: 3))
                              .then((_) => isVisible = false);
                        } else {
                          isVisible = false;
                        }
                      });
                    },
                    child: Stack(children: [
                      Center(
                        child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: Stack(
                              children: [VideoPlayer(controller)],
                            )),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Visibility(
                          visible: isVisible,
                          child: videoTopControlBar(context),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 120,
                        bottom: 120,
                        width: 160,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isVisible == false) {
                                isVisible = true;
                                Future.delayed(const Duration(seconds: 3))
                                    .then((_) => isVisible = false);
                              } else {
                                isVisible = false;
                              }
                            });
                          },
                          onDoubleTap: () {
                            controller.seekTo(controller.value.position -
                                const Duration(seconds: 10));
                          },
                          child: Container(),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 120,
                        bottom: 120,
                        width: 160,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isVisible == false) {
                                isVisible = true;
                                Future.delayed(const Duration(seconds: 3))
                                    .then((_) => isVisible = false);
                              } else {
                                isVisible = false;
                              }
                            });
                          },
                          onDoubleTap: () {
                            controller.seekTo(controller.value.position +
                                const Duration(seconds: 10));
                            setState(() {});
                          },
                          child: Container(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Visibility(
                          visible: isVisible,
                          child: videoBottomControlBar(),
                        ),
                      )
                    ]),
                  )
                : const Center(
                    child: SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator())),
                  )),
      ),
    );
  }

  Container videoTopControlBar(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.black.withOpacity(.5),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          const Spacer(),
          FavIconWidget(video: playingVideoPath),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            color: Colors.black.withOpacity(.5),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text(
                  '0.25x',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(0.25);
                },
              ),
              PopupMenuItem(
                child: const Text(
                  '0.50x',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(0.50);
                },
              ),
              PopupMenuItem(
                child: const Text(
                  '1.00x',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(1.00);
                },
              ),
              PopupMenuItem(
                child: const Text(
                  '1.25x',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(1.25);
                },
              ),
              PopupMenuItem(
                child: const Text(
                  '1.50x',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(1.50);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container videoBottomControlBar() {
    return Container(
      height: 100,
      color: Colors.black.withOpacity(.5),
      child: Column(
        children: [
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              videoDuration(controller: controller),
              Expanded(child: buildIndicator()),
              Text(
                convertMillisecondsToTime(
                    controller.value.duration.inMilliseconds),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    if (controller.value.volume != 0) {
                      controller.setVolume(0);
                    } else {
                      controller.setVolume(1);
                    }
                  },
                  icon: Icon(
                    controller.value.volume != 0
                        ? Icons.volume_up
                        : Icons.volume_off,
                    color: Colors.white,
                  )),
              IconButton(
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ),
                onPressed: () {
                  addToPlayedHistory(
                      playingVideoPath,
                      controller.value.position.inSeconds,
                      controller.value.duration.inSeconds);
                  isVisible = false;
                  isVisible = true;
                  if (widget.index > 0) {
                    widget.index--;
                    controller.pause();
                    // ..............

                    playingVideoPath = widget.fromList[widget.index];
                    controller =
                        VideoPlayerController.file(File(playingVideoPath))
                          ..initialize().then((_) {
                            setState(() {
                              setPlayingOrientation();
                            });
                            controller.play();
                          });
                    controller =
                        VideoPlayerController.file(File(playingVideoPath))
                          ..addListener(() => setState(() {}))
                          ..setLooping(true)
                          ..initialize().then((_) {
                            setPlayingOrientation();
                          });
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                  setState(() {});
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ),
                onPressed: () {
                  //adding to database for history
                  addToPlayedHistory(
                      playingVideoPath,
                      controller.value.position.inSeconds,
                      controller.value.duration.inSeconds);
                  isVisible = false;
                  isVisible = true;
                  if (widget.index < widget.fromList.length - 1) {
                    widget.index++;
                    controller.pause();
                    //...............................

                    playingVideoPath = widget.fromList[widget.index];
                    controller =
                        VideoPlayerController.file(File(playingVideoPath))
                          ..initialize().then((_) {
                            setState(() {
                              setPlayingOrientation();
                            });
                          });
                    controller =
                        VideoPlayerController.file(File(playingVideoPath))
                          ..addListener(() => setState(() {}))
                          ..setLooping(true)
                          ..initialize().then((_) {
                            setPlayingOrientation();
                          });

                    controller.play();
                  }
                },
              ),
              IconButton(
                  onPressed: () {
                    if (isPotrait) {
                      setLandscape();
                    } else {
                      setPotrait();
                    }
                  },
                  icon: const Icon(
                    Icons.screen_rotation,
                    color: Colors.white,
                  ))
            ],
          ),
        ],
      ),
    );
  }

//video progressbar indicator
  Widget buildIndicator() => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: SmoothVideoProgress(
          controller: controller,
          builder: (context, position, duration, child) => Slider(
            activeColor: Colors.grey,
            onChanged: (value) =>
                controller.seekTo(Duration(milliseconds: value.toInt())),
            value: position.inMilliseconds.toDouble(),
            min: 0,
            max: duration.inMilliseconds.toDouble(),
          ),

          // colors: VideoProgressColors(
          //     playedColor: Colors.white, backgroundColor: Colors.grey[100]!),
        ),
      );
}

class FavIconWidget extends StatefulWidget {
  FavIconWidget({super.key, required this.video});
  String video;

  @override
  State<FavIconWidget> createState() => _FavIconWidgetState();
}

class _FavIconWidgetState extends State<FavIconWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            if (!favoritesVideoNotify.contains(widget.video)) {
              addLikedVideo(context, widget.video);
              isListView.notifyListeners();
            } else {
              removeLikedVideo(
                  favoritesVideoNotify.indexOf(widget.video), context);
              isListView.notifyListeners();

              return;
            }
          });
        },
        icon: Icon(
          favoritesVideoNotify.contains(widget.video)
              ? Icons.favorite
              : Icons.favorite_border,
          color: Colors.white,
        ));
  }
}

class videoDuration extends StatefulWidget {
  videoDuration({super.key, required this.controller});
  VideoPlayerController controller;

  @override
  State<videoDuration> createState() => _videoDurationState();
}

class _videoDurationState extends State<videoDuration> {
  Timer? _timer;
  late String _position =
      '${convertMillisecondsToTime(widget.controller.value.position.inMilliseconds)}';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _position,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final duration = Duration(
          milliseconds:
              widget.controller.value.position.inMilliseconds.round());
      setState(() {
        _position = convertMillisecondsToTime(
            widget.controller.value.position.inMilliseconds);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }
}
