import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallcono_project/api_helper.dart';
import 'package:wallcono_project/bloc/wallpaper_bloc.dart';
import 'package:wallcono_project/wallcono_model.dart';
import 'package:http/http.dart' as httpclient;
import 'package:wallcono_project/wallpaper_page.dart';
import 'package:wallcono_project/wallpaper_repo.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<WallpaperBloc>(
        create: (context) => WallpaperBloc(repo: WallpaperRepository(apiHelper: ApiHelper())),
      ),

    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<wallpapermodel> arrwallpaper;
  var searchController = TextEditingController();
  var pageno = 1;
  String? mColor;
  List<Map<String, dynamic>> arrcolors = [
    {"name": "ffffff", "color": Color(0xff1b156b)},
    {"name": "000000", "color": Color(0xff000000)},
    {"name": "FFFFFFFF ", "color": Color(0xffbe1e1e)},
    {"name": "ff0e0e", "color": Color(0xff640e0e)},
    {"name": "B96969FF", "color": Color(0xffb96969)},
    {"name": "B96969FF", "color": Color(0xffB969FF)},
    {"name": "B96969FF", "color": Color(0xff1b156b)},
    {"name": "B96969FF", "color": Color(0xffb96969)},
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WallpaperBloc>(context).add(GetTrendingWallpaperEvent());

    //arrwallpaper = getATradingwallpaper();
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation==Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('wallcono api'),
      ),
      body: BlocBuilder<WallpaperBloc, WallpaperState>(

        builder: (ctx, state) {
          if (state is WallpaperLoadingState) {
            return CircularProgressIndicator();
          }
          if (state is WallpaperLoadedState) {
            if (state.wallpapers!=null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                               BlocProvider.of<WallpaperBloc>(context).
                               add(GetWallpaperSearchEvent(query: searchController.text.toString()));
                              },
                              child: Icon(Icons.search)),
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: arrcolors.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                //mColor = arrcolors[index]['name'];
                               // arrwallpaper = getMywallpaper(
                                //    searchController.text.toString(),
                                 //   color: mColor);
                               // setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: arrcolors[index]['color'],
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: GridView.builder(
                          itemCount: state.wallpapers.photos!.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 11,
                              childAspectRatio: isPortrait ? 9/16: 16/9),
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          WallpaperPage(imgUrl: isPortrait ? state.wallpapers.photos![index].src!
                                              .portrait!: state.wallpapers.photos![index].src!
                                              .landscape!,)));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: Image.network(
                                    isPortrait ? state.wallpapers.photos![index].src!
                                        .portrait!: state.wallpapers.photos![index].src!
                                        .landscape!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Text('no wallpaper');
            }
          }
          if(state is WallpaperErrrorState){
            return Text(state.errormsg);
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         // pageno++;
         // arrwallpaper =
         //     getMywallpaper(searchController.text.toString(), color: mColor);
         // setState(() {});
        },
      ),
    );
  }
}


 // Future<wallpapermodel> getATradingwallpaper() async {
   // var apikey = "KbRKTV6Up44rGKLJOLjbt1pPBNYBIcWydiKt6Dym1iTRnLPZDtwLOzgg";
    //var myUrl = "https://api.pexels.com/v1/curated?per_page=50";
    //var res = await httpclient
       // .get(Uri.parse(myUrl), headers: {"Authorization": apikey});
    //yaha stutes code //
   // if (res.statusCode == 200) {
    //  return wallpapermodel.fromJson(jsonDecode(res.body.toString()));
  //  } else {
    //  return wallpapermodel();
  //  }
//  }

  //Future<wallpapermodel> getMywallpaper(String query, {String? color}) async {
   // var apikey = "KbRKTV6Up44rGKLJOLjbt1pPBNYBIcWydiKt6Dym1iTRnLPZDtwLOzgg";

   // ///yaha url mai $query pass karna hoga ////
   // var myUrl =
    //    "https://api.pexels.com/v1/search?query=${query == "" ? "flower" : query}&per_page=20&color=$color&page=$pageno";
  //  var res = await httpclient
    //    .get(Uri.parse(myUrl), headers: {"Authorization": apikey});
    //yaha stutes code //
   // if (res.statusCode == 200) {
    //  return wallpapermodel.fromJson(jsonDecode(res.body.toString()));
   // } else {
   //   return wallpapermodel();
   // }
//  }

