import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/media_detail/media_details_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_info_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_cast_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_model.dart';

class TvShowDetailsWidget extends StatefulWidget {
  const TvShowDetailsWidget({super.key});

  @override
  State<TvShowDetailsWidget> createState() => _TvShowDetailWidgetState();
}

class _TvShowDetailWidgetState extends State<TvShowDetailsWidget> 
    with MediaDetailsStateMixin {

  @override
  void initState() {
    super.initState();
    initializeMediaModel<TvShowDetailsModel>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupMediaLocale<TvShowDetailsModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediaDetailsTitle<TvShowDetailsModel>(
          getTitleCallback: (model) => model?.tvShowDetails?.name,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: MediaDetailsBody<TvShowDetailsModel>(
          children: [
            TvShowDetailsInfoWidget(),
            SizedBox(height: 30),
            TvShowDetailsMainInfoWidget()
          ],
        ),
      ),
    );
  }
}