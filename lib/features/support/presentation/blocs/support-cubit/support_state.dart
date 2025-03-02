part of 'support_cubit.dart';

sealed class SupportState extends Equatable {
  const SupportState();

  @override
  List<Object> get props => [];
}

final class SupportInitial extends SupportState {}

final class SupportLoadingState extends SupportState {}

final class SupportFailureState extends SupportState {
  final String message;
  const SupportFailureState({required this.message});
}

final class SupportAddNewState extends SupportState {}

final class SupportOfflineState extends SupportState {}
