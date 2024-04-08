part of 'docs_num_cubit.dart';

@immutable
sealed class DocsNumState {
  final List docsNumber;

  const DocsNumState({required this.docsNumber});
}

final class DocsNumInitial extends DocsNumState {
  const DocsNumInitial({required super.docsNumber});
}

final class AddDocsNumSuccess extends DocsNumState {
  const AddDocsNumSuccess({required super.docsNumber});
}

final class AddDocsNumFailed extends DocsNumState {
  final String msg;

  const AddDocsNumFailed(this.msg, {required super.docsNumber});
}

final class DeleteDocsNumSuccess extends DocsNumState {
  const DeleteDocsNumSuccess({required super.docsNumber});
}

final class DeleteDocsNumFailed extends DocsNumState {
  final String msg;

  const DeleteDocsNumFailed(this.msg, {required super.docsNumber});
}
