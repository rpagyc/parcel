import 'package:kazpost_tracker/data/app_database.dart';
import 'package:kazpost_tracker/data/parcel.dart';
import 'package:sembast/sembast.dart';

class ParcelDao {
  static const String PARCEL_STORE_NAME = 'parcels';
  final _parcelStore = stringMapStoreFactory.store(PARCEL_STORE_NAME);

  Future<Database> get _db async => await AppDatabase().database;

  Future delete(String trackId) async {
    final finder = Finder(filter: Filter.byKey(trackId));
    await _parcelStore.delete(await _db, finder: finder);
  }

  Future<List<Parcel>> getAllParcels() async {
    final recordSnashots = await _parcelStore.find(await _db);
    return recordSnashots.map((snapshot){
      final parcel = Parcel.fromMap(snapshot.value);
      return parcel;
    }).toList();
  }

  Future put(Parcel parcel) async {
    await _parcelStore.record(parcel.trackId).put(await _db, parcel.toMap());
  }
}
