import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/Mappers/tmdb_simple_movie_mapper.dart';
import 'package:movie_app/Core/Mappers/yts_movies_mapper.dart';
import 'package:movie_app/Core/Models/Movie/TMBD%20Response%20Models/tmdb_movies_response_model.dart';
import 'package:movie_app/Core/Models/Movie/YTS%20%20Response%20Models/yts_movie_response.dart';
import 'package:movie_app/Features/HomeScreen/data/Data%20Source/movies_tmdb_data_sources_impl.dart';
import 'package:movie_app/Features/HomeScreen/data/Data%20Source/movies_yts_data_sources_impl.dart';
import 'package:movie_app/Features/HomeScreen/domain/Abstract%20repo/movies_repo.dart';
import '../../../../Core/Entities/movie_entity.dart';
import '../../../../Core/Mappers/tmdb_movies_mapper.dart';
import '../../../../Core/Mappers/yts_simple_movie_mapper.dart';


@Injectable(as: MoviesRepository)
class MoviesRemoteRepository extends MoviesRepository{
  final MoviesTmdbDataSourcesImpl tmbdDs;
  final MoviesYTSDataSourcesImpl ytsDs;
  MoviesRemoteRepository(
      @Named("HomeTMDB") this.tmbdDs,
      @Named("HomeYTS") this.ytsDs
  );

  @override
  Future<MoviesEntity?> searchMovies(String movieName)  async{
    try {
      var response =  await ytsDs.searchMovies(movieName);
      return response?.toEntity();
    }catch(e){
      try{
        var response= await tmbdDs.searchMovies(movieName);
        return response.toMoviesEntity();
      }catch(e){
        rethrow;
      }

    }
  }

  @override
  Future<MoviesEntity?> listMoviesByGenre(dynamic genre)  async {
    try {
      var response =  await ytsDs.listMoviesByGenre(genre);
      return response?.toEntity();
    }catch(e){

      try{
        var response= await tmbdDs.listMoviesByGenre(genre);
        return response.toMoviesEntity();
      }catch(e){

        rethrow;
      }

    }
  }

  @override
  Future<MoviesEntity?> listLimitMoviesByGenre(dynamic genre,int limit)  async{
    try{
      var response = await ytsDs.listLimitMoviesByGenre(genre, limit);
      return response?.toEntity();
    }catch(e){
      try {
        var response = await tmbdDs.listLimitMoviesByGenre(genre, limit);
        var entity = response.toMoviesEntity();

        var limitedEntity = MoviesEntity(
          moviesCount: entity.moviesCount,
          pageNumber: entity.pageNumber,
          totalPages: entity.totalPages,
          movies: entity.movies?.take(limit).toList(),
        );

        return limitedEntity;
      } catch (e) {
        rethrow;
      }
    }

  }


  //recent_movies
  @override
  Future<MoviesEntity?> getRecentMovies() async{
    try{
      var response = await ytsDs.getRecentMovies();
      return response?.toEntity();
    }catch(e) {
      try {
        var response = await tmbdDs.getRecentMovies();
        return response.toMoviesEntity();
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<List<MovieSimpleEntity>?> getMoviesByIDs(List<int> ids) async {
    try{
      final List<MovieResponse>? response = await ytsDs.getMoviesByIDs(ids);

      List<MovieSimpleEntity>? list = response?.map((movie) {
        return movie.toSimpleMovieEntity();
      }).toList();
      return list;
    }catch(e) {
      try {
        final List<TMDBMovie> response = await tmbdDs.getMoviesByIDs(ids);

        List<MovieSimpleEntity>? list = response.map((movie) {
          return movie.toSimpleMovieEntity();
        }).toList();
        return list;
      } catch (e) {
        rethrow;
      }
    }
  }





}

