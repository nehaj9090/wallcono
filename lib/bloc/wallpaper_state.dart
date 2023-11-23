part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperState {}

class WallpaperInitialState extends WallpaperState {}
class WallpaperLoadingState extends WallpaperState {}
class WallpaperLoadedState extends WallpaperState {

  wallpapermodel wallpapers;
  WallpaperLoadedState({required this.wallpapers});
}
class WallpaperErrrorState extends WallpaperState {
  String errormsg;
  WallpaperErrrorState({required this.errormsg});


}