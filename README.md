# BLOCK ARENA 2.0

Мобильная коллекционная браузерная игра: кейсы, бойцы, отряд, быстрые матчи, турниры, задания, облачное сохранение и таблица лидеров.

## Этап 1 — GitHub Pages

1. Загрузить файлы в репозиторий.
2. В GitHub открыть **Settings → Pages**.
3. Source выбрать **GitHub Actions**.
4. После деплоя игра будет доступна по адресу:

```text
https://Patsura.github.io/Block-arena/
```

Если выбран режим Deploy from branch, используйте:

```text
Branch: main
Folder: /root
```

## Этап 2 — Supabase

1. Создать проект в Supabase.
2. Открыть **SQL Editor** и выполнить файл `supabase/schema.sql`.
3. В Supabase открыть **Project Settings → API**.
4. Скопировать Project URL и anon public key.
5. В `config.js` заменить:

```js
SUPABASE_URL: 'PASTE_SUPABASE_PROJECT_URL',
SUPABASE_ANON_KEY: 'PASTE_SUPABASE_ANON_KEY'
```

После этого в игре заработают аккаунты, облачное сохранение и рейтинг.

## Этап 3 — Таблица лидеров

Таблица лидеров уже встроена во вкладку **Онлайн**. Она читает данные из таблицы `leaderboard` и сортирует игроков по кубкам.

## Этап 4 — PWA

PWA уже подключена через:

- `manifest.webmanifest`
- `sw.js`
- `icons/icon.svg`

После публикации по HTTPS игру можно добавить на экран телефона как приложение.

## Важно

Без Supabase игра работает полностью локально: прогресс хранится в браузере через `localStorage`. С Supabase прогресс можно переносить между устройствами.
