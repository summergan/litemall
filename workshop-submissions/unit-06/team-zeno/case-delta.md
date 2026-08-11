# Case Delta

- Existing test method：`mallBrowseAc04BeUt001_relatedRejectsUnknownGoodsAndUsesCategoryRecommendations`
- Delta type：`extend`
- Input/fixture before：`when(goodsService.queryByCategory(20, 0, 6)).thenReturn(Collections.singletonList(related));`（Mock 只返回相关商品 `101`）
- Input/fixture after：`when(goodsService.queryByCategory(20, 0, 6)).thenReturn(Arrays.asList(goods, related));`（Mock 同时返回当前商品 `100` 与 `101`）
- Assertion before：`assertEquals(Collections.singletonList(related), relatedData.get("list"));` 在旧 fixture 下通过（`list` 仅含 `101`）。
- Assertion after：保持同一断言 `assertEquals(Collections.singletonList(related), relatedData.get("list"));`，但在新 fixture 下失败，因为实际 `list` 仍包含 `100`。
- Why this is the minimum delta：仅改动一行 stub，使 Mock 暴露“当前商品未排除”的缺陷；断言保持不变即能精准暴露 `WxGoodsController.related` 未过滤当前 `id` 的事实，无需修改其他方法或生产代码。
- Production files intentionally unchanged：`WxGoodsController.java` 未修改；其他 AC 方法（AC01~AC03、AC05、AC06）未改动。
