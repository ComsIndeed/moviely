import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviely/blocs/show_page_bloc/show_page_bloc.dart';
import 'package:moviely/blocs/show_page_bloc/show_page_event.dart';
import 'package:moviely/blocs/show_page_bloc/show_page_state.dart';
import 'package:moviely/models/show_item.dart';
import 'package:moviely/models/tv_show.dart';
import 'package:moviely/utilities/collapsible_text.dart';
import 'package:moviely/utilities/duration_formatting_extension.dart';
import 'package:moviely/utilities/num_convertion_extension.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({super.key, required this.showItem});

  final ShowItem showItem;

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShowPageBloc>().add(
      ShowPageFetchEvent(
        showId: widget.showItem.id,
        mediaType: widget.showItem.mediaType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowPageBloc, ShowPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(width: double.infinity),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w200${widget.showItem.posterPath}",
                        width: 200,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.showItem.name,
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1.25
                                      ..color = Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                  ),
                            ),
                            CollapsibleText(
                              text: widget.showItem.overview ?? "",
                              maxLines: 8,
                              // style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Row(
                              children: [
                                IconButton.outlined(
                                  onPressed: () {},
                                  icon: Icon(Icons.heart_broken),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                if (state is ShowPageLoadingState)
                  SizedBox(
                    height: 256,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (state is ShowPageLoadedState<TvShow>) ...[
                  Text(
                    "Seasons",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1.5,
                    ),
                  ),
                  ...state.data.seasons.map(
                    (season) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ExpansionTile(
                        leading:
                            (state.data.posterPath !=
                                    widget.showItem.posterPath &&
                                state.data.posterPath != null)
                            ? Image.network(
                                "https://image.tmdb.org/t/p/w200${state.data.posterPath}",
                              )
                            : CircleAvatar(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                child: Text(
                                  "S${season.seasonNumber}",
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.robotoSerif().fontFamily,
                                  ),
                                ),
                              ),
                        title: Text(
                          season.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(value: 0.7),
                            ),
                            SizedBox(width: 4),
                            Text(
                              season.episodes
                                  .map((e) => e.runtime ?? 0)
                                  .reduce((value, element) => value + element)
                                  .toDuration(field: DurationField.minutes)
                                  .toHmsString,
                            ),
                          ],
                        ),
                        shape: RoundedSuperellipseBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        children: [
                          ...season.episodes.map(
                            (episode) => ListTile(
                              contentPadding: EdgeInsets.fromLTRB(32, 4, 24, 4),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                                child: FittedBox(
                                  child: Text(
                                    "E${episode.episodeNumber}",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.robotoSerif().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {},
                              title: Text.rich(
                                TextSpan(
                                  text: episode.name,
                                  children: [
                                    TextSpan(
                                      text:
                                          ": ${episode.overview.substring(0, episode.overview.length > 100 ? 100 : episode.overview.length)}${episode.overview.length > 100 ? "..." : ""}",
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary.withAlpha(125),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Icon(Icons.check_box_outline_blank),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
