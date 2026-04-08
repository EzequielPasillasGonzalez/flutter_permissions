part of 'badge_cubit.dart';

class BadgeState extends Equatable {
  final int count;

  const BadgeState({required this.count});

  @override
  List<Object> get props => [count];
  BadgeState copyWith({int? count}) => BadgeState(count: count ?? this.count);
}
