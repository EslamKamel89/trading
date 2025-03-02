part of 'news_cubit.dart';

sealed class NewsState {
  const NewsState();
}

final class NewsInitial extends NewsState {}

final class NewsLoadingState extends NewsState {}

final class NewsFailureState extends NewsState {
  final String errorMessage;
  const NewsFailureState({required this.errorMessage});
}

final class NewsSuccessState extends NewsState {}

final class CertificationsLoadingState extends NewsState {}

final class CertificationsFailureState extends NewsState {
  final String errorMessage;
  const CertificationsFailureState({required this.errorMessage});
}

final class CertificationsSuccessState extends NewsState {}

final class NewsBlogLoadingState extends NewsState {}

final class NewsBlogFailureState extends NewsState {
  final String errorMessage;
  const NewsBlogFailureState({required this.errorMessage});
}

final class NewsBlogSuccessState extends NewsState {}
