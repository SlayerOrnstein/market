import 'package:bazar_repository/bazar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bazar/bazar.dart';
import 'package:market/bazar/widgets/recent_order_card.dart';
import 'package:market/bazar/widgets/search_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class BazarPage extends StatelessWidget {
  const BazarPage({Key? key, required BazarRepository repository})
      : _repository = repository,
        super(key: key);

  final BazarRepository _repository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BazarSearchBloc(_repository)),
        BlocProvider(create: (_) => BazarOrdersCubit(_repository)),
      ],
      child: const BazarView(),
    );
  }
}

class BazarView extends StatelessWidget {
  const BazarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: BazarSearchBar(
        body: BazarOrdersView(),
      ),
    );
  }
}

class BazarOrdersView extends StatefulWidget {
  const BazarOrdersView({Key? key}) : super(key: key);

  @override
  State<BazarOrdersView> createState() => _BazarOrdersViewState();
}

class _BazarOrdersViewState extends State<BazarOrdersView> {
  late final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context)!;

    return BlocBuilder<BazarOrdersCubit, BazarOrdersState>(
      builder: (context, state) {
        if (state is BazarOrdersLoaded) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                final controller = fsb.widget.controller;
                final direction = notification.direction;

                if (controller != null) {
                  if (notification.direction == ScrollDirection.reverse) {
                    controller.hide();
                  } else if (direction == ScrollDirection.forward) {
                    controller.show();
                  }
                }
              }

              return false;
            },
            child: ListView.builder(
              controller: _controller,
              padding: EdgeInsets.only(
                top: fsb.widget.height +
                    (fsb.widget.margins?.vertical ??
                        MediaQuery.of(context).viewPadding.top),
              ),
              itemCount: state.sellOrders.length,
              itemBuilder: (_, index) {
                return RecentOrderCard(order: state.sellOrders[index]);
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
