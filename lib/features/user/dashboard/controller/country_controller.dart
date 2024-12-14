// import '../../../../core/type_defs.dart';
//
// class CountryController{
//   @override
//   FutureEither<AdminAllCountriesNamesModel> getAllCountries()async{
//     try{
//       final response = await dioClient.get(
//         "http://masjidapp.azrafnetworks.net/api/get-country-state-city/countries",
//         options: Options(
//           receiveTimeout: const Duration(seconds: 30),
//         ),
//       );
//
//       return Right(AdminAllCountriesNamesModel.fromJson(response));
//     } catch (error, st) {
//       return Left(Failure(error.toString(), st));
//     }
//   }
//
//   @override
//   FutureEither<AdminAllStatesNamesModel> getAllStates({required String countryId})async{
//     try{
//       final response = await dioClient.get(
//         "http://masjidapp.azrafnetworks.net/api/get-country-state-city/state/${countryId}",
//         options: Options(
//           receiveTimeout: const Duration(seconds: 30),
//         ),
//       );
//
//       return Right(AdminAllStatesNamesModel.fromJson(response));
//     } catch (error, st) {
//       return Left(Failure(ErrorHandler.handle(error).failure, st));
//     }
//   }
//
//   @override
//   FutureEither<AdminAllCitiesNamesModel> getAllCities({required String stateId})async{
//     try{
//       final response = await dioClient.get(
//         'http://masjidapp.azrafnetworks.net/api/get-country-state-city/city/${stateId}',
//         options: Options(
//           receiveTimeout: const Duration(seconds: 30),
//         ),
//       );
//
//       return Right(AdminAllCitiesNamesModel.fromJson(response));
//     } catch (error, st) {
//       return Left(Failure(ErrorHandler.handle(error).failure, st));
//     }
//   }
// }


import 'package:dio/dio.dart';
import '../../../../commons/common_imports/apis_commons.dart';
import '../../../../models/city_model/city_model.dart';
import '../../../../models/country_model/country_model.dart';
import '../../../../models/state_model/state_model.dart';


final countryControllerProvider = Provider<CountryController>((ref) {
  final dio = Dio();
  return CountryController(dio);
});

final getAllCountriesProvider = FutureProvider<AdminAllCountriesNamesModel>((ref) async {
  final countryController = ref.watch(countryControllerProvider);
  final result = await countryController.getAllCountries();
  return result.fold(
          (failure) => throw failure.message,
          (countries) => countries
  );
});

final getAllStatesProvider = FutureProvider.family<AdminAllStatesNamesModel, String>((ref, countryId) async {
  final countryController = ref.watch(countryControllerProvider);
  final result = await countryController.getAllStates(countryId: countryId);

  return result.fold(
          (failure) => throw failure.message,
          (states) => states
  );
});

final getAllCitiesProvider = FutureProvider.family<AdminAllCitiesNamesModel, String>((ref, stateId) async {
  final countryController = ref.watch(countryControllerProvider);
  final result = await countryController.getAllCities(stateId: stateId);
  return result.fold(
          (failure) => throw failure.message,
          (cities) => cities
  );
});



class CountryController {
  final Dio dioClient;

  CountryController(this.dioClient);

  final String apiKey = '3987-7e430b7f-c2a2064f-9399b5af-8011dc67139c0a50d45';

  FutureEither<AdminAllCountriesNamesModel> getAllCountries() async {
    try {
      final response = await dioClient.get(
        "http://masjidapp.azrafnetworks.net/api/get-country-state-city/countries",
        options:
        Options(
          headers: {
            'apikey': apiKey,
          },
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      return Right(AdminAllCountriesNamesModel.fromJson(response.data));
    } catch (error, st) {
      return Left(Failure(error.toString(), st));
    }
  }

  FutureEither<AdminAllStatesNamesModel> getAllStates({required String countryId}) async {
    try {
      final response = await dioClient.get(
        "http://masjidapp.azrafnetworks.net/api/get-country-state-city/state/$countryId",
        options:
        Options(
          headers: {
            'apikey': apiKey,
          },
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      return Right(AdminAllStatesNamesModel.fromJson(response.data));
    } catch (error, st) {
      return Left(Failure(error.toString(), st));
    }
  }

  FutureEither<AdminAllCitiesNamesModel> getAllCities({required String stateId}) async {
    try {
      final response = await dioClient.get(
        'http://masjidapp.azrafnetworks.net/api/get-country-state-city/city/$stateId',
        options: Options(
          headers: {
            'apikey': apiKey,
          },
          receiveTimeout: const Duration(seconds: 30),
        ),
        // Options(
        //   receiveTimeout: const Duration(seconds: 30),
        // ),
      );

      return Right(AdminAllCitiesNamesModel.fromJson(response.data));
    } catch (error, st) {
      return Left(Failure(error.toString(), st));
    }
  }
}


class AdminAllCountriesNamesModel {
  final List<Country> countries;

  AdminAllCountriesNamesModel({required this.countries});

  factory AdminAllCountriesNamesModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final countriesList = (data['countries'] as List)
        .map((country) => Country.fromJson(country))
        .toList();

    return AdminAllCountriesNamesModel(
      countries: countriesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countries': countries.map((country) => country.toJson()).toList(),
    };
  }
}

class AdminAllStatesNamesModel {
  final List<StateModel> states;

  AdminAllStatesNamesModel({required this.states});

  factory AdminAllStatesNamesModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return AdminAllStatesNamesModel(
      states: (data['states'] as List)
          .map((state) => StateModel.fromJson(state))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'states': states.map((state) => state.toJson()).toList(),
    };
  }
}

class AdminAllCitiesNamesModel {
  final List<City> cities;

  AdminAllCitiesNamesModel({required this.cities});

  factory AdminAllCitiesNamesModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return AdminAllCitiesNamesModel(
      cities: (data['cities'] as List)
          .map((city) => City.fromJson(city))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cities': cities.map((city) => city.toJson()).toList(),
    };
  }
}