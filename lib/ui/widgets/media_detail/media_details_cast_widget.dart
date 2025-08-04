
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_cast.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_model.dart';

class MediaCastWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final List<Actor>? Function(T?) getCast;
  final String title;

  const MediaCastWidget({
    super.key,
    required this.getCast,
    this.title = 'Series Cast',
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 250,
            child: Scrollbar(
              child: MediaActorListWidget<T>(getCast: getCast),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('Full Cast & Crew'),
            ),
          ),
        ],
      ),
    );
  }
}
class MediaActorListWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final List<Actor>? Function(T?) getCast;

  const MediaActorListWidget({
    super.key,
    required this.getCast,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    final cast = getCast(model);
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    
    return ListView.builder(
      itemCount: cast.length,
      itemExtent: 120,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return MediaActorItemWidget<T>(
          actorIndex: index,
          getCast: getCast,
        );
      },
    );
  }
}

class MediaActorItemWidget<T extends MediaDetailsModel> extends StatelessWidget {
  final int actorIndex;
  final List<Actor>? Function(T?) getCast;

  const MediaActorItemWidget({
    super.key,
    required this.actorIndex,
    required this.getCast,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<T>(context);
    final cast = getCast(model);
    if (cast == null || actorIndex >= cast.length) {
      return const SizedBox.shrink();
    }
    
    final actor = cast[actorIndex];
    final profilePath = actor.profilePath;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withValues(alpha: (0.2))),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: (0.1)),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              profilePath != null
                  ? Image(
                      image: NetworkImage(ApiClient.imageUrl(profilePath)),
                      height: 120,
                      width: 120,
                      fit: BoxFit.fitWidth,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        actor.name,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        actor.character,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}