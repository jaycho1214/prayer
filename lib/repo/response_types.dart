class PaginationResponse<ItemType, CursorType> {
  final List<ItemType>? items;
  final CursorType? cursor;
  final String? error;

  PaginationResponse({
    required this.items,
    this.cursor,
    this.error,
  }) : assert(
            error == null && items != null || (error != null || items == null));
}
