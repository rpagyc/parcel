import 'dart:async';

import 'package:kazpost_tracker/data/parcel.dart';
import 'package:kazpost_tracker/data/parcel_dao.dart';
import 'package:rxdart/rxdart.dart';

class ParcelBloc {
  static final ParcelBloc _instance = ParcelBloc._();
  factory ParcelBloc() => _instance;
  BehaviorSubject<List<Parcel>> _parcels; 
  ParcelDao _parcelDao;
  ParcelBloc._() {
    _parcelDao =  ParcelDao();
    _parcels = BehaviorSubject<List<Parcel>>.seeded(<Parcel>[]);
    reload();
  }

  ValueObservable<List<Parcel>> get stream$ => _parcels.stream;

  Future putParcel(Parcel parcel) async {
    await _parcelDao.put(parcel);
    await reload();
  }

  Future reload() async {
    _parcels.add(await _parcelDao.getAllParcels());
  }

  Future deleteParcel(String trackId) async {
    await _parcelDao.delete(trackId);
    await reload();
  }
}
