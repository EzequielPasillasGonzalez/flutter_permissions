// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:reforzamiento/config/const/enviroment.dart';

import 'package:reforzamiento/features/pokemons/domain/domain.dart';
import 'package:reforzamiento/features/pokemons/infrastructure/infrastructure.dart';
import 'package:reforzamiento/features/shared/custom_erro.dart';

class PokemonsDatasourceImpl extends PokemonsDatasource {
  late final Dio dio;

  PokemonsDatasourceImpl()
    : dio = Dio(BaseOptions(baseUrl: Enviroment.pokeApi));

  @override
  Future<Pokemon> getPokemonById(int id) async {
    try {
      final response = await dio.get('/pokemon/$id');

      final pokeApiResponse = PokeapiPokemonResponse.fromJson(response.data);

      return PokemonMapper.pokeapiPokemonResponseToEntity(pokeApiResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          message: e.response?.data['message'] ?? 'Expiro la sesión',
        );
      }
      if (e.type == DioExceptionType.receiveTimeout) throw ConnectionTimeout();
      throw CustomError(
        message: 'Error al obtener pokemons: ${e.message}',
        // errorCode: 1
      );
    } catch (e) {
      throw CustomError(
        message: 'Un error inesperado',
        // errorCode: 1
      );
    }
  }

  @override
  Future<List<SimplePokemon>> getPokemonsByPage({
    int limit = 20,
    offset = 0,
  }) async {
    try {
      final response = await dio.get(
        '/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      final List<SimplePokemon> pokemons = [];

      for (var pokemon in response.data["results"] ?? []) {
        pokemons.add(SimplePokemonMapper.jsonToEntity(pokemon));
      }

      return pokemons;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          message: e.response?.data['message'] ?? 'Expiro la sesión',
        );
      }
      if (e.type == DioExceptionType.receiveTimeout) throw ConnectionTimeout();
      throw CustomError(
        message: 'Error al obtener pokemons: ${e.message}',
        // errorCode: 1
      );
    } catch (e) {
      throw CustomError(
        message: 'Un error inesperado',
        // errorCode: 1
      );
    }
  }
}
