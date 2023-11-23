import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

class WallpaperPage extends StatelessWidget {
  String imgUrl;

  WallpaperPage({required this.imgUrl});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              child: SizedBox(
            height: double.infinity,
            child: Image.network(
              imgUrl,
              fit: BoxFit.fitHeight,
            ),
          )),
          Positioned(
              top: 30,
              left: 25,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 35,
                  ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {

                },
                child: Text('set'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setwallpaper(context) {
    var progess = Wallpaper.imageDownloadProgress(imgUrl);
    progess.listen((event) {}, onDone: () async {
      print('images downloaded in cache memory!!');
      var mwidth = MediaQuery.of(context).size.width;
      var mheight = MediaQuery.of(context).size.height;

      await Wallpaper.homeScreen(
          width: mwidth,
          height: mheight,
          options: RequestSizeOptions.RESIZE_FIT);
//await Wallpaper.lockScreen(
      // width: mwidth,
      // height: mheight,
      //  options: RequestSizeOptions.RESIZE_FIT
//);
//await Wallpaper.bothScreen(
      //  width: mwidth,
      //  height: mheight,
      // options: RequestSizeOptions.RESIZE_FIT
//);
      print('wallpaper set!!');
    }, onError: (errormsg) {
      print(errormsg);
    });
  }


}
