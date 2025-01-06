# Test Yazma Akışı

Bu dokümantasyon, Clean Architecture prensiplerine uygun olarak test yazma sürecini anlatmaktadır.

## 1. Test Yapısı

Her feature için test klasörü yapısı aşağıdaki gibi olmalıdır:

```
test/
├── core/
│   ├── network/
│   │   └── network_info_test.dart
│   └── error/
│       └── failures_test.dart
└── features/
    └── feature_name/
        ├── data/
        │   ├── datasources/
        │   │   ├── feature_remote_data_source_test.dart
        │   │   └── feature_local_data_source_test.dart
        │   ├── models/
        │   │   └── feature_model_test.dart
        │   └── repositories/
        │       └── feature_repository_impl_test.dart
        ├── domain/
        │   └── usecases/
        │       └── feature_usecase_test.dart
        └── presentation/
            └── bloc/
                └── feature_bloc_test.dart
```

## 2. Test Yazma Sırası

### 1. Domain Katmanı Testleri
- Use case testleri
- Repository mock'ları

### 2. Data Katmanı Testleri
- Model testleri (fromJson, toJson, equality)
- Data source testleri (remote ve local)
- Repository implementation testleri

### 3. Presentation Katmanı Testleri
- Bloc testleri
- Widget testleri (gerekirse)

## 3. Test Örnekleri

### 1. Use Case Testi
```dart
void main() {
  late UseCase useCase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    useCase = UseCase(mockRepository);
  });

  test(
    'should return data when repository call is successful',
    () async {
      // arrange
      when(() => mockRepository.someMethod())
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, Right(testData));
      verify(() => mockRepository.someMethod()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
```

### 2. Repository Testi
```dart
void main() {
  late RepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('someMethod', () {
    test(
      'should return remote data when network is connected',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.someMethod())
            .thenAnswer((_) async => testModel);

        // act
        final result = await repository.someMethod();

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDataSource.someMethod()).called(1);
        expect(result, Right(testModel));
      },
    );

    test(
      'should return network failure when network is not connected',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await repository.someMethod();

        // assert
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, Left(NetworkFailure()));
      },
    );
  });
}
```

### 3. Bloc Testi
```dart
void main() {
  late FeatureBloc bloc;
  late MockUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUseCase();
    bloc = FeatureBloc(useCase: mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be Initial', () {
    expect(bloc.state, FeatureInitial());
  });

  blocTest<FeatureBloc, FeatureState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => Right(testData));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadFeatureData()),
    expect: () => [
      FeatureLoading(),
      FeatureLoaded(testData),
    ],
    verify: (_) {
      verify(() => mockUseCase(NoParams())).called(1);
    },
  );
}
```

## 4. Test Prensipleri

1. **Arrange-Act-Assert Pattern**
   - Arrange: Test için gerekli setup
   - Act: Test edilecek metodu çağırma
   - Assert: Sonuçları doğrulama

2. **Mock Kullanımı**
   - Mocktail kütüphanesi tercih edilmeli
   - Her bağımlılık mock'lanmalı
   - Mock davranışları açıkça tanımlanmalı

3. **Test Gruplandırma**
   - İlgili testler `group` içinde toplanmalı
   - Her test senaryosu açıkça tanımlanmalı
   - Edge case'ler unutulmamalı

4. **Test Coverage**
   - Her public metod test edilmeli
   - Happy path ve error case'ler kapsanmalı
   - Edge case'ler düşünülmeli

5. **Clean Test**
   - DRY prensibi uygulanmalı
   - Test fixture'ları kullanılmalı
   - Test helper metodları oluşturulmalı

6. **Naming Convention**
   - Test dosyaları `_test.dart` ile bitmeli
   - Test isimleri açıklayıcı olmalı
   - Test grupları mantıklı şekilde organize edilmeli

7. **Best Practices**
   - Her test bağımsız olmalı
   - Testler hızlı çalışmalı
   - Testler tekrarlanabilir olmalı
   - Gereksiz test yazılmamalı 