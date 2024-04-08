part of 'docs_num_cubit.dart';

@immutable
sealed class DocsNumState {}

final class DocsNumInitial extends DocsNumState {}

final class AddDocsNumSuccess extends DocsNumState {}

final class AddDocsNumFailed extends DocsNumState {}

final class DeleteDocsNumSuccess extends DocsNumState {}

final class DeleteDocsNumFailed extends DocsNumState {}

final class DocsNumUpdated extends DocsNumState {}
