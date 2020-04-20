import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:kazpost_tracker/core/network/network_info.dart';
import 'package:kazpost_tracker/features/tracking/data/app_database.dart';
import 'package:kazpost_tracker/features/tracking/data/datasources/track_remote_datasource.dart';
import 'package:kazpost_tracker/features/tracking/data/repositories/track_repository_impl.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/delete_track.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_history.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/get_track_list.dart';
import 'package:kazpost_tracker/features/tracking/domain/usecases/save_track.dart';
import 'package:sembast/sembast.dart';

import 'features/tracking/data/datasources/track_local_datasource.dart';
import 'features/tracking/domain/repositories/track_repository.dart';
import 'features/tracking/domain/usecases/get_track_details.dart';
import 'features/tracking/presentation/bloc/track_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Tracking
  // Bloc
  sl.registerFactory(() => TrackBloc(
        getTrackDetails: sl(),
        getTrackHistory: sl(),
        getTrackList: sl(),
        saveTrack: sl(),
        deleteTrack: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetTrackDetails(sl()));
  sl.registerLazySingleton(() => GetTrackList(sl()));
  sl.registerLazySingleton(() => GetTrackHistory(sl()));
  sl.registerLazySingleton(() => SaveTrack(sl()));
  sl.registerLazySingleton(() => DeleteTrack(sl()));

  // Repository
  sl.registerLazySingleton<TrackRepository>(() => TrackRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<TrackLocalDataSource>(() => TrackLocalDataSourceImpl(
        database: sl(),
        tracks: sl<StoreRef<String, Map<String, dynamic>>>(param1: 'parcels'),
        details: sl<StoreRef<String, Map<String, dynamic>>>(param1: 'details'),
        history: sl<StoreRef<String, Map<String, dynamic>>>(param1: 'history'),
      ));
  sl.registerLazySingleton<TrackRemoteDataSource>(
      () => TrackRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => AppDatabase());
  // sl.registerLazySingleton(() => stringMapStoreFactory.store('tracks'));
  // sl.registerLazySingleton(() => stringMapStoreFactory.store('details'));
  // sl.registerLazySingleton(() => stringMapStoreFactory.store('history'));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerFactoryParam<StoreRef<String, Map<String, dynamic>>, String, void>((s, _) => stringMapStoreFactory.store(s));

}
