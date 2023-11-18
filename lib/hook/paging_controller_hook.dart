import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<PageKeyType, ItemType>
    usePagingController<PageKeyType, ItemType>({
  required PageKeyType firstPageKey,
  int? invisibleItemsThreshold,
}) {
  return use(_PagingControllerHook(
    firstPageKey: firstPageKey,
    invisibleItemsThreshold: invisibleItemsThreshold,
  ));
}

class _PagingControllerHook<PageKeyType, ItemType>
    extends Hook<PagingController<PageKeyType, ItemType>> {
  const _PagingControllerHook({
    required this.firstPageKey,
    this.invisibleItemsThreshold,
    super.keys,
  });

  final PageKeyType firstPageKey;
  final int? invisibleItemsThreshold;

  @override
  _PagingControllerHookState<PageKeyType, ItemType> createState() =>
      _PagingControllerHookState();
}

class _PagingControllerHookState<PageKeyType, ItemType> extends HookState<
    PagingController<PageKeyType, ItemType>,
    _PagingControllerHook<PageKeyType, ItemType>> {
  late final PagingController<PageKeyType, ItemType> _controller =
      PagingController(
    firstPageKey: hook.firstPageKey,
    invisibleItemsThreshold: hook.invisibleItemsThreshold,
  );

  @override
  PagingController<PageKeyType, ItemType> build(BuildContext context) =>
      _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
