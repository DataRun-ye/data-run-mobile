import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchInputSliver extends StatelessWidget {
  const SearchInputSliver({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () {
                // controller.openView();
              },
              onChanged: onChanged,
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                if (controller.text.isNotEmpty)
                  Tooltip(
                    message: 'Change brightness mode',
                    child: IconButton(
                      // isSelected: isDark,
                      onPressed: () {
                        controller.clear();
                        // setState(() {
                        //   isDark = !isDark;
                        // });
                      },
                      icon: const Icon(Icons.clear),
                      selectedIcon: const Icon(Icons.brightness_2_outlined),
                    ),
                  ),
              ],
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  // setState(() {
                  //   controller.closeView(item);
                  // });
                },
              );
            });
          },
        ),
      ),
    );
  }
}
//
// class SliverSearchBar extends StatelessWidget {
//   const SliverSearchBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('SearchAnchor - async and debouncing')),
//         body: const Center(child: _AsyncSearchAnchor()),
//       ),
//     );
//   }
// }
//
// class _AsyncSearchAnchor extends StatefulWidget {
//   const _AsyncSearchAnchor();
//
//   @override
//   State<_AsyncSearchAnchor> createState() => _AsyncSearchAnchorState();
// }
//
// class _AsyncSearchAnchorState extends State<_AsyncSearchAnchor> {
//   // The query currently being searched for. If null, there is no pending
//   // request.
//   String? _currentQuery;
//
//   // The most recent suggestions received from the API.
//   late Iterable<Widget> _lastOptions = <Widget>[];
//
//   late final Debounceable<Iterable<String>?, String> _debouncedSearch;
//
//   // Calls the "remote" API to search with the given query. Returns null when
//   // the call has been made obsolete.
//   Future<Iterable<String>?> _search(String query) async {
//     _currentQuery = query;
//
//     final db = appLocator<DbManager>().db;
//     // In a real application, there should be some error handling here.
//     final Iterable<String> options = await _FakeAPI.search(_currentQuery!);
//
//     // If another search happened after this one, throw away these options.
//     if (_currentQuery != query) {
//       return null;
//     }
//     _currentQuery = null;
//
//     return options;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _debouncedSearch = debounce<Iterable<String>?, String>(_search);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SearchAnchor(
//       builder: (BuildContext context, SearchController controller) {
//         return IconButton(
//           icon: const Icon(Icons.search),
//           onPressed: () {
//             controller.openView();
//           },
//         );
//       },
//       suggestionsBuilder: (BuildContext context, SearchController controller) async {
//         final List<String>? options = (await _debouncedSearch(controller.text))?.toList();
//         if (options == null) {
//           return _lastOptions;
//         }
//         _lastOptions = List<ListTile>.generate(options.length, (int index) {
//           final String item = options[index];
//           return ListTile(
//             title: Text(item),
//             onTap: () {
//               debugPrint('You just selected $item');
//             },
//           );
//         });
//
//         return _lastOptions;
//       },
//     );
//   }
// }
