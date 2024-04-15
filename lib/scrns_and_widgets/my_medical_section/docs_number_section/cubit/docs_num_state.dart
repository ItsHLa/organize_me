part of 'docs_num_cubit.dart';

@immutable
sealed class DocsNumState {
  final List<DoctorsContacts> docsNumber;

  const DocsNumState({required this.docsNumber});
}

final class DocsNumInitial extends DocsNumState {
  const DocsNumInitial({required super.docsNumber});
}

final class NoDocsNum extends DocsNumState {
  const NoDocsNum({required super.docsNumber});
}

final class EditingPhoneNumber extends DocsNumState {
  const EditingPhoneNumber({required super.docsNumber});
}

final class DocsNumLoadingData extends DocsNumState {
  const DocsNumLoadingData({required super.docsNumber});
}

final class DocsNumLoaded extends DocsNumState {
  const DocsNumLoaded({required super.docsNumber});
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
