'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f7651f633d6d52d96a1ef1cf779b4063",
"version.json": "868c6fca6cfa40393c07f0ab75b73b60",
"index.html": "cfa8d13d3ab7c6f4d73fdb61b1660315",
"/": "cfa8d13d3ab7c6f4d73fdb61b1660315",
"main.dart.js": "4655c6c71db1ef854a2a7cc6aaec402b",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"assets/shopping_assets/grocery.gif": "3e6602f525d24078efa4e05406c89dff",
"assets/shopping_assets/images/dairy_eggs/cover.png": "5fa39628d486b265c7e1a29aa77aa7ba",
"assets/shopping_assets/images/bakery_snacks/cover.png": "d1cb049b7f9cf4f53073dec15eb8bde6",
"assets/shopping_assets/images/cooking_oil/cooking_cover.png": "1c9e00f17ebea192cb90b97e580ed809",
"assets/shopping_assets/images/vegetables/vegetables_cover.png": "f5e39673785c6c6ea650bb62fcc60ef3",
"assets/shopping_assets/images/vegetables/potato.png": "143e5631d252768892438a0d82e32331",
"assets/shopping_assets/images/vegetables/carrot.png": "7c2adc3b3ef9048af76323527a2a5fee",
"assets/shopping_assets/images/vegetables/onion.png": "22aff902b4b4695eec1ba21f495a4f46",
"assets/shopping_assets/images/vegetables/tomato.png": "e77d5e23501f19eb257a0ee9f71bf906",
"assets/shopping_assets/images/vegetables/red_chillies.png": "31f17cffe6433ab9549d163cbb59dd8f",
"assets/shopping_assets/images/vegetables/cucumber.png": "b92f6f9ff4492ad8e334e539155126fb",
"assets/shopping_assets/images/user.png": "6d542556f67c0c9e709a010e7fbd8981",
"assets/shopping_assets/images/beverage/cover.png": "9c1094f36f47f54fe22a9dca95816e15",
"assets/shopping_assets/images/fruits/pineapple.png": "9905a03e9ee41f13b60bba511c2a2a35",
"assets/shopping_assets/images/fruits/mango.png": "0a3d6f26ebd567d3f215ea57e2f1cd99",
"assets/shopping_assets/images/fruits/orange.png": "87b0ea6e4b17a4cf6e0b5e1782830bfb",
"assets/shopping_assets/images/fruits/apple.png": "329677ef5e8ac2578e022b326f4d294d",
"assets/shopping_assets/images/fruits/cover.png": "bc86ecf6566d179906c344d1c994060c",
"assets/shopping_assets/images/fruits/lemon.png": "4fd4a9f3559e1303db109184bd4d3f13",
"assets/shopping_assets/images/fruits/banana.png": "d4b231a5b3613b57f41419aba9d8a44d",
"assets/shopping_assets/grocery.png": "1a5292f27d2939fe1b3dc4cdb5c0b773",
"assets/shopping_assets/grocery_responsive.gif": "3e6602f525d24078efa4e05406c89dff",
"assets/shopping_assets/icons/search.svg": "654e22ab2ad459d56cff69b1e077c53f",
"assets/shopping_assets/icons/bag_1.svg": "63e5245b06f0a2341dba8d0d9f81014b",
"assets/shopping_assets/icons/cart.svg": "fd320d807686c8432b2e449a583296b1",
"assets/shopping_assets/icons/back.svg": "1b13e0b59c27ec75d6f5051e5d66e8d9",
"assets/shopping_assets/icons/add_to_cart.svg": "0eb1a5e481ee24dba9de843a9dacdde1",
"assets/shopping_assets/icons/heart.svg": "1c996a5addb1570d53d2093a229b8ac8",
"assets/shopping_assets/nav_drawer_image.png": "cf46a5f721f1552ab214a71fe82a38d7",
"assets/shopping_assets/welcome.png": "f4c21298dbb060f1d63675788ae5e842",
"assets/NOTICES": "8a19eb41ec4570688b73f1c42698ec3b",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "d754f2e967e4804398b61fea63b5d0f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "00f6541cf105a0cd1f36d7e8a6cbc1e6",
"assets/fonts/MaterialIcons-Regular.otf": "8d6d105d91cffd40fa6cababd270b613",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
