part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent {}

class GetTrendingWallpaperEvent extends  WallpaperEvent{
String? perpage;
GetTrendingWallpaperEvent({this.perpage});

}
class GetWallpaperSearchEvent extends  WallpaperEvent{
  String query;
  String? color;
  String? pageno;
  String? perpage;

  GetWallpaperSearchEvent({required this.query,this.color,this.pageno,this.perpage});

}
