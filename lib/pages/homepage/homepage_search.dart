import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_bloc.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_event.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_state.dart';
import 'package:moviely/utilities/debouncer.dart';

class HomepageSearch extends StatefulWidget {
  const HomepageSearch({super.key});

  @override
  State<HomepageSearch> createState() => _HomepageSearchState();
}

class _HomepageSearchState extends State<HomepageSearch> {
  final debouncer = Debouncer(Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageSearchBloc, HomepageSearchState>(
      builder: (context, state) {
        return SearchAnchor.bar(
          barElevation: WidgetStatePropertyAll(0),
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
          onChanged: (value) => context.read<HomepageSearchBloc>().add(
            HomepageSearchQueryEvent(query: value),
          ),
          suggestionsBuilder: (context, controller) {
            if (state is HomepageSearchInitialState) {
              return [
                SizedBox(
                  height: 64,
                  child: Center(child: Text("Search for something")),
                ),
              ];
            }

            if (state is HomepageSearchLoadingState) {
              return [
                SizedBox(height: 64, child: Center(child: Text("Loading..."))),
              ];
            }

            if (state is HomepageSearchErrorState) {
              return [
                SizedBox(
                  height: 64,
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ];
            }

            if (state is HomepageSearchLoadedState) {
              return [
                ...state.searchResults["movies"]!.map(
                  (item) => ListTile(title: Text(item.name)),
                ),
              ];
            }

            return [];
          },
        );
      },
    );
  }
}
