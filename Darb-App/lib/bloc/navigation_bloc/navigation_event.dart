part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

final class ChangePageEvent extends NavigationEvent{
  final int index;

  ChangePageEvent({required this.index});
}