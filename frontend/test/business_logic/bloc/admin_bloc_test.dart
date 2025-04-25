import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/business_logic/bloc/admin_bloc.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:frontend/data/repositories/admin_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/data/models/processed/type.dart';

class MockAdminRepository extends Mock implements AdminRepository {}

void main() {
  late MockAdminRepository mockedAdminRepo;
  late String testToken;
  late User testUser;

  late File testFileOutline;

  late Pokemon testPokemon2;

  late List<Type> testTypes;

  final Region testRegion1 = const Region(
    id: 1,
    name: "Test Region",
    imgUrl: "https://example.com/test_region.png",
    difficulty: 1,
  );

  final testEvolution = const Evolution(
    id: 1,
    pokemonId: 1,
    evolvesToId: null,
    condition: "Level 10",
  );

  final testFile = File('test_image.png');
  final testPokemon1 = const Pokemon(
    id: 1,
    level: 5,
    gender: 0,
    height: 1.0,
    weight: 10.0,
    name: "Test Pokemon",
    ability: "Test Ability",
    category: "Test Category",
    description: "Test Description",
    isBaseForm: true,
    imgUrl: "",
    isFavourited: false,
    regionId: 1,
    types: [],
  );

  setUpAll(() {
    registerFallbackValue(testPokemon1);
    registerFallbackValue(testEvolution);
    registerFallbackValue(testFile);
    registerFallbackValue(testRegion1);
  });

  setUp(() {
    mockedAdminRepo = MockAdminRepository();

    testFileOutline = File("testFileOutline");
    testTypes = [
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
    testToken = "adminToken";
    testUser = const User(
        id: 1,
        role: "admin",
        regionId: 1,
        name: "userName",
        email: "email",
        isLocked: false);
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
  group("Admin user events", () {
    blocTest(
      "emits [loading, success] when users are loaded",
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) {
        bloc.add(GetAllUsersEvent(token: testToken));
      },
      setUp: () {
        when(() => mockedAdminRepo.getAllUsers(any()))
            .thenAnswer((_) async => []);
      },
      expect: () => [
        const AdminState(status: AdminStatus.loading),
        const AdminState(
          status: AdminStatus.success,
          users: [],
        ),
      ],
    );
    blocTest(
      "emits [loading, failure] when users fail to load",
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) {
        bloc.add(GetAllUsersEvent(token: testToken));
      },
      setUp: () {
        when(() => mockedAdminRepo.getAllUsers(any()))
            .thenThrow(Exception("Failed to load users"));
      },
      expect: () => [
        const AdminState(status: AdminStatus.loading),
        const AdminState(
          status: AdminStatus.failure,
          error: "Exception: Failed to load users",
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [loading, success] when updating user by id.',
      build: () => AdminBloc(mockedAdminRepo),
      setUp: () {
        when(() => mockedAdminRepo.updateUserById(any(), any()))
            .thenAnswer((_) async => testUser.copyWith(role: "user"));
      },
      seed: () => AdminState(
        status: AdminStatus.success,
        users: [testUser],
      ),
      act: (bloc) => bloc.add(UpdateUserByIdEvent(token: testToken, userId: 1)),
      expect: () => [
        AdminState(status: AdminStatus.loading, users: [testUser]),
        AdminState(
          status: AdminStatus.success,
          users: [testUser.copyWith(role: "user")],
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [loading, failure] when updating user by id fails.',
      build: () => AdminBloc(mockedAdminRepo),
      setUp: () {
        when(() => mockedAdminRepo.updateUserById(any(), any()))
            .thenThrow(Exception("Failed to update user"));
      },
      seed: () => AdminState(
        status: AdminStatus.success,
        users: [testUser],
      ),
      act: (bloc) => bloc.add(UpdateUserByIdEvent(token: testToken, userId: 1)),
      expect: () => [
        AdminState(status: AdminStatus.loading, users: [testUser]),
        AdminState(
          status: AdminStatus.failure,
          users: [testUser],
          error: "Exception: Failed to update user",
        ),
      ],
    );
  });

  group(
    "Admin type events",
    () {
      blocTest(
        "emits [updating] when starting to update type",
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(
          StartUpdatingTypeEvent(
            type: testTypes[0],
          ),
        ),
        expect: () => [
          AdminState(
              status: AdminStatus.updating, placeholderType: testTypes[0]),
        ],
      );

      blocTest(
        "emits [loading, success] when types are created",
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.success,
          placeholderType: testTypes[0],
          placeholderFile: testFile,
          placeholderFileOutline: testFileOutline,
        ),
        act: (bloc) {
          bloc.add(CreateTypeEvent(
            token: testToken,
            name: "newType",
          ));
        },
        setUp: () {
          when(() =>
                  mockedAdminRepo.createType(any(), any(), any(), any(), any()))
              .thenAnswer((_) async => testTypes[0]);
        },
        expect: () => [
          AdminState(
            status: AdminStatus.loading,
            placeholderType: testTypes[0],
            placeholderFile: testFile,
            placeholderFileOutline: testFileOutline,
          ),
          AdminState(
            status: AdminStatus.created,
            placeholderType: testTypes[0],
            placeholderFile: testFile,
            placeholderFileOutline: testFileOutline,
          ),
        ],
      );

      blocTest(
        "emits [loading, failure] when types fail to create",
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.success,
          placeholderType: testTypes[0],
          placeholderFile: testFile,
          placeholderFileOutline: testFileOutline,
        ),
        act: (bloc) {
          bloc.add(CreateTypeEvent(
            token: testToken,
            name: "newType",
          ));
        },
        setUp: () {
          when(() =>
                  mockedAdminRepo.createType(any(), any(), any(), any(), any()))
              .thenThrow(Exception("Failed to create type"));
        },
        expect: () => [
          AdminState(
            status: AdminStatus.loading,
            placeholderType: testTypes[0],
            placeholderFile: testFile,
            placeholderFileOutline: testFileOutline,
          ),
          AdminState(
            status: AdminStatus.failure,
            error: "Exception: Failed to create type",
            placeholderType: testTypes[0],
            placeholderFile: testFile,
            placeholderFileOutline: testFileOutline,
          ),
        ],
      );

      blocTest(
        "emits [currentState] when type is visually updated",
        build: () {
          return AdminBloc(mockedAdminRepo);
        },
        seed: () => AdminState(
          status: AdminStatus.success,
          placeholderType: testTypes[0],
        ),
        act: (bloc) {
          bloc.add(
            UpdateTypeVisuallyEvent(
              newR: 1.0,
              newG: 1.0,
              newB: 1.0,
            ),
          );
        },
        expect: () {
          return [
            AdminState(
              status: AdminStatus.success,
              placeholderType: testTypes[0].copyWith(
                color: "0xFFFFFFFF",
              ),
            ),
          ];
        },
      );

      blocTest(
        "emits [loading, updated] when updating type",
        build: () {
          return AdminBloc(mockedAdminRepo);
        },
        seed: () => AdminState(
          status: AdminStatus.success,
          placeholderType: testTypes[0],
        ),
        act: (bloc) {
          bloc.add(
            UpdateTypeByIdEvent(
              token: testToken,
              name: "newType",
            ),
          );
        },
        setUp: () {
          when(() => mockedAdminRepo.updateTypeById(
                  testToken, testTypes[0].id, "newType",
                  color: testTypes[0].color))
              .thenAnswer(
                  (_) async => testTypes[0].copyWith(name: "updatedType"));
        },
        expect: () {
          return [
            AdminState(
              status: AdminStatus.loading,
              placeholderType: testTypes[0],
            ),
            AdminState(
              status: AdminStatus.updated,
              placeholderType: testTypes[0].copyWith(name: "updatedType"),
            ),
          ];
        },
      );

      blocTest(
        "emits [loading, failure] when updating type fails",
        build: () {
          return AdminBloc(mockedAdminRepo);
        },
        seed: () => AdminState(
          status: AdminStatus.success,
          placeholderType: testTypes[0],
        ),
        act: (bloc) {
          bloc.add(
            UpdateTypeByIdEvent(
              token: testToken,
              name: "newType",
            ),
          );
        },
        setUp: () {
          when(() => mockedAdminRepo.updateTypeById(
                  testToken, testTypes[0].id, "newType",
                  color: testTypes[0].color))
              .thenThrow(Exception("Failed to update type"));
        },
        expect: () {
          return [
            AdminState(
              status: AdminStatus.loading,
              placeholderType: testTypes[0],
            ),
            AdminState(
              status: AdminStatus.failure,
              error: "Exception: Failed to update type",
              placeholderType: testTypes[0],
            ),
          ];
        },
      );

      blocTest(
        "emits [loading, popped] when types are deleted",
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => const AdminState(
          status: AdminStatus.success,
        ),
        act: (bloc) {
          bloc.add(DeleteTypeByIdEvent(token: testToken, type: testTypes[0]));
        },
        setUp: () {
          when(() => mockedAdminRepo.deleteTypeById(any(), any()))
              .thenAnswer((_) async {});
        },
        expect: () => [
          const AdminState(
            status: AdminStatus.loading,
          ),
          AdminState(
            status: AdminStatus.popped,
            deletedType: testTypes[0],
          ),
        ],
      );

      blocTest(
        "emits [loading, failure] when types fail to delete",
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => const AdminState(
          status: AdminStatus.success,
        ),
        act: (bloc) {
          bloc.add(DeleteTypeByIdEvent(token: testToken, type: testTypes[0]));
        },
        setUp: () {
          when(() => mockedAdminRepo.deleteTypeById(any(), any()))
              .thenThrow(Exception("Failed to delete type"));
        },
        expect: () => [
          const AdminState(
            status: AdminStatus.loading,
          ),
          const AdminState(
            status: AdminStatus.failure,
            error: "Exception: Failed to delete type",
          ),
        ],
      );
      blocTest<AdminBloc, AdminState>(
        'emits [creating] when starting to create a type.',
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(StartCreatingTypeEvent()),
        expect: () => [
          const AdminState(
            status: AdminStatus.creating,
            placeholderType: Type(
              id: 0,
              name: "",
              color: "0x00000000",
              isWeakness: WeaknessStatus.both,
              imgUrl: "",
              imgUrlOutline: "",
            ),
          ),
        ],
      );
    },
  );

  group(
    "Admin pokemon events",
    () {
      blocTest<AdminBloc, AdminState>(
        'emits [currentState] when index == 0',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          newEvolutions: [testEvolution],
        ),
        act: (bloc) => bloc.add(StartPokemonCreationEvent(index: 0)),
        expect: () => [
          AdminState(
            status: AdminStatus.initial,
            newPokemons: [
              const Pokemon(
                id: 0,
                level: 0,
                gender: 0,
                height: 0,
                weight: 0,
                name: "",
                ability: "",
                category: "",
                description: "",
                isBaseForm: true,
                imgUrl: "",
                isFavourited: false,
                regionId: -1,
                types: [],
              )
            ],
            newEvolutions: [
              const Evolution(
                id: 0,
                pokemonId: 0,
                evolvesToId: null,
                condition: "DASD",
              )
            ],
            images: [File("")],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [currentState] when index > 0',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.initial,
          newPokemons: [testPokemon1],
          newEvolutions: [testEvolution],
          images: [testFile],
          currentIndex: 0,
        ),
        act: (bloc) => bloc.add(StartPokemonCreationEvent(index: 1)),
        expect: () => [
          AdminState(
            status: AdminStatus.initial,
            newPokemons: [
              testPokemon1,
              const Pokemon(
                id: 0,
                level: 0,
                gender: 0,
                height: 0,
                weight: 0,
                name: "",
                ability: "",
                category: "",
                description: "",
                isBaseForm: false,
                imgUrl: "",
                isFavourited: false,
                regionId: -1,
                types: [],
              ),
            ],
            newEvolutions: [
              testEvolution,
              const Evolution(
                id: 0,
                pokemonId: 0,
                evolvesToId: null,
                condition: "DASD",
              ),
            ],
            images: [testFile, File("")],
            currentIndex: 1,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when editing pokemon name.',
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(EditPokemonNameEvent(name: "newName")),
        expect: () => [
          AdminState(
            status: AdminStatus.success,
            newPokemons: [
              testPokemon1.copyWith(name: "newName"),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when editing pokemon ability.',
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(EditPokemonAbilityEvent(ability: "newAbility")),
        expect: () => [
          AdminState(
            status: AdminStatus.success,
            newPokemons: [
              testPokemon1.copyWith(ability: "newAbility"),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when editing pokemon category.',
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) =>
            bloc.add(EditPokemonCategoryEvent(category: "newCategory")),
        expect: () => [
          AdminState(
            status: AdminStatus.success,
            newPokemons: [
              testPokemon1.copyWith(category: "newCategory"),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when editing pokemon description.',
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc
            .add(EditPokemonDescriptionEvent(description: "newDescription")),
        expect: () => [
          AdminState(
            status: AdminStatus.success,
            newPokemons: [
              testPokemon1.copyWith(description: "newDescription"),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when editing pokemon height.',
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(EditPokemonHeightEvent(height: 2)),
        expect: () => [
          AdminState(
            status: AdminStatus.success,
            newPokemons: [
              testPokemon1.copyWith(height: 2),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when editing pokemon weight.',
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(EditPokemonWeightEvent(weight: 2)),
        expect: () => [
          AdminState(
            status: AdminStatus.success,
            newPokemons: [
              testPokemon1.copyWith(weight: 2),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when editing pokemon gender.',
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(EditPokemonGenderEvent(gender: 2)),
        expect: () => [
          AdminState(
            status: AdminStatus.success,
            newPokemons: [
              testPokemon1.copyWith(gender: 2),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [updating] when starting to add Pokemon strength type.',
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(StartAddingPokemonStrengthTypeEvent()),
        expect: () => [
          const AdminState(
            status: AdminStatus.updating,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [updated] when adding Pokemon strength type.',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        act: (bloc) =>
            bloc.add(AddPokemonStrengthTypeEvent(type: testTypes[0])),
        expect: () => [
          AdminState(
            status: AdminStatus.updated,
            newPokemons: [
              testPokemon1.copyWith(types: [testTypes[0]]),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [creating] when starting to add Pokemon weakness type.',
        build: () => AdminBloc(mockedAdminRepo),
        act: (bloc) => bloc.add(StartAddingPokemonWeaknessTypeEvent()),
        expect: () => [
          const AdminState(
            status: AdminStatus.creating,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [success] when adding Pokemon weakness type.',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
          currentIndex: 0,
        ),
        act: (bloc) =>
            bloc.add(AddPokemonWeaknessTypeEvent(type: testTypes[1])),
        expect: () => [
          AdminState(
            status: AdminStatus.updated,
            newPokemons: [
              testPokemon1.copyWith(types: [
                ...testPokemon1.types,
                testTypes[1].copyWith(isWeakness: WeaknessStatus.yes),
              ]),
            ],
            currentIndex: 0,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [popped] when popping the last Pokemon.',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1, testPokemon2],
          newEvolutions: [testEvolution],
          images: [testFile, testFileOutline],
        ),
        act: (bloc) => bloc.add(PopPokemonEvent()),
        expect: () => [
          AdminState(
            status: AdminStatus.popped,
            newPokemons: [testPokemon1],
            newEvolutions: [],
            images: [testFile],
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [loading, created] when creating Pokemon.',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.initial,
          newPokemons: [testPokemon1],
          newEvolutions: [testEvolution],
          images: [testFile],
        ),
        act: (bloc) => bloc.add(CreatePokemonEvent(token: 'testToken')),
        setUp: () {
          when(() => mockedAdminRepo.uploadPokemon(
                any(),
                any(),
                any(),
              )).thenAnswer((_) async => testPokemon1);

          when(() => mockedAdminRepo.createEvolution(
                any(),
                any(),
              )).thenAnswer((_) async => testEvolution);
        },
        expect: () => [
          AdminState(
            status: AdminStatus.loading,
            newPokemons: [testPokemon1],
            newEvolutions: [testEvolution],
            images: [testFile],
          ),
          AdminState(
            status: AdminStatus.created,
            newPokemons: [
              testPokemon1.copyWith(evolvesTo: () => null),
            ],
            newEvolutions: [testEvolution],
            images: [File('')],
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [loading, failure] when creating Pokemon fails.',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.initial,
          newPokemons: [testPokemon1],
          newEvolutions: [testEvolution],
          images: [testFile],
        ),
        act: (bloc) => bloc.add(CreatePokemonEvent(token: 'testToken')),
        setUp: () {
          when(() => mockedAdminRepo.uploadPokemon(
                any(),
                any(),
                any(),
              )).thenThrow(Exception("Failed to create Pokemon"));
        },
        expect: () => [
          AdminState(
            status: AdminStatus.loading,
            newPokemons: [testPokemon1],
            newEvolutions: [testEvolution],
            images: [testFile],
          ),
          AdminState(
            status: AdminStatus.failure,
            error: "Exception: Failed to create Pokemon",
            newPokemons: [testPokemon1],
            newEvolutions: [testEvolution],
            images: [testFile],
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [loading, deleted] when deleting Pokemon.',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
        ),
        act: (bloc) => bloc.add(DeletePokemonByIdEvent(
          token: testToken,
          pokemon: testPokemon1,
        )),
        setUp: () {
          when(() => mockedAdminRepo.deletePokemonById(any(), any()))
              .thenAnswer((_) async {});
        },
        expect: () => [
          AdminState(
            status: AdminStatus.loading,
            newPokemons: [testPokemon1],
          ),
          AdminState(
            status: AdminStatus.deleted,
            newPokemons: [testPokemon1],
            deletedPokemon: testPokemon1,
          ),
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'emits [loading, failure] when deleting Pokemon fails.',
        build: () => AdminBloc(mockedAdminRepo),
        seed: () => AdminState(
          status: AdminStatus.success,
          newPokemons: [testPokemon1],
        ),
        act: (bloc) => bloc.add(DeletePokemonByIdEvent(
          token: testToken,
          pokemon: testPokemon1,
        )),
        setUp: () {
          when(() => mockedAdminRepo.deletePokemonById(any(), any()))
              .thenThrow(Exception("Failed to delete Pokemon"));
        },
        expect: () => [
          AdminState(
            status: AdminStatus.loading,
            newPokemons: [testPokemon1],
          ),
          AdminState(
            status: AdminStatus.failure,
            error: "Exception: Failed to delete Pokemon",
            newPokemons: [testPokemon1],
          ),
        ],
      );
    },
  );

  group("Admin region events", () {
    blocTest<AdminBloc, AdminState>(
      'emits [creating] when starting to create a region.',
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) => bloc.add(StartCreatingRegionEvent()),
      expect: () => [
        const AdminState(
          status: AdminStatus.creating,
          placeholderRegion: Region(
            id: 0,
            name: "",
            imgUrl: "",
            difficulty: 0,
          ),
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [updating] when starting to update a region.',
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) => bloc.add(StartUpdatingRegionEvent(region: testRegion1)),
      expect: () => [
        AdminState(
            status: AdminStatus.updating, placeholderRegion: testRegion1),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [loading, created] when creating a region.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
          status: AdminStatus.initial,
          placeholderRegion: testRegion1,
          placeholderFile: testFile),
      act: (bloc) => bloc.add(CreateRegionEvent(token: testToken)),
      setUp: () {
        when(() => mockedAdminRepo.uploadRegion(any(), any(), any()))
            .thenAnswer((_) async => testRegion1);
      },
      expect: () => [
        AdminState(
            status: AdminStatus.loading,
            placeholderRegion: testRegion1,
            placeholderFile: testFile),
        AdminState(
            status: AdminStatus.created,
            placeholderRegion: testRegion1,
            placeholderFile: null),
      ],
    );
    blocTest<AdminBloc, AdminState>(
      'emits [loading, failure] when creating a region fails.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
          status: AdminStatus.initial,
          placeholderRegion: testRegion1,
          placeholderFile: testFile),
      act: (bloc) => bloc.add(CreateRegionEvent(token: testToken)),
      setUp: () {
        when(() => mockedAdminRepo.uploadRegion(any(), any(), any()))
            .thenThrow(Exception("Failed to create region"));
      },
      expect: () => [
        AdminState(
            status: AdminStatus.loading,
            placeholderRegion: testRegion1,
            placeholderFile: testFile),
        AdminState(
            status: AdminStatus.failure,
            error: "Exception: Failed to create region",
            placeholderRegion: testRegion1,
            placeholderFile: testFile),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [success] when editing a region.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.success,
        placeholderRegion: testRegion1,
      ),
      act: (bloc) => bloc.add(EditRegionEvent(name: "New Region Name")),
      expect: () => [
        AdminState(
          status: AdminStatus.success,
          placeholderRegion: testRegion1.copyWith(name: "New Region Name"),
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [loading, popped] when deleting a region.',
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) => bloc.add(DeleteRegionByIdEvent(
        token: testToken,
        region: testRegion1,
      )),
      setUp: () {
        when(() => mockedAdminRepo.deleteRegionById(any(), any()))
            .thenAnswer((_) async {});
      },
      expect: () => [
        const AdminState(status: AdminStatus.loading),
        AdminState(
          status: AdminStatus.popped,
          placeholderRegion: testRegion1,
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [loading, failure] when deleting a region fails.',
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) => bloc.add(DeleteRegionByIdEvent(
        token: testToken,
        region: testRegion1,
      )),
      setUp: () {
        when(() => mockedAdminRepo.deleteRegionById(any(), any()))
            .thenThrow(Exception("Failed to delete region"));
      },
      expect: () => [
        const AdminState(status: AdminStatus.loading),
        const AdminState(
          status: AdminStatus.failure,
          error: "Exception: Failed to delete region",
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [loading, updated] when updating a region.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.updating,
        placeholderRegion: testRegion1,
      ),
      act: (bloc) => bloc
          .add(UpdateRegionByIdEvent(token: testToken, region: testRegion1)),
      setUp: () {
        when(() => mockedAdminRepo.updateRegionById(
              any(),
              any(),
            )).thenAnswer((_) async => testRegion1.copyWith(
              name: "Updated Region Name",
            ));
      },
      expect: () => [
        AdminState(
          status: AdminStatus.loading,
          placeholderRegion: testRegion1,
        ),
        AdminState(
          status: AdminStatus.updated,
          placeholderRegion: testRegion1.copyWith(
            name: "Updated Region Name",
          ),
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [loading, failure] when updating a region fails.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.updating,
        placeholderRegion: testRegion1,
      ),
      act: (bloc) => bloc
          .add(UpdateRegionByIdEvent(token: testToken, region: testRegion1)),
      setUp: () {
        when(() => mockedAdminRepo.updateRegionById(
              any(),
              any(),
            )).thenThrow(Exception("Failed to update region"));
      },
      expect: () => [
        AdminState(
          status: AdminStatus.loading,
          placeholderRegion: testRegion1,
        ),
        AdminState(
          status: AdminStatus.failure,
          error: "Exception: Failed to update region",
          placeholderRegion: testRegion1,
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [adding] when starting to add a Pokemon region.',
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) => bloc.add(StartAddingPokemonRegionEvent()),
      expect: () => [
        const AdminState(status: AdminStatus.adding),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [adding] when adding a Pokemon region.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.success,
        placeholderRegion: testRegion1,
        newPokemons: [testPokemon1, testPokemon1.copyWith(regionId: 2)],
      ),
      act: (bloc) => bloc.add(AddPokemonRegionEvent(region: testRegion1)),
      expect: () => [
        AdminState(
          status: AdminStatus.added,
          placeholderRegion: testRegion1,
          newPokemons: [
            testPokemon1.copyWith(regionId: testRegion1.id),
            testPokemon1.copyWith(regionId: 2),
          ],
        ),
      ],
    );
  });

  group("Admin image events", () {
    blocTest<AdminBloc, AdminState>(
      'emits [success] when adding a Pokemon image.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.success,
        images: [testFile],
        currentIndex: 0,
      ),
      act: (bloc) => bloc.add(AddPokemonImageEvent(image: testFileOutline)),
      expect: () => [
        AdminState(
          status: AdminStatus.success,
          images: [testFileOutline],
          currentIndex: 0,
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [success] when adding a type image.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.success,
        placeholderFile: testFile,
      ),
      act: (bloc) => bloc.add(AddTypeImageEvent(image: testFileOutline)),
      expect: () => [
        AdminState(
          status: AdminStatus.success,
          placeholderFile: testFileOutline,
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [success] when adding a type image outline.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.success,
        placeholderFileOutline: testFile,
      ),
      act: (bloc) => bloc.add(AddTypeImageOutlineEvent(image: testFileOutline)),
      expect: () => [
        AdminState(
          status: AdminStatus.success,
          placeholderFileOutline: testFileOutline,
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [success] when adding a region image.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.success,
        placeholderFile: testFile,
      ),
      act: (bloc) => bloc.add(AddRegionImageEvent(image: testFileOutline)),
      expect: () => [
        AdminState(
          status: AdminStatus.success,
          placeholderFile: testFileOutline,
        ),
      ],
    );
  });

  group("Admin cancel events", () {
    blocTest<AdminBloc, AdminState>(
      'emits [initial] when canceling an action.',
      seed: () => const AdminState(
        status: AdminStatus.success,
        currentIndex: 1,
      ),
      build: () => AdminBloc(mockedAdminRepo),
      act: (bloc) => bloc.add(CancelActionEvent()),
      expect: () => [
        const AdminState(status: AdminStatus.success, currentIndex: 0),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [success] when canceling a type action.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.updating,
        placeholderFile: testFile,
        placeholderFileOutline: testFileOutline,
      ),
      act: (bloc) => bloc.add(CancelTypeEvent()),
      expect: () => [
        const AdminState(
          status: AdminStatus.success,
        ),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [success] when canceling a region action.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => AdminState(
        status: AdminStatus.updating,
        placeholderFile: testFile,
      ),
      act: (bloc) => bloc.add(CancelRegionEvent()),
      expect: () => [
        const AdminState(status: AdminStatus.success),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [success] when canceling a Pokemon action.',
      build: () => AdminBloc(mockedAdminRepo),
      seed: () => const AdminState(
        status: AdminStatus.updating,
      ),
      act: (bloc) => bloc.add(CancelPokemonEvent()),
      expect: () => [
        const AdminState(status: AdminStatus.success),
      ],
    );
  });
}
