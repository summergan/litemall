import express from 'express';

const app = express();
app.use(express.json());

const products = [
  {
    id: 100,
    name: '青瓷杯',
    categoryId: 20,
    brandId: 5,
    isNew: true,
    isHot: true,
    retailPrice: 88.00,
    picUrl: '/static/goods-100.png',
    stock: 12,
    specification: '天青色'
  },
  {
    id: 101,
    name: '手冲壶',
    categoryId: 20,
    brandId: 5,
    isNew: false,
    isHot: true,
    retailPrice: 128.00,
    picUrl: '/static/goods-101.png',
    stock: 8,
    specification: '银色'
  },
  {
    id: 102,
    name: '茶盘',
    categoryId: 20,
    brandId: 6,
    isNew: false,
    isHot: false,
    retailPrice: 168.00,
    picUrl: '/static/goods-102.png',
    stock: 5,
    specification: '原竹色'
  }
];

let lastListQuery = '';

app.get('/browse', (_req, res) => {
  lastListQuery = '';
  res.type('html').send(`<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <title>litemall product discovery harness</title>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; margin: 48px; }
    main { max-width: 760px; }
    button { margin: 8px 8px 8px 0; padding: 10px 16px; }
    [data-testid] { margin: 10px 0; }
    .goods-card { display: block; width: 260px; text-align: left; }
  </style>
</head>
<body>
  <main>
    <h1>litemall 商品发现</h1>
    <div data-testid="new-goods-count">0</div>
    <div data-testid="hot-goods-count">0</div>
    <div data-testid="goods-list"></div>
    <button id="filter-new">只看新品</button>
    <div data-testid="query-log">未筛选</div>
    <section aria-label="商品详情">
      <h2 data-testid="product-name">未选择</h2>
      <div data-testid="product-price">未选择</div>
      <div data-testid="product-stock">未选择</div>
      <div data-testid="product-spec">未选择</div>
      <div data-testid="related-goods">未加载</div>
    </section>
  </main>
  <script>
    async function loadHome() {
      const response = await fetch('/wx/home/index');
      const json = await response.json();
      document.querySelector('[data-testid="new-goods-count"]').textContent = String(json.data.newGoodsList.length);
      document.querySelector('[data-testid="hot-goods-count"]').textContent = String(json.data.hotGoodsList.length);
      renderGoods(json.data.newGoodsList.concat(json.data.hotGoodsList));
    }

    function renderGoods(goods) {
      const container = document.querySelector('[data-testid="goods-list"]');
      container.innerHTML = '';
      goods.forEach((item) => {
        const button = document.createElement('button');
        button.className = 'goods-card';
        button.textContent = item.name + ' ¥' + item.retailPrice.toFixed(2);
        button.addEventListener('click', () => loadDetail(item.id));
        container.appendChild(button);
      });
    }

    async function filterNewGoods() {
      const response = await fetch('/wx/goods/list?isNew=true&page=1&limit=10&sort=retail_price&order=asc');
      const json = await response.json();
      renderGoods(json.data.list);
      document.querySelector('[data-testid="query-log"]').textContent = json.data.queryLog;
    }

    async function loadDetail(id) {
      const detailResponse = await fetch('/wx/goods/detail?id=' + id);
      const detailJson = await detailResponse.json();
      const relatedResponse = await fetch('/wx/goods/related?id=' + id);
      const relatedJson = await relatedResponse.json();
      const product = detailJson.data.productList[0];
      document.querySelector('[data-testid="product-name"]').textContent = detailJson.data.info.name;
      document.querySelector('[data-testid="product-price"]').textContent = '¥' + detailJson.data.info.retailPrice.toFixed(2);
      document.querySelector('[data-testid="product-stock"]').textContent = String(product.number);
      document.querySelector('[data-testid="product-spec"]').textContent = detailJson.data.specificationList[0].valueList[0].value;
      document.querySelector('[data-testid="related-goods"]').textContent = relatedJson.data.list.map((item) => item.name).join(',');
    }

    document.getElementById('filter-new').addEventListener('click', filterNewGoods);
    loadHome();
  </script>
</body>
</html>`);
});

app.get('/wx/home/index', (_req, res) => {
  res.json({
    errno: 0,
    data: {
      banner: [],
      channel: [{ id: 20, name: '茶器' }],
      newGoodsList: products.filter((item) => item.isNew),
      hotGoodsList: products.filter((item) => item.isHot).slice(0, 1),
      floorGoodsList: [{ id: 20, name: '茶器', goodsList: products }]
    }
  });
});

app.get('/wx/goods/list', (req, res) => {
  lastListQuery = new URLSearchParams(req.query).toString();
  let list = products.slice();
  if (req.query.isNew === 'true') list = list.filter((item) => item.isNew);
  if (req.query.isHot === 'true') list = list.filter((item) => item.isHot);
  if (req.query.keyword) list = list.filter((item) => item.name.includes(String(req.query.keyword)));
  if (req.query.sort === 'retail_price') list.sort((left, right) => left.retailPrice - right.retailPrice);
  if (req.query.order === 'desc') list.reverse();
  res.json({
    errno: 0,
    data: {
      list,
      total: list.length,
      page: Number(req.query.page || 1),
      limit: Number(req.query.limit || list.length),
      pages: 1,
      filterCategoryList: [{ id: 20, name: '茶器' }],
      queryLog: lastListQuery
    }
  });
});

app.get('/wx/goods/detail', (req, res) => {
  const goods = products.find((item) => item.id === Number(req.query.id));
  if (!goods) {
    res.status(404).json({ errno: 402, errmsg: '参数值不对' });
    return;
  }
  res.json({
    errno: 0,
    data: {
      info: goods,
      specificationList: [{ name: '颜色', valueList: [{ value: goods.specification }] }],
      productList: [{
        id: goods.id === 100 ? 9001 : 9000 + goods.id,
        goodsId: goods.id,
        price: goods.retailPrice,
        number: goods.stock,
        specifications: [goods.specification]
      }],
      attribute: [{ attribute: '材质', value: '瓷' }],
      brand: { id: goods.brandId, name: '器物集' }
    }
  });
});

app.get('/wx/goods/related', (req, res) => {
  const goods = products.find((item) => item.id === Number(req.query.id));
  if (!goods) {
    res.status(404).json({ errno: 402, errmsg: '参数值不对' });
    return;
  }
  const list = products.filter((item) => item.categoryId === goods.categoryId && item.id !== goods.id);
  res.json({ errno: 0, data: { list, total: list.length, page: 1, limit: list.length, pages: 1 } });
});

app.listen(4179, '127.0.0.1', () => {
  console.log('product discovery harness listening on http://127.0.0.1:4179/browse');
});
