part of 'properti_bloc.dart';

sealed class PropertiEvent extends Equatable {
  const PropertiEvent();

  @override
  List<Object> get props => [];
}

class OnGetProperti extends PropertiEvent {
  bool? isRent;
  String? query;
  int? page;
  String? type;

  OnGetProperti({this.isRent, this.query, this.page, this.type});

  @override
  List<Object> get props => [
        {isRent, query, page, type}
      ];
}

class OnGetDetailProperti extends PropertiEvent {
  final String slug;

  const OnGetDetailProperti(this.slug);

  @override
  List<Object> get props => [slug];
}
