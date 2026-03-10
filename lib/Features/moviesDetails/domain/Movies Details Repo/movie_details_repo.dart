
import '../../../../Core/Entities/movie_entity.dart';


abstract class MovieDetailsRepo {

  Future<MovieEntity> getMovieByID(int id);

  Future<void> updateUserList(String listName,int id,bool isAdd);

  Future<void> watchMovieFromUrl(String url);

}

