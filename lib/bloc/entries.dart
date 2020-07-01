part of bloc;

abstract class EntriesEvent extends Equatable {
  const EntriesEvent();
  @override
  List<Object> get props => [];
}

class FetchEntries extends EntriesEvent {}

abstract class EntriesState extends Equatable {
  const EntriesState();

  @override
  List<Object> get props => [];
}

class EntriesIntial extends EntriesState {
  final int total = 0;
  final List<Entry> entries = [];
  @override
  List<Object> get props => [entries, total];
}

class EntriesFetchSuccess extends EntriesState {
  final List<Entry> entries;
  final int total;
  const EntriesFetchSuccess({@required this.entries, @required this.total})
      : assert(entries != null),
        assert(total != null);

  @override
  List<Object> get props => [entries, total];
}

class EntriesFetchFailure extends EntriesState {}

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  final EntryRepository repository;

  EntriesBloc({@required this.repository}) : assert(repository != null);

  @override
  EntriesState get initialState => EntriesIntial();

  @override
  Stream<EntriesState> mapEventToState(EntriesEvent event) async* {
    if (event is FetchEntries) {
      try {
        final _ret = await repository.fetchEntries();
        yield EntriesFetchSuccess(
            entries: _ret['entries'], total: _ret['total']);
      } catch (e) {
        yield EntriesFetchFailure();
      }
    }
  }
}
