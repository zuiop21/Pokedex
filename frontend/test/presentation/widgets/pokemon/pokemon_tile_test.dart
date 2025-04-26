import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/business_logic/bloc/pokemon_bloc.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/type.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_tile.dart';
import 'package:frontend/presentation/widgets/pokemon/pokemon_tile_types.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../views/onboarding/onboarding_view_test.dart';

class MockPokemonBloc extends MockBloc<PokemonEvent, PokemonState>
    implements PokemonBloc {}

void main() {
  late MockPokemonBloc pokemonBloc;

  setUpAll(() {
    registerFallbackValue(MaterialPageRoute(builder: (_) => const SizedBox()));
  });

  setUp(() {
    pokemonBloc = MockPokemonBloc();
  });

  testWidgets(
      'given a pokemon when tile is loaded then check if tile appears correct',
      (tester) async {
    final testTypes = [
      const Type(
        id: 1,
        name: "Electric",
        color: "0xFF0000FF",
        isWeakness: WeaknessStatus.no,
        imgUrl: "https://example.com/electric.png",
        imgUrlOutline: "https://example.com/electricOutline.png",
      ),
      const Type(
        id: 2,
        name: "Fire",
        color: "0xFFFF00FF",
        isWeakness: WeaknessStatus.yes,
        imgUrl: "https://example.com/fire.png",
        imgUrlOutline: "https://example.com/fireOutline.png",
      ),
    ];

    final testPokemon = Pokemon(
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

    final navigatorObserver = MockNavigatorObserver();

    // Setup: Mock the stream to emit a PokemonState where Pikachu is in pokemons
    whenListen(
      pokemonBloc,
      Stream<PokemonState>.fromIterable([
        PokemonState(
          status: PokemonStatus.success,
          pokemons: {1: testPokemon},
        )
      ]),
      initialState: PokemonState(
        status: PokemonStatus.success,
        pokemons: {1: testPokemon},
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        navigatorObservers: [navigatorObserver],
        onGenerateRoute: (settings) {
          if (settings.name == "/pokemon/info") {
            return MaterialPageRoute(
              builder: (_) => const Text('Dummy Screen'),
            );
          }
          return null;
        },
        home: BlocProvider<PokemonBloc>.value(
          value: pokemonBloc,
          child: const PokemonTile(pokemonId: 1),
        ),
      ),
    );

    // Check widget appearance
    expect(find.text('Pikachu'), findsOneWidget);
    expect(find.text('Electric'), findsOneWidget);
    expect(find.text('Fire'), findsNothing);
    expect(find.text('Number 1'), findsOneWidget);

    expect(find.byType(PokemonTileTypes), findsOneWidget);

    final icons = tester.widgetList<Icon>(find.byType(Icon)).toList();

    final favouriteIcon = icons.firstWhere(
      (icon) => icon.icon == Icons.favorite_border_outlined,
    );

    expect(favouriteIcon.color, Colors.white);

    final button = find.byKey(const Key("pokemon_tile"));
    expect(button, findsOneWidget);

    //Check navigation
    await tester.tap(button);
    await tester.pumpAndSettle();

    verify(() => navigatorObserver.didPush(any(), any())).called(2);
  });
}
