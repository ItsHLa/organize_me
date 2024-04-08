import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'docs_num_state.dart';

class DocsNumCubit extends Cubit<DocsNumState> {
  DocsNumCubit() : super(DocsNumInitial());
}
