part of 'docs_num_cubit.dart';

@immutable
sealed class DocsNumState {
  final List<String> DocsNumber;

  DocsNumState({required this.DocsNumber});
}

final class DocsNumInitial extends DocsNumState {
  DocsNumInitial({required super.DocsNumber});
}

final class AddDocsNumSuccess extends DocsNumState {
  AddDocsNumSuccess({required super.DocsNumber});
}

final class AddDocsNumFailed extends DocsNumState {
  final String msg;

  AddDocsNumFailed(this.msg, {required super.DocsNumber});
}

final class DeleteDocsNumSuccess extends DocsNumState {
  DeleteDocsNumSuccess({required super.DocsNumber});
}

final class DeleteDocsNumFailed extends DocsNumState {
  final String msg;

  DeleteDocsNumFailed(this.msg, {required super.DocsNumber});
}
