import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bazar/bazar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class BazarSearchBar extends StatefulWidget {
  const BazarSearchBar({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  _BazarSearchBarState createState() => _BazarSearchBarState();
}

class _BazarSearchBarState extends State<BazarSearchBar> {
  late final _controller = FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {
    const avatar =
        'https://warframe.market/static/assets/user/avatar/5816d390d3ffb6576c854571.png?1a8151c75d8c6438e039b3573bd50703';

    return FloatingSearchBar(
      controller: _controller,
      implicitDuration: const Duration(milliseconds: 250),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      margins: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      debounceDelay: const Duration(milliseconds: 500),
      body: widget.body,
      onSubmitted: (query) {
        BlocProvider.of<BazarOrdersCubit>(context).searchForOrders(query);
      },
      onQueryChanged: (query) {
        BlocProvider.of<BazarSearchBloc>(context).add(SearchItems(query));
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        const CircleAvatar(
          foregroundImage: CachedNetworkImageProvider(avatar),
        )
      ],
      builder: (context, transition) {
        return _ItemResults(controller: _controller);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ItemResults extends StatelessWidget {
  const _ItemResults({Key? key, required this.controller}) : super(key: key);

  final FloatingSearchBarController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BazarSearchBloc, BazarSearchState>(
      builder: (context, state) {
        if (state is BazarItemResults) {
          return Material(
            child: SizedBox(
              height: state.items.length > 10
                  ? (MediaQuery.of(context).size.height / 100) * 85
                  : null,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];

                  return InkWell(
                    onTap: () {
                      BlocProvider.of<BazarOrdersCubit>(context)
                          .searchForOrders(item.urlName);

                      if (controller.isOpen) {
                        controller.close();
                      }
                    },
                    child: ListTile(
                      leading: SizedBox(
                        width: 25,
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://warframe.market/static/assets/${item.thumb}'),
                      ),
                      title: Text(item.itemName),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Material(
            child: SizedBox(
              height: 100,
              child: Center(
                child: state is LoadingResults
                    ? const CircularProgressIndicator()
                    : const Text('Try searching for something first'),
              ),
            ),
          );
        }
      },
    );
  }
}
