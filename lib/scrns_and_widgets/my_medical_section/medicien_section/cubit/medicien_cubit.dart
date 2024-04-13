import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'medicien_state.dart';

class MedicienCubit extends Cubit<MedicienState> {
  MedicienCubit() : super(MedicienInitial());
}
