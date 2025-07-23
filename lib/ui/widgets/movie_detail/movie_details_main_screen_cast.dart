import 'package:flutter/material.dart';
import 'package:themoviedb/ui/resources/resources.dart';

class MovieDetailsMainScreenCast extends StatelessWidget {
  const MovieDetailsMainScreenCast({super.key});

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
              'Series Cast',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 250,
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 20,
                itemExtent: 120,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.black.withValues(alpha: (0.2))),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: (0.1)),
                                blurRadius: 8,
                                offset: Offset(0, 2))
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            Image(image: AssetImage(AppImages.actor)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Akari Kito',
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'Nezuko Kamado',
                                    maxLines: 4,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text('(voice)')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child:
                TextButton(onPressed: () {}, child: Text('Full Cast & Crew')),
          ),
        ],
      ),
    );
  }
}
