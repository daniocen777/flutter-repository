import 'package:diaryapp/src/bloc/validators.dart';
import 'package:diaryapp/src/data-access/diary_da.dart';
import 'package:rxdart/rxdart.dart';
import 'package:diaryapp/src/models/diary_model.dart';

class DiaryBloc with Validators {
  final _diaryController = BehaviorSubject<List<Diary>>(); // Controla la lista
  final _cargaController = BehaviorSubject<bool>(); // Controla el estado
  // Controla el título del diario
  final _titleController = BehaviorSubject<String>();
  // Controla descripción del diario
  final _descriptionController = BehaviorSubject<String>();

  /*  Referencia a la clase para acceder a los datos */
  DiaryDataAccess _diaryDataAccess = new DiaryDataAccess();

  /*  Streams */
  Stream<List<Diary>> get diaryStream => _diaryController.stream;
  Stream<bool> get cargaStream => _cargaController.stream;
  Stream<String> get titleStream =>
      _titleController.stream.transform(validateTitle);
  Stream<String> get descriptionStream =>
      _descriptionController.stream.transform(validateDescription);
  /* Combinando streams de title y description */
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(titleStream, descriptionStream, (e, p) => true);

  /* Oyendo el cambio en los inputs */
  Function(String) get changeTitle => _titleController.sink.add;
  Function(String) get changeDescription => _descriptionController.sink.add;
  /* Obteniendo los valores de los inputs */
  String get title => _titleController.value;
  String get description => _descriptionController.value;

  /* Funciones */
  void loadData() async {
    final diaries = await _diaryDataAccess.loadData();
    _diaryController.sink.add(diaries);
  }

  dispose() {
    _diaryController.close();
    _cargaController.close();
    _titleController.close();
    _descriptionController.close();
  }
}
