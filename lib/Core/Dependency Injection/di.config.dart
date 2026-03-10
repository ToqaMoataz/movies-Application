// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../Features/Authentication/data/data%20source/data%20source.dart'
    as _i736;
import '../../Features/Authentication/data/Repository%20Implementation/repo_implemantation.dart'
    as _i644;
import '../../Features/Authentication/domain/Apstract%20Repo/repo.dart'
    as _i561;
import '../../Features/Authentication/domain/Use%20Cases/forgetPass_usecase.dart'
    as _i934;
import '../../Features/Authentication/domain/Use%20Cases/login_usecase.dart'
    as _i394;
import '../../Features/Authentication/domain/Use%20Cases/register_usecase.dart'
    as _i445;
import '../../Features/Authentication/persentation/Screens/Forget%20Password/Forget%20Password%20Cubit/cubit.dart'
    as _i660;
import '../../Features/Authentication/persentation/Screens/Login%20Screen/Login%20Cubit/cubit.dart'
    as _i782;
import '../../Features/Authentication/persentation/Screens/Regiser%20Screen/Register%20Cubit/cubit.dart'
    as _i584;
import '../../Features/HomeScreen/data/Data%20Source/movies_tmdb_data_sources_impl.dart'
    as _i663;
import '../../Features/HomeScreen/data/Data%20Source/movies_yts_data_sources_impl.dart'
    as _i816;
import '../../Features/HomeScreen/data/Data%20Source/user_data_sources.dart'
    as _i830;
import '../../Features/HomeScreen/data/Data%20Source/user_data_sources_impl.dart'
    as _i549;
import '../../Features/HomeScreen/data/Repo%20Implementation/movie_remote_repo_imp.dart'
    as _i471;
import '../../Features/HomeScreen/data/Repo%20Implementation/user_repo_impl.dart'
    as _i545;
import '../../Features/HomeScreen/domain/Abstract%20repo/movies_repo.dart'
    as _i1036;
import '../../Features/HomeScreen/domain/Abstract%20repo/user_repo.dart'
    as _i762;
import '../../Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/movies_base_usecase.dart'
    as _i61;
import '../../Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/Usecases/browse_movies_us.dart'
    as _i451;
import '../../Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/Usecases/get_recent_movies_us.dart'
    as _i973;
import '../../Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/Usecases/list_limi_movies_us.dart'
    as _i890;
import '../../Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/Usecases/movies_list_us.dart'
    as _i400;
import '../../Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/Usecases/search_movies_us.dart'
    as _i530;
import '../../Features/HomeScreen/domain/Usecases/User%20Use%20Cases/Usecases/getcurruser_use_cases.dart'
    as _i738;
import '../../Features/HomeScreen/domain/Usecases/User%20Use%20Cases/Usecases/signout_use_cases.dart'
    as _i607;
import '../../Features/HomeScreen/domain/Usecases/User%20Use%20Cases/user_base_usecase.dart'
    as _i262;
import '../../Features/HomeScreen/persentation/HomeScreen%20cubit/cubit.dart'
    as _i925;
import '../../Features/moviesDetails/data/Data%20Sources/dataSource.dart'
    as _i157;
import '../../Features/moviesDetails/data/Repo%20Imlementation/movie_details_repo_Imp.dart'
    as _i587;
import '../../Features/moviesDetails/domain/Movies%20Details%20Repo/movie_details_repo.dart'
    as _i682;
import '../../Features/moviesDetails/domain/Use%20Cases/getMovieByID_usecase.dart'
    as _i822;
import '../../Features/moviesDetails/domain/Use%20Cases/moviesDetails_usecases.dart'
    as _i818;
import '../../Features/moviesDetails/domain/Use%20Cases/updateUserList_usecase.dart'
    as _i221;
import '../../Features/moviesDetails/domain/Use%20Cases/watchMovieFromUrl_usecase.dart'
    as _i901;
import '../../Features/moviesDetails/persentation/MovieDetailsScreen%20cubit/cubit.dart'
    as _i699;
import '../../Features/Update%20and%20Delete%20profile/data/Data%20Source/update_profile_datasource.dart'
    as _i669;
import '../../Features/Update%20and%20Delete%20profile/data/Edit%20Profile%20repo%20Imp/update_profile_repo_imp.dart'
    as _i881;
import '../../Features/Update%20and%20Delete%20profile/domail/Edit%20Profile%20repo/update_profile_repo.dart'
    as _i47;
import '../../Features/Update%20and%20Delete%20profile/domail/Use%20Cases/updateProfile_base_usecase.dart'
    as _i310;
import '../../Features/Update%20and%20Delete%20profile/domail/Use%20Cases/use%20cases/deletUser_usecase.dart'
    as _i677;
import '../../Features/Update%20and%20Delete%20profile/domail/Use%20Cases/use%20cases/updateuserdata_usecase.dart'
    as _i465;
import '../../Features/Update%20and%20Delete%20profile/persentation/update%20and%20delete%20cubit/cubit.dart'
    as _i206;
import '../APIs/api_manager.dart' as _i712;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i712.ApiManager>(() => _i712.ApiManager());
    gh.lazySingleton<_i816.MoviesYTSDataSourcesImpl>(
      () => _i816.MoviesYTSDataSourcesImpl(gh<_i712.ApiManager>()),
      instanceName: 'HomeYTS',
    );
    gh.lazySingleton<_i830.UserDataSources>(() => _i549.UserDataSourcesImpl());
    gh.lazySingleton<_i157.MoviesDetailsTMBDImpDs>(
      () => _i157.MoviesDetailsTMBDImpDs(gh<_i712.ApiManager>()),
      instanceName: 'tmdbDetailsDS',
    );
    gh.factory<_i669.UpdateProfileDS>(() => _i669.UpdateProfileDSImp());
    gh.lazySingleton<_i157.MoviesDetailsYTSImpDs>(
      () => _i157.MoviesDetailsYTSImpDs(gh<_i712.ApiManager>()),
      instanceName: 'ytsDetailsDS',
    );
    gh.lazySingleton<_i663.MoviesTmdbDataSourcesImpl>(
      () => _i663.MoviesTmdbDataSourcesImpl(gh<_i712.ApiManager>()),
      instanceName: 'HomeTMDB',
    );
    gh.factory<_i736.AuthDataSource>(() => _i736.AuthDataSourceImp());
    gh.factory<_i1036.MoviesRepository>(() => _i471.MoviesRemoteRepository(
          gh<_i663.MoviesTmdbDataSourcesImpl>(instanceName: 'HomeTMDB'),
          gh<_i816.MoviesYTSDataSourcesImpl>(instanceName: 'HomeYTS'),
        ));
    gh.lazySingleton<_i762.UserRepo>(
        () => _i545.UserRepoImpl(gh<_i830.UserDataSources>()));
    gh.factory<_i47.UpdateProfileRepo>(
        () => _i881.UpdateProfileRepoImp(gh<_i669.UpdateProfileDS>()));
    gh.factory<_i682.MovieDetailsRepo>(() => _i587.MovieDetailsRepoImp(
          gh<_i157.MoviesDetailsTMBDImpDs>(instanceName: 'tmdbDetailsDS'),
          gh<_i157.MoviesDetailsYTSImpDs>(instanceName: 'ytsDetailsDS'),
        ));
    gh.factory<_i561.AuthRepository>(
        () => _i644.AuthRepositoryImplementation(gh<_i736.AuthDataSource>()));
    gh.factory<_i822.GetMovieByIDUC>(
        () => _i822.GetMovieByIDUC(gh<_i682.MovieDetailsRepo>()));
    gh.factory<_i818.MovieDetailsUseCases>(
        () => _i818.MovieDetailsUseCases(gh<_i682.MovieDetailsRepo>()));
    gh.factory<_i221.UpdateUserListUC>(
        () => _i221.UpdateUserListUC(gh<_i682.MovieDetailsRepo>()));
    gh.factory<_i901.WatchMovieFromUrlUC>(
        () => _i901.WatchMovieFromUrlUC(gh<_i682.MovieDetailsRepo>()));
    gh.factory<_i310.UpdateProfileUseCases>(
        () => _i310.UpdateProfileUseCases(gh<_i47.UpdateProfileRepo>()));
    gh.factory<_i677.DeleteUserUC>(
        () => _i677.DeleteUserUC(gh<_i47.UpdateProfileRepo>()));
    gh.factory<_i465.UpdateUserDataUC>(
        () => _i465.UpdateUserDataUC(gh<_i47.UpdateProfileRepo>()));
    gh.factory<_i206.UpdateProfileCubit>(
        () => _i206.UpdateProfileCubit(gh<_i310.UpdateProfileUseCases>()));
    gh.factory<_i738.CurrUserUC>(() => _i738.CurrUserUC(gh<_i762.UserRepo>()));
    gh.factory<_i607.SignOutUC>(() => _i607.SignOutUC(gh<_i762.UserRepo>()));
    gh.factory<_i262.UserUseCases>(
        () => _i262.UserUseCases(gh<_i762.UserRepo>()));
    gh.factory<_i451.BrowseMoviesUC>(
        () => _i451.BrowseMoviesUC(gh<_i1036.MoviesRepository>()));
    gh.factory<_i973.GetRecentMoviesUC>(
        () => _i973.GetRecentMoviesUC(gh<_i1036.MoviesRepository>()));
    gh.factory<_i890.ListLimitMoviesByGenreUC>(
        () => _i890.ListLimitMoviesByGenreUC(gh<_i1036.MoviesRepository>()));
    gh.factory<_i400.GetMoviesByIDsUC>(
        () => _i400.GetMoviesByIDsUC(gh<_i1036.MoviesRepository>()));
    gh.factory<_i530.SearchMoviesUC>(
        () => _i530.SearchMoviesUC(gh<_i1036.MoviesRepository>()));
    gh.factory<_i61.MoviesUseCases>(
        () => _i61.MoviesUseCases(gh<_i1036.MoviesRepository>()));
    gh.factory<_i925.HomeCubit>(() => _i925.HomeCubit(
          gh<_i61.MoviesUseCases>(),
          gh<_i262.UserUseCases>(),
        ));
    gh.factory<_i934.ForgetPasswordUseCase>(
        () => _i934.ForgetPasswordUseCase(gh<_i561.AuthRepository>()));
    gh.factory<_i394.LoginUseCase>(
        () => _i394.LoginUseCase(gh<_i561.AuthRepository>()));
    gh.factory<_i445.RegisterUseCase>(
        () => _i445.RegisterUseCase(gh<_i561.AuthRepository>()));
    gh.factory<_i660.ForgetPassCubit>(
        () => _i660.ForgetPassCubit(gh<_i934.ForgetPasswordUseCase>()));
    gh.factory<_i782.LoginCubit>(
        () => _i782.LoginCubit(gh<_i394.LoginUseCase>()));
    gh.factory<_i584.RegisterCubit>(
        () => _i584.RegisterCubit(gh<_i445.RegisterUseCase>()));
    gh.factory<_i699.MovieDetailsCubit>(
        () => _i699.MovieDetailsCubit(gh<_i818.MovieDetailsUseCases>()));
    return this;
  }
}
