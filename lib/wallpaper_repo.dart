import 'package:wallcono_project/api_helper.dart';
import 'package:wallcono_project/wallcono_model.dart';

class WallpaperRepository {
 ApiHelper apiHelper;

  WallpaperRepository({required this.apiHelper});

  Future<wallpapermodel> getTrendingwallpaper({String? perPage}) async {
    var url = "curated?per_page=$perPage ";
    var jsonRes = await apiHelper.getApi(url);
    return wallpapermodel.fromJson(jsonRes);
  }

  Future<wallpapermodel> getwallpapersearch(query,
      {String? color, String? pageno, String? perpage}) async {
    var url = "https://api.pexels.com/v1/search?query=${query == "" ? "flower" : query}&per_page=${perpage ?? 20}=$color&page=$pageno";
    var jsonRes = await apiHelper.getApi(url);
    return wallpapermodel.fromJson(jsonRes);
  }
}
