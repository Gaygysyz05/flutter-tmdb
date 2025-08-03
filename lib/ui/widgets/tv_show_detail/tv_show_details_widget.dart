import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/app/my_app_model.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_info_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_main_info_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show_detail/tv_show_details_model.dart';

class TvShowDetailsWidget extends StatefulWidget {
  const TvShowDetailsWidget({super.key});

  @override
  State<TvShowDetailsWidget> createState() => _TvShowDetailWidgetState();
}

class _TvShowDetailWidgetState extends State<TvShowDetailsWidget> {

  @override
  void initState() {
    super.initState();
    final model = NotifierProvider.read<TvShowDetailsModel>(context);
    final appModel = Provider.read<MyAppModel>(context);
    model?.onSessionExpired = () => appModel?.resetSession(context);
    model?.loadDetails();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<TvShowDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: _BodyWidget(),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    return Text(
      model?.tvShowDetails?.name ?? 'Loading...',
      style: const TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<TvShowDetailsModel>(context);
    final tvShowDetails = model?.tvShowDetails;
    if (tvShowDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        const TvShowDetailsInfoWidget(),
        const SizedBox(height: 30),
        const TvShowDetailsMainInfoWidget()
      ],
    );
  }
}
