import 'package:bazar_repository/bazar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bazar/bazar.dart';
import 'package:market/bazar/widgets/recent_order_card.dart';
import 'package:market/bazar/widgets/search_bar.dart';
import 'package:market_client/market_client.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

class BazarOrdersView extends StatelessWidget {
  const BazarOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BazarOrdersCubit, BazarOrdersState>(
      builder: (context, state) {
        if (state is BazarOrdersLoaded) {
          return ScreenTypeLayout.builder(
            mobile: (_) => MobileBazarOrdersView(
              sellOrders: state.sellOrders,
              buyOrders: state.buyOrders,
            ),
            tablet: (_) => LargeBazarOrdersView(
              sellOrders: state.sellOrders,
              buyOrders: state.buyOrders,
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

class MobileBazarOrdersView extends StatefulWidget {
  const MobileBazarOrdersView({
    Key? key,
    required this.sellOrders,
    required this.buyOrders,
  }) : super(key: key);

  final List<ItemOrder> sellOrders;
  final List<ItemOrder> buyOrders;

  @override
  State<MobileBazarOrdersView> createState() => _MobileBazarOrdersViewState();
}

class _MobileBazarOrdersViewState extends State<MobileBazarOrdersView> {
  late final _controller = ScrollController();

  bool _controlleSearchBar(
    FloatingSearchBarState fsb,
    ScrollNotification notification,
  ) {
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
  }

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context)!;

    return NotificationListener<ScrollNotification>(
      onNotification: (n) => _controlleSearchBar(fsb, n),
      child: ListView.builder(
        controller: _controller,
        padding: EdgeInsets.only(
          top: fsb.widget.height +
              (fsb.widget.margins?.vertical ??
                  MediaQuery.of(context).viewPadding.top),
        ),
        itemCount: widget.sellOrders.length,
        itemBuilder: (_, index) {
          return RecentOrderCard(order: widget.sellOrders[index]);
        },
      ),
    );
  }
}

class LargeBazarOrdersView extends StatelessWidget {
  const LargeBazarOrdersView({
    Key? key,
    required this.sellOrders,
    required this.buyOrders,
  }) : super(key: key);

  final List<ItemOrder> sellOrders;
  final List<ItemOrder> buyOrders;

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context)!;
    final padding = EdgeInsets.only(
      top: fsb.widget.height +
          (fsb.widget.margins?.vertical ??
              MediaQuery.of(context).viewPadding.top),
    );

    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: buyOrders.length,
              itemBuilder: (_, index) {
                return RecentOrderCard(order: buyOrders[index]);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: sellOrders.length,
              itemBuilder: (_, index) {
                return RecentOrderCard(order: sellOrders[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
