import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/data/models/raw/raw_favourite.dart';
import 'package:frontend/data/repositories/pokemon_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository mockedPokemonRepo;

  late Pokemon testPokemon1;
  late Pokemon testPokemon2;
  late Region testRegion1;
  late Region testRegion2;
  late List<Type> testTypes;
  late Evolution testEvolution;
  late RawFavourite testFavourite;

  setUp(() {
    mockedPokemonRepo = MockPokemonRepository();
    testFavourite = const RawFavourite(id: 1, user_id: 1, pokemon_id: 1);
    testEvolution = const Evolution(id: 1, pokemonId: 1, evolvesToId: 2);
    testTypes = [
      const Type(
        id: 1,
        name: "Electric",
        color: "Yellow",
        isWeakness: WeaknessStatus.no,
        imgUrl: "https://example.com/electric.png",
        imgUrlOutline: "https://example.com/electricOutline.png",
      ),
      const Type(
        id: 2,
        name: "Fire",
        color: "Red",
        isWeakness: WeaknessStatus.yes,
        imgUrl: "https://example.com/fire.png",
        imgUrlOutline: "https://example.com/fireOutline.png",
      ),
    ];
    testRegion1 = const Region(
      id: 1,
      name: "Kanto",
      difficulty: 1,
      imgUrl: "https://example.com/kanto.png",
    );
    testRegion2 = const Region(
      id: 2,
      name: "Johto",
      difficulty: 2,
      imgUrl: "https://example.com/johto.png",
    );
    testPokemon1 = Pokemon(
      id: 1,
      name: "Pikachu",
      level: 1,
      gender: 1,
      height: 1,
      weight: 1,
      ability: "Static",
      category: "Mouse",
      description: "A yellow electric mouse",
      isBaseForm: false,
      imgUrl: "https://example.com/pikachu.png",
      isFavourited: false,
      regionId: 1,
      types: testTypes,
    );
    testPokemon2 = Pokemon(
      id: 2,
      name: "Bulbasaur",
      level: 2,
      gender: 2,
      height: 2,
      weight: 2,
      ability: "Bulb",
      category: "Plant",
      description: "A bulb",
      isBaseForm: true,
      imgUrl: "https://example.com/bulb.png",
      isFavourited: false,
      regionId: 2,
      types: [testTypes[1]],
    );
  });

  group("Asynchronous pokemon event", () {
    blocTest<PokemonBloc, PokemonState>(
      'emits [loading, success] when fetching data succeeds',
      setUp: () {
        when(() => mockedPokemonRepo.getAllPokemons(any()))
            .thenAnswer((_) async => [testPokemon1]);
        when(() => mockedPokemonRepo.getAllTypes())
            .thenAnswer((_) async => testTypes);
        when(() => mockedPokemonRepo.getAllRegions())
            .thenAnswer((_) async => [testRegion1]);
        when(() => mockedPokemonRepo.getAllEvolutions())
            .thenAnswer((_) async => [testEvolution]);
      },
      build: () => PokemonBloc(mockedPokemonRepo),
      act: (bloc) => bloc.add(GetPokemonEvent(token: "userToken")),
      expect: () => [
        const PokemonState(status: PokemonStatus.loading),
        PokemonState(
          status: PokemonStatus.success,
          pokemons: {testPokemon1.id: testPokemon1},
          filteredPokemons: [testPokemon1],
          types: testPokemon1.types,
          regions: [testRegion1],
          evolutions: [testEvolution],
        ),
      ],
    );

    blocTest(
      "emits [loading, failure] when exception is thrown",
      build: () => PokemonBloc(mockedPokemonRepo),
      setUp: () => when(() => mockedPokemonRepo.getAllPokemons(any()))
          .thenThrow(Exception("Failed to fetch pokemons")),
      act: (bloc) {
        bloc.add(GetPokemonEvent(token: "userToken"));
      },
      expect: () => [
        const PokemonState(status: PokemonStatus.loading),
        const PokemonState(
          status: PokemonStatus.failure,
          error: "Exception: Failed to fetch pokemons",
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      "emits [success] when pokemon is favourited",
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        pokemons: {testPokemon1.id: testPokemon1},
      ),
      setUp: () {
        when(() =>
                mockedPokemonRepo.addFavouritePokemon(any(), testPokemon1.id))
            .thenAnswer((_) async => testFavourite);
      },
      act: (bloc) {
        bloc.add(FavouriteEvent(pokemon: testPokemon1, token: "userToken"));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.success,
          pokemons: {
            testPokemon1.id: testPokemon1.copyWith(isFavourited: true),
          },
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      "emits [success] when pokemon is un-favourited",
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        pokemons: {
          testPokemon1.id: testPokemon1.copyWith(isFavourited: true),
        },
      ),
      setUp: () {
        when(() => mockedPokemonRepo.removeFavouritePokemon(
            any(), testPokemon1.id)).thenAnswer((_) async => []);
      },
      act: (bloc) {
        bloc.add(FavouriteEvent(
            pokemon: testPokemon1.copyWith(isFavourited: true),
            token: "userToken"));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.success,
          pokemons: {
            testPokemon1.id: testPokemon1.copyWith(isFavourited: false),
          },
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      "emits [success, failure] when pokemon is favourited and fails on server",
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        pokemons: {testPokemon1.id: testPokemon1},
      ),
      setUp: () {
        when(() =>
                mockedPokemonRepo.addFavouritePokemon(any(), testPokemon1.id))
            .thenThrow(Exception("Failed to add favourite"));
      },
      act: (bloc) {
        bloc.add(FavouriteEvent(pokemon: testPokemon1, token: "userToken"));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.success,
          pokemons: {
            testPokemon1.id: testPokemon1.copyWith(isFavourited: true),
          },
        ),
        PokemonState(
          status: PokemonStatus.failure,
          error: "Exception: Failed to add favourite",
          pokemons: {
            testPokemon1.id: testPokemon1,
          },
        ),
      ],
    );
  });

  group("Filter and order pokemon event", () {
    blocTest(
      'emits [updated] when sorting by type',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        pokemons: {
          testPokemon1.id: testPokemon1,
          testPokemon2.id: testPokemon2
        },
      ),
      skip: 1,
      act: (bloc) {
        bloc.add(SortPokemonByTypeEvent(dropDownValue: testTypes[0].name));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          pokemons: {
            testPokemon1.id: testPokemon1,
            testPokemon2.id: testPokemon2
          },
          filteredPokemons: [testPokemon1],
          dropDownValue1: "Electric",
        ),
      ],
    );

    blocTest(
      'emits [updated] when ordering by id',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        pokemons: {
          testPokemon1.id: testPokemon1,
          testPokemon2.id: testPokemon2
        },
      ),
      skip: 1,
      act: (bloc) {
        bloc.add(OrderPokemonByIdEvent(dropDownValue: "Descending"));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          pokemons: {
            testPokemon1.id: testPokemon1,
            testPokemon2.id: testPokemon2
          },
          filteredPokemons: [
            testPokemon2,
            testPokemon1,
          ],
          dropDownValue2: "Descending",
        ),
      ],
    );

    blocTest(
      'emits [updated] when sorting by region',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        pokemons: {
          testPokemon1.id: testPokemon1,
          testPokemon2.id: testPokemon2
        },
      ),
      skip: 1,
      act: (bloc) {
        bloc.add(SortPokemonByRegionEvent(region: testRegion1));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          regionFilter: testRegion1,
          pokemons: {
            testPokemon1.id: testPokemon1,
            testPokemon2.id: testPokemon2
          },
          filteredPokemons: [testPokemon1],
          searchBarValue: "",
        ),
      ],
    );

    blocTest(
      'emits [updated] when reseting the search bar',
      build: () => PokemonBloc(mockedPokemonRepo),
      act: (bloc) {
        bloc.add(ResetSearchBarEvent());
      },
      expect: () => [
        const PokemonState(
          status: PokemonStatus.initial,
          searchBarValue: "",
        ),
      ],
    );

    blocTest(
      'emits [updated] when sorting by name',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        pokemons: {
          testPokemon1.id: testPokemon1,
          testPokemon2.id: testPokemon2
        },
      ),
      act: (bloc) {
        bloc.add(SortPokemonByNameEvent(searchBarValue: testPokemon1.name));
      },
      skip: 1,
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          searchBarValue: testPokemon1.name,
          pokemons: {
            testPokemon1.id: testPokemon1,
            testPokemon2.id: testPokemon2
          },
          filteredPokemons: [testPokemon1],
        ),
      ],
    );
  });

  group("Synchronous pokemon event", () {
    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when updating a region.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        status: PokemonStatus.initial,
        regions: [testRegion1, testRegion2],
      ),
      act: (bloc) {
        final updatedRegion = testRegion2.copyWith(name: "Updated Region");
        bloc.add(UpdateRegionEvent(region: updatedRegion));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          regions: [testRegion1, testRegion2.copyWith(name: "Updated Region")],
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when deleting a region.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        status: PokemonStatus.initial,
        regions: [testRegion1, testRegion2],
      ),
      act: (bloc) {
        bloc.add(DeleteRegionEvent(region: testRegion2));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          regions: [testRegion1],
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when creating a region.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        status: PokemonStatus.initial,
        regions: [testRegion1],
      ),
      act: (bloc) {
        bloc.add(CreateNewRegionEvent(newRegion: testRegion2));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          regions: [testRegion1, testRegion2],
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when deleting a pokemon.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        status: PokemonStatus.initial,
        pokemons: {
          testPokemon1.id: testPokemon1,
          testPokemon2.id: testPokemon2
        },
      ),
      act: (bloc) {
        bloc.add(DeletePokemonEvent(pokemon: testPokemon2));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          pokemons: {
            testPokemon1.id: testPokemon1,
          },
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when creating a pokemon.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(
        status: PokemonStatus.initial,
        pokemons: {
          testPokemon1.id: testPokemon1,
        },
      ),
      act: (bloc) {
        bloc.add(CreateNewPokemonEvent(
          pokemons: [testPokemon2],
          evolutions: [testEvolution],
        ));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          pokemons: {
            testPokemon1.id: testPokemon1,
            testPokemon2.id: testPokemon2,
          },
          evolutions: [testEvolution],
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when creating a type.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () =>
          PokemonState(status: PokemonStatus.initial, types: [testTypes[0]]),
      act: (bloc) {
        bloc.add(CreateNewTypeEvent(newType: testTypes[1]));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          types: [testTypes[0], testTypes[1]],
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when deleting a type.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(status: PokemonStatus.initial, types: testTypes),
      act: (bloc) {
        bloc.add(DeleteTypeEvent(type: testTypes[1]));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          types: [testTypes[0]],
        ),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [updated] when updating a type.',
      build: () => PokemonBloc(mockedPokemonRepo),
      seed: () => PokemonState(status: PokemonStatus.initial, types: testTypes),
      act: (bloc) {
        final updatedType = testTypes[1].copyWith(name: "Updated Type");
        bloc.add(UpdateTypeEvent(type: updatedType));
      },
      expect: () => [
        PokemonState(
          status: PokemonStatus.initial,
          types: [testTypes[0], testTypes[1].copyWith(name: "Updated Type")],
        ),
      ],
    );
  });
}
