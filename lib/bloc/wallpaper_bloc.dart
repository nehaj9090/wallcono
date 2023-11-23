import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../wallcono_model.dart';
import '../wallpaper_repo.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class   WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperRepository repo;
  WallpaperBloc({required this.repo}):
    super(WallpaperInitialState() ) {
    on<GetTrendingWallpaperEvent>((event, emit)async {
      emit(WallpaperLoadingState());
     var wallpapers = await repo.getTrendingwallpaper(perPage:event.perpage);
    emit(WallpaperLoadedState(wallpapers: wallpapers));

    });


    on<GetWallpaperSearchEvent>((event, emit)async {
      emit(WallpaperLoadingState());
      var wallpapers = await repo.getwallpapersearch(event.query,
          perpage: event.perpage,
          color: event.color,
          pageno: event.color);
      emit(WallpaperLoadedState(wallpapers: wallpapers));

    });
  }
}
