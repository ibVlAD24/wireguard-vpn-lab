# WireGuard VPN Lab

## 📌 Описание
Проект демонстрирует настройку WireGuard VPN-туннеля между сервером и клиентом на одной машине (тестовая среда).

## 🛠️ Технологии
- Ubuntu 22.04
- WireGuard

## 🔧 Как это работает

1. Генерация ключей (приватный и публичный для сервера и клиента)
2. Конфигурация сервера (`wg0.conf`)
3. Конфигурация клиента (`client.conf`)
4. Запуск интерфейсов через `wg-quick`
5. Проверка связи через пинг

## 🚀 Запуск

```bash
# Установка
sudo apt update
sudo apt install wireguard -y

# Генерация ключей
wg genkey | tee server_private.key | wg pubkey > server_public.key
wg genkey | tee client_private.key | wg pubkey > client_public.key

# Копирование конфигов
sudo cp configs/wg0.conf /etc/wireguard/
sudo cp configs/client.conf /etc/wireguard/

# Запуск
sudo wg-quick up wg0
sudo wg-quick up client

# Проверка
ping -c 4 10.0.0.1
ping -c 4 10.0.0.2







Отлично. Сейчас сделаем **полный цикл**: подготовим папку, скопируем конфиги без ключей, сделаем скриншоты и зальём на GitHub. Всё через терминал.

---

## 🐳 Часть 1. Подготовка папки проекта

```bash
mkdir -p ~/wireguard-vpn-lab/configs
mkdir -p ~/wireguard-vpn-lab/screenshots
mkdir -p ~/wireguard-vpn-lab/scripts
cd ~/wireguard-vpn-lab
```

---

## 📄 Часть 2. Создаём конфиги без ключей

### Конфиг сервера (без приватных данных)

```bash
nano configs/wg0.conf
```

Скопируй и вставь:

```ini
[Interface]
PrivateKey = <your_server_private_key>
Address = 10.0.0.1/24
ListenPort = 51820
SaveConfig = false

[Peer]
PublicKey = <your_client_public_key>
AllowedIPs = 10.0.0.2/32
```

Сохрани: `Ctrl+O`, `Enter`, `Ctrl+X`

---

### Конфиг клиента (без ключей)

```bash
nano configs/client.conf
```

Скопируй и вставь:

```ini
[Interface]
PrivateKey = <your_client_private_key>
Address = 10.0.0.2/24

[Peer]
PublicKey = <your_server_public_key>
Endpoint = 127.0.0.1:51820
AllowedIPs = 10.0.0.0/24
PersistentKeepalive = 25
```

Сохрани.

---

## 🔧 Часть 3. Скрипт генерации ключей (по желанию)

```bash
nano scripts/generate-keys.sh
```

Скопируй:

```bash
#!/bin/bash
wg genkey | tee server_private.key | wg pubkey > server_public.key
wg genkey | tee client_private.key | wg pubkey > client_public.key
echo "Ключи сгенерированы:"
ls -la *.key
```

Сделай исполняемым:

```bash
chmod +x scripts/generate-keys.sh
```

---

## 📸 Часть 4. Создаём скриншоты (через терминал)

### Скриншот 1: пинг

```bash
ping -c 4 10.0.0.1 > screenshots/ping.txt
```

Или сделай скриншот окна терминала через `gnome-screenshot`:

```bash
gnome-screenshot -w -d 2 -f screenshots/ping.png
```

(Выбери окно с пингом)

---

### Скриншот 2: статус WireGuard

```bash
sudo wg show > screenshots/wg-show.txt
```

Или скриншот:

```bash
gnome-screenshot -w -d 2 -f screenshots/wg-show.png
```

---

## 📝 Часть 5. Создаём README.md

```bash
nano README.md
```

Скопируй:

```markdown
# WireGuard VPN Lab

## 📌 Описание
Проект демонстрирует настройку WireGuard VPN-туннеля между сервером и клиентом на одной машине (тестовая среда).

## 🛠️ Технологии
- Ubuntu 22.04
- WireGuard

## 🔧 Как это работает

1. Генерация ключей (приватный и публичный для сервера и клиента)
2. Конфигурация сервера (`wg0.conf`)
3. Конфигурация клиента (`client.conf`)
4. Запуск интерфейсов через `wg-quick`
5. Проверка связи через пинг

## 🚀 Запуск

```bash
# Установка
sudo apt update
sudo apt install wireguard -y

# Генерация ключей
wg genkey | tee server_private.key | wg pubkey > server_public.key
wg genkey | tee client_private.key | wg pubkey > client_public.key

# Копирование конфигов
sudo cp configs/wg0.conf /etc/wireguard/
sudo cp configs/client.conf /etc/wireguard/

# Запуск
sudo wg-quick up wg0
sudo wg-quick up client

# Проверка
ping -c 4 10.0.0.1
ping -c 4 10.0.0.2
```

## 📸 Результат

| Пинг работает | Статус интерфейсов |
|---------------|--------------------|
| ![ping](screenshots/ping.png) | ![wg-show](screenshots/wg-show.png) |

## 📂 Структура проекта

```
wireguard-vpn-lab/
├── configs/
│   ├── wg0.conf
│   └── client.conf
├── screenshots/
│   ├── ping.png (или ping.txt)
│   └── wg-show.png (или wg-show.txt)
├── scripts/
│   └── generate-keys.sh
└── README.md
```

## 🧑‍💻 Автор
ibVLAD24

