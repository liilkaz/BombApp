# 💣 BombApp
<img src="https://github.com/liilkaz/BombApp/assets/86955276/c588f231-8d89-4616-864b-b3293e9550c6" width="900">

---

**CHALLENGE №1 “БОМБА” [(SWIFTMARATHON 8.0)](https://t.me/swiftmarathon)**
* Проект на Swift 5
* Минимальная поддерживаемая iOS – 15
* Только iPhone и портретная ориентация экрана.
* Архитектура MVVM+Redux
* Сторонние библиотеки: Lottie
* Сохранение: UserDefaults
* Тесты

---

<img width="1670" alt="2023-08-12_22 22 17" src="https://github.com/liilkaz/BombApp/assets/86955276/27b6dec4-0f3a-46f3-b2cd-7572941336af">

---
# Базовое задание:

**Главный экран**

* На Главном экране изображение бомбы и три кнопки:
* "Старт игры" - ведёт на Экран с игрой.
* "Категории"- ведет на Экран с выбором категории.
* "Правила" - открывает правила игры

**Экран Игры**

* В начале новой игры, появляется кнопка “Запустить”, лейбл с текстом “Нажмите запустить, чтобы начать игру” и бомба. После запуска игры, начинается раунд.
* На экране игры отображается бомба и вопрос. Вопросы такие, на которые можно ответить много раз.
* Добавлена анимация бомбы, с помощью библиотеки Lottie
* Во время раунда проигрывается фоновая музыка и звук фитиля
* На экране присутствует кнопка паузы, останавливающая таймер, и кнопка возвращения в главное меню.
* Бомба в базовом варианте взрывается через 30 секунд после старта игры.
* После взрыва бомбы производится звук взрыва, выскакивает рандомное наказание, кнопка “другое наказание” и кнопка “начать заново”.

**Экран “Категории”**

* На экране предложено 6 категорий: "О разном", "Спорт и хобби", "Про жизнь", "Знаменитости", "Искусство и Кино", "Природа"
* В каждой категории по 15 вопросов

# Продвинутое задание*:

**Экран “Настроек”**

* На главном экране кнопка “Настройки”  с возможностью менять:
    * Время игры:
        * Короткое (10 секунд)
        * Среднее (20 секунд)
        * Длинное (45 секунд)
        * Случайное (от 10 до 45)
    * Звуки в игре:
        * Фоновая музыка (3 варианта)
        * Тиканье бомбы (3 варианта)
        * Взрыв бомбы (3 варианта)
    * Отключать и включать следующие функции:
        * Фоновую музыку в игре
        * Задания после взрыва бомбы.
        * Вибрацию
        
**Экран “Игры”**

* На главном экране появляется кнопка “Продолжить”, которая запускает игру с того момента, на котором закончил пользователь. Сохранение реализовано через UserDefaults.

**Экран “Правил”**

* Дополнены правила на странице настроек.

---
**TEAM FIFTEEN:**
+ [Liliya Feodotova](https://github.com/liilkaz) (Тимлид команды)
+ [Ilia Shapovalov](https://github.com/ShapovalovIlya)
+ [Mikhail Kasharin](https://github.com/KashMihdi)
+ [Vladislav Golyakov](https://github.com/dsm5e)
