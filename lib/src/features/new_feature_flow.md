# Yeni Feature Oluşturma Akışı

Bu dokümantasyon, Clean Architecture prensiplerine uygun olarak yeni bir feature oluşturma sürecini anlatmaktadır.

## 1. Katman Yapısı

Her feature aşağıdaki katmanları içermelidir:

```
feature/
├── data/
│   ├── datasources/
│   │   ├── feature_remote_data_source.dart
│   │   └── feature_local_data_source.dart
│   ├── models/
│   │   └── feature_model.dart
│   └── repositories/
│       └── feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   ├── repositories/
│   │   └── feature_repository.dart
│   └── usecases/
│       └── feature_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── feature_bloc.dart
    │   ├── feature_event.dart
    │   └── feature_state.dart
    ├── pages/
    │   └── feature_page.dart
    └── widgets/
        └── feature_widget.dart
```

## 2. Geliştirme Sırası ve Injectable Yapılandırması

### 1. Domain Katmanı

1. **Entities**
```dart
class FeatureEntity extends Equatable {
  final String property;

  const FeatureEntity({required this.property});

  @override
  List<Object?> get props => [property];
}
```

2. **Repository Interface**
```dart
abstract class FeatureRepository {
  Future<Either<Failure, FeatureEntity>> someFeatureMethod();
}
```

3. **Use Cases**
```dart
@lazySingleton
class SomeFeatureUseCase implements UseCase<FeatureEntity, NoParams> {
  final FeatureRepository repository;

  SomeFeatureUseCase(this.repository);

  @override
  Future<Either<Failure, FeatureEntity>> call(NoParams params) {
    return repository.someFeatureMethod();
  }
}
```

### 2. Data Katmanı

1. **Models**
```dart
class FeatureModel extends FeatureEntity {
  const FeatureModel({required String property}) : super(property: property);

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      property: json['property'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property': property,
    };
  }
}
```

2. **Data Sources**
```dart
abstract class FeatureRemoteDataSource {
  Future<FeatureModel> someFeatureMethod();
}

@LazySingleton(as: FeatureRemoteDataSource)
class FeatureRemoteDataSourceImpl implements FeatureRemoteDataSource {
  final Dio client;

  FeatureRemoteDataSourceImpl({required this.client});

  @override
  Future<FeatureModel> someFeatureMethod() async {
    try {
      final response = await client.get('/endpoint');
      return FeatureModel.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }
}
```

3. **Repository Implementation**
```dart
@LazySingleton(as: FeatureRepository)
class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FeatureRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FeatureEntity>> someFeatureMethod() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.someFeatureMethod();
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
```

### 3. Presentation Katmanı

1. **Events ve States**
```dart
// Events
abstract class FeatureEvent extends Equatable {
  const FeatureEvent();

  @override
  List<Object> get props => [];
}

class LoadFeatureData extends FeatureEvent {}

// States
abstract class FeatureState extends Equatable {
  const FeatureState();

  @override
  List<Object> get props => [];
}

class FeatureInitial extends FeatureState {}
class FeatureLoading extends FeatureState {}
class FeatureLoaded extends FeatureState {
  final FeatureEntity data;
  const FeatureLoaded(this.data);

  @override
  List<Object> get props => [data];
}
class FeatureError extends FeatureState {
  final String message;
  const FeatureError(this.message);

  @override
  List<Object> get props => [message];
}
```

2. **Bloc**
```dart
@injectable
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final SomeFeatureUseCase someFeatureUseCase;

  FeatureBloc({required this.someFeatureUseCase}) : super(FeatureInitial()) {
    on<LoadFeatureData>(_onLoadFeatureData);
  }

  Future<void> _onLoadFeatureData(
    LoadFeatureData event,
    Emitter<FeatureState> emit,
  ) async {
    emit(FeatureLoading());

    final result = await someFeatureUseCase(NoParams());

    emit(result.fold(
      (failure) => FeatureError('Bir hata oluştu'),
      (data) => FeatureLoaded(data),
    ));
  }
}
```

3. **Page**
```dart
@RoutePage()
class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureBloc, FeatureState>(
      builder: (context, state) {
        if (state is FeatureLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FeatureLoaded) {
          return Center(child: Text(state.data.property));
        } else if (state is FeatureError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
```

## 3. Önemli Noktalar

1. **Injectable Kullanımı**
   - Bloc'lar için `@injectable`
   - Use case'ler için `@lazySingleton`
   - Repository implementasyonları için `@LazySingleton(as: Repository)`
   - Data source implementasyonları için `@LazySingleton(as: DataSource)`
   - Utility sınıfları için `@lazySingleton`
   - Preloaded instance'lar için `@preResolve`

2. **Auto Route Kullanımı**
   - Her page'e `@RoutePage()` annotation'ı eklenmelidir
   - Route tanımları `app_router.dart` içinde yapılmalıdır
   - Nested route'lar için parent route'a children eklenmelidir

3. **Bloc Pattern**
   - Her feature kendi bloc'unu içermelidir
   - Event'ler ve state'ler açık ve anlaşılır olmalıdır
   - State'ler immutable olmalıdır
   - Bloc'lar sadece use case'leri kullanmalıdır

4. **Error Handling**
   - Domain katmanında `Failure` sınıfları
   - Data katmanında `Exception` sınıfları
   - UI'da kullanıcı dostu hata mesajları

5. **Dependency Injection**
   - Her katman kendi bağımlılıklarını injectable ile yönetmelidir
   - Soyutlamalar için interface'ler kullanılmalıdır
   - Test edilebilirlik için bağımlılıklar inject edilmelidir

6. **Testing**
   - Her katman için unit testler yazılmalıdır
   - Repository ve use case'ler için integration testler
   - UI için widget testler
   - Önemli akışlar için golden testler

7. **Code Style**
   - Dart style guide takip edilmelidir
   - Her public API dokümante edilmelidir
   - Meaningful isimlendirme kullanılmalıdır
   - DRY ve SOLID prensiplerine uyulmalıdır
