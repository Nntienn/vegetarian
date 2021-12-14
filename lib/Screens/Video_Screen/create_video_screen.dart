import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vegetarian/Screens/MainScreen/main_screen.dart';
import 'package:vegetarian/blocs/home_blocs.dart';
import 'package:vegetarian/blocs/upload_video_bloc.dart';
import 'package:vegetarian/events/home_events.dart';
import 'package:vegetarian/events/upload_video_event.dart';
import 'package:vegetarian/models/upload_video.dart';
import 'package:vegetarian/states/upload_video.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadVideoScreen extends StatefulWidget {
  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  late UploadVideoBloc _UploadVideoBloc;
  VideoPlayerController? _controller;
  int currentStep = 0;
  bool isCompleted = false;
  String filePath = "";
  FilePickerResult? file;
  String? link;
  TextEditingController title = TextEditingController();
  bool _stepvalidate = false;
  final stepcontent = TextEditingController();
  String imageName="";
  String thumbnail="";

  static Future<CloudinaryResponse> uploadFileOnCloudinary(
      {required String filePath,
      required CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response = new CloudinaryResponse(
        assetId: '',
        publicId: "",
        createdAt: DateTime.now(),
        url: "",
        secureUrl: "",
        originalFilename: "");
    try {
      var cloudinary =
          CloudinaryPublic('thuanhoang2108', 'se8jipuu', cache: false);
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: resourceType),
      );
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
    }
    return response;
  }

  Future<void> selectFile() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );
      setState(() {
        filePath = result!.paths.first!;
      });
      print(filePath);
      file = result;
      _controller = VideoPlayerController.network(filePath)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    } on PlatformException catch (e) {
    } on Exception catch (e, s) {}
  }
  Future<void> getImage(String filepath) async {
    String? fileName = await VideoThumbnail.thumbnailFile(
      video: filepath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 1920, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    setState(() {
      imageName = fileName!;
    });

  }
  @override
  void initState() {
    super.initState();
    _UploadVideoBloc = BlocProvider.of(context);
    _controller = VideoPlayerController.network('')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Video'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Basic',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )
                  ],
                ),
              ),
              Text(
                'Name your Video*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      this.title.text = value;
                    });
                  },
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'E.g Coob Salad',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Video',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      width: 80,
                      height: 25,
                      child: TextButton(
                          onPressed: selectFile,
                          child: Text(
                            'Choose Video',
                            style: TextStyle(fontSize: 10),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 10),
                          )),
                    ),
                    Container(
                      child: Text(
                        filePath.split('/').last,
                        overflow: TextOverflow.ellipsis,
                      ),
                      width: MediaQuery.of(context).size.width * 0.55,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Description*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.2,
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      _stepvalidate = false;
                    });
                  },
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  controller: stepcontent,
                  decoration: InputDecoration(
                    errorText: _stepvalidate ? 'Value Can\'t Be Empty' : null,
                    hintText: 'What need to be done in this step?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: _controller!.value.isInitialized
                    ? Column(children: [
                        Container(
                          height: 300,
                          child: AspectRatio(
                            child: VideoPlayer(_controller!),
                            aspectRatio: _controller!.value.aspectRatio,
                          ),
                        ),
                        Container(
                          height: 50,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _controller!.value.isPlaying
                                    ? _controller!.pause()
                                    : _controller!.play();
                              });
                            },
                            icon: Icon(
                              _controller!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocListener<UploadVideoBloc, UploadVideoState>(
                          listener: (context, state) {
                            print(state);
                            if (state is UploadVideoStateSuccess) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                            create: (context) => HomeBloc()
                                              ..add(HomeFetchEvent()),
                                            child: MyHomePage(
                                              token: '123',
                                            ),
                                          )));
                            }
                          },
                          child: Container(
                            height: 50,
                            child: TextButton(
                                onPressed: () async {
                                  if (stepcontent.text == "") {
                                    _stepvalidate = true;
                                  } else {
                                    if (file != null) {
                                      for (PlatformFile file in file!.files) {
                                        if (file.path != null) {
                                          var response =
                                              await uploadFileOnCloudinary(
                                            filePath: file.path.toString(),
                                            resourceType:
                                                CloudinaryResourceType.Auto,
                                          );
                                          await getImage(file.path.toString());
                                          var irespond = await uploadFileOnCloudinary(filePath: imageName, resourceType: CloudinaryResourceType.Auto);
                                          setState(() {
                                            thumbnail = irespond.secureUrl;
                                          });

                                          setState(() {
                                            link = response.secureUrl;
                                          });
                                          print(link);
                                        }
                                      }
                                    }
                                    ;
                                    _UploadVideoBloc.add(UploadVideoEvent(
                                        new UploadVideo(
                                            userId: 1,
                                            videoCategoryId: 1,
                                            videoTitle: title.text,
                                            videoLink: link.toString(),
                                            videoDescription:
                                                stepcontent.text, videoThumbnail: thumbnail)));
                                  }
                                },
                                child: Text("Upload")),
                          ),
                        )
                      ])
                    : SizedBox(
                        height: 0,
                      ),
              ),
            ],
          ),
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
