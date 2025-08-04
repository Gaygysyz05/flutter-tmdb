import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/app/my_app_model.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_model.dart';

mixin MediaDetailsStateMixin<T extends MediaDetailsModel, W extends StatefulWidget> on State<W> {
  void initializeMediaModel<ModelType extends MediaDetailsModel>() {
    final model = NotifierProvider.read<ModelType>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
    model?.loadDetails();
  }

  void setupMediaLocale<ModelType extends MediaDetailsModel>() {
    NotifierProvider.read<ModelType>(context)?.setupLocale(context);
  }
}

class MediaDetailsTitle<T extends MediaDetailsModel> extends StatelessWidget {
  final String? Function(T?) getTitleCallback;
  
  const MediaDetailsTitle({
    super.key,
    required this.getTitleCallback,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    return Text(
      getTitleCallback(model) ?? 'Loading...',
      style: const TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class MediaDetailsBody<T extends MediaDetailsModel> extends StatelessWidget {
  final List<Widget> children;
  
  const MediaDetailsBody({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<T>(context);
    final details = model?.details;
    if (details == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(children: children);
  }
}