import 'package:get_it/get_it.dart';
import '../api/pokemon_api.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => PokemonApiProvider());
}
