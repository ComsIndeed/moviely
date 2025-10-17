import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_bloc.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_event.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_state.dart';
import 'package:moviely/blocs/show_page_bloc/show_page_bloc.dart';
import 'package:moviely/pages/show_page/show_page.dart';
import 'package:moviely/repositories/tmdb_repository.dart';
import 'package:moviely/utilities/debouncer.dart';
// Assuming RoundedSuperellipseBorder exists and is correctly imported/defined

class HomepageSearch extends StatefulWidget {
  const HomepageSearch({super.key});

  @override
  State<HomepageSearch> createState() => _HomepageSearchState();
}

class _HomepageSearchState extends State<HomepageSearch> {
  final debouncer = Debouncer(Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: "Search Movies, TV Shows, People...",
      barElevation: const WidgetStatePropertyAll(0),
      // Assuming RoundedSuperellipseBorder is available
      barShape: WidgetStatePropertyAll(
        RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      viewShape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onChanged: (value) {
        debouncer.run(() {
          context.read<HomepageSearchBloc>().add(
            HomepageSearchQueryEvent(query: value),
          );
        });
      },
      suggestionsBuilder: (context, controller) {
        // The BlocBuilder should return the Iterable<Widget> directly.
        return [
          BlocBuilder<HomepageSearchBloc, HomepageSearchState>(
            builder: (context, state) {
              // --- Handled the different states ---

              if (state is HomepageSearchInitialState) {
                return const SizedBox(
                  height: 64,
                  child: Center(child: Text("Search for something")),
                );
              }

              if (state is HomepageSearchLoadingState) {
                return const SizedBox(
                  height: 64,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is HomepageSearchErrorState) {
                return SizedBox(
                  height: 64,
                  child: Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              if (state is HomepageSearchLoadedState) {
                // Combine all results into a single list of widgets
                final allResults = [
                  ...state.searchResults["movies"]!,
                  ...state.searchResults["tv"]!,
                  ...state.searchResults["people"]!,
                ];

                if (allResults.isEmpty) {
                  return const Center(child: Text("No results found."));
                }

                print(allResults);

                // Use .toList() here to ensure we return a List<Widget>
                // The return type of suggestionsBuilder is Iterable<Widget>, so List is fine.
                return Column(
                  children: [
                    ...allResults.map(
                      (item) => ListTile(
                        leading: item.posterPath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w92${item.posterPath}',
                                width: 50,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.movie),
                        title: item.adult
                            ? Badge(label: Text("18+"), child: Text(item.name))
                            : Text(item.name),
                        subtitle: Text(
                          '${item.mediaType} ${item.releaseDate.isNotEmpty ? "|" : ""} ${item.releaseDate.substring(0, item.releaseDate.length > 4 ? 4 : item.releaseDate.length)}',
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) =>
                                  ShowPageBloc(context.read<TmdbRepository>()),
                              child: ShowPage(showItem: item),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              // Fallback: If the state is something unexpected, return a default message.
              return const Center(child: Text("What're you looking for?"));
            }, // <-- Closing the BlocBuilder
          ),
        ]; // <-- Closing the BlocBuilder call
      }, // <-- Closing the suggestionsBuilder
    );
  }
}
