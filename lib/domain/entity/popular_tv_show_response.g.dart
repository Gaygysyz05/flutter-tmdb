// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_tv_show_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularTVShowResponse _$PopularTVShowResponseFromJson(
        Map<String, dynamic> json) =>
    PopularTVShowResponse(
      page: (json['page'] as num).toInt(),
      tvShows: (json['results'] as List<dynamic>)
          .map((e) => TVShow.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PopularTVShowResponseToJson(
        PopularTVShowResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.tvShows.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };
