import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/ui/widgets/media_list/media_list_model.dart';

class MediaListWidget<T, R> extends StatelessWidget {
  final MediaListModel<T, R> model;
  const MediaListWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildItemsList(model),
        _buildSearchField(model),
      ],
    );
  }

  Widget _buildItemsList(MediaListModel<T, R> model) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 70),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: model.items.length,
      itemExtent: 150,
      itemBuilder: (BuildContext context, int index) {
        model.showedItemAtIndex(index);
        return _buildMediaItem(context, model, index);
      },
    );
  }

  Widget _buildMediaItem(BuildContext context, MediaListModel<T, R> model, int index) {
    final item = model.items[index];
    final config = model.config;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          _buildItemContainer(item, config, model),
          _buildItemTapArea(context, model, index),
        ],
      ),
    );
  }

  Widget _buildItemContainer(T item, dynamic config, MediaListModel<T, R> model) {
    final posterPath = config.getPosterPath(item);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.2),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          _buildPosterImage(posterPath),
          const SizedBox(width: 15),
          _buildItemContent(item, config, model),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildPosterImage(String? posterPath) {
    return posterPath != null
        ? Image.network(
            ApiClient.imageUrl(posterPath),
            width: 95,
            fit: BoxFit.cover,
          )
        : const SizedBox.shrink();
  }

  Widget _buildItemContent(T item, dynamic config, MediaListModel<T, R> model) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildTitle(config.getTitle(item)),
          const SizedBox(height: 5),
          _buildReleaseDate(model.stringFromDate(config.getReleaseDate(item))),
          const SizedBox(height: 20),
          _buildOverview(config.getOverview(item)),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildReleaseDate(String date) {
    return Text(
      date,
      style: const TextStyle(color: Colors.grey),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildOverview(String overview) {
    return Text(
      overview,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildItemTapArea(BuildContext context, MediaListModel<T, R> model, int index) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => model.onItemTap(context, index),
      ),
    );
  }

  Widget _buildSearchField(MediaListModel<T, R> model) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchMedia,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: 'Search',
          filled: true,
          fillColor: Colors.white.withAlpha(235),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}