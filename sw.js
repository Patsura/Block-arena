const CACHE_NAME = 'block-arena-v3-2026-05-17';

// Список основных файлов приложения, которые должны быть доступны офлайн.
const ASSETS = [
  './',
  './index.html',
  './manifest.webmanifest',
  './config.js',
  './icons/icon.svg',
];

// Установка service worker: открываем текущий кэш, сохраняем все ресурсы и сразу активируем новую версию.
self.addEventListener('install', event => {
  event.waitUntil(
    caches
      .open(CACHE_NAME)
      .then(cache => cache.addAll(ASSETS))
      .then(() => self.skipWaiting()),
  );
});

// Активация service worker: удаляем все старые кэши и берём управление открытыми страницами.
self.addEventListener('activate', event => {
  event.waitUntil(
    caches
      .keys()
      .then(keys => Promise.all(keys.filter(key => key !== CACHE_NAME).map(key => caches.delete(key))))
      .then(() => self.clients.claim()),
  );
});

// Перехват сетевых запросов: для GET сначала ищем ответ в кэше, затем обращаемся к сети.
self.addEventListener('fetch', event => {
  if (event.request.method !== 'GET') {
    return;
  }

  event.respondWith(
    caches.match(event.request).then(cachedResponse => {
      if (cachedResponse) {
        return cachedResponse;
      }

      return fetch(event.request).catch(() => caches.match('./index.html'));
    }),
  );
});
