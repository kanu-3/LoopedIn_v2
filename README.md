# loopedin_v2

A sustainable fashion exchange platform built with Flutter + Supabase + ML that enables users to buy, rent, donate, and resell clothing in a social marketplace environment alongside recommendations.

---

## 🚀 Overview

**LoopedIn v2** is a sustainable fashion ecosystem designed to reduce textile waste by enabling peer-to-peer fashion exchange.

It combines:
- Social feed-based marketplace
- Rental + resale system
- Donation & giveaway flows
- Trust-based verified user ecosystem
- Real-time interactions and notifications
- Recommendation system

---

## ✨ Key Features

### 🛍️ Marketplace System
- Buy, rent, or list products
- Rent-only or hybrid pricing support
- Product image gallery via Supabase Storage
- Category-based browsing
- Product details with seller context

### 📱 Social Feed Interface
- Instagram-style product feed
- Like, comment, and share interactions (in progress)
- Product discovery through social browsing
- Stories-style UI section

## 🤖 AI & Recommendations
- Content based recommendation
- Personalized product feed
- Smart pricing suggestions
- Demand and trend prediction

### 🔍 Smart Search
- User search overlay (not product search)
- Fast filtering and discovery of sellers/users

### ♻️ Sustainability Features
- Donation system for unused clothing
- Giveaway listings
- Circular fashion promotion

### 🚨 SOS System
- Verified users can request urgent outfit needs
- Time-sensitive rental requests
- Trust-based fulfillment system

### 🔔 Notification System (In Progress)
- Alerts for urgent requests
- Product interactions and updates
- Rental due reminders

---

## 🧠 Architecture

### 📦 State Management
- **Riverpod (StateNotifier-based architecture)**
- Clean separation of UI, state, and data layers

### 🏗️ Clean Architecture Structure (overview)

```
lib/
│
├── main.dart
│
├── app/
│   ├── app.dart
│   └── router.dart
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   ├── asset_paths.dart
│   │   └── supabase_constants.dart
│   │
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── text_theme.dart
│   │   └── color_scheme.dart
│   │
│   ├── services/
│   │   ├── supabase_service.dart
│   │   ├── storage_service.dart
│   │   └── notification_service.dart
│   │
│   ├── widgets/
│   │   ├── buttons/
│   │   ├── fields/
│   │   ├── navigation/
│   │   ├── product/
│   │   ├── chat/
│   │   ├── profile/
│   │   └── common/
│   │
│   └── utils/
│       ├── validators.dart
│       ├── formatters.dart
│       └── helpers.dart
│
├── models/
│   ├── user_models/
│   ├── product_models/
│   ├── social_models/
│   ├── chat_models/
│   ├── order_models/
│   ├── sos_models/
│   └── notification_models/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── profile/
│   ├── products/
│   ├── categories/
│   ├── cart/
│   ├── wishlist/
│   ├── orders/
│   ├── rentals/
│   ├── chat/
│   ├── notifications/
│   ├── sos/
│   └── recommendations/
│
└── assets/
    ├── images/
    └── fonts/
```
---

## 🧩 Core Modules

### 🔐 Authentication
- Email/password login & signup
- AuthStateNotifier (Riverpod)
- Secure session handling via Supabase

---

### 🛍️ Products Module
- Product creation with image upload pipeline
- Rent + buy pricing support
- Edit product via prefilled AddProductScreen
- Delete product with storage cleanup

---

### 🏠 Home Module
- Social feed (HomeFeedModel)
- User search overlay
- Product + seller combined feed structure
- Feed interaction system (likes/comments in progress)

---

### 🛒 Cart Module
- Add/remove items
- Quantity management
- Supports purchase types:
  - Buy
  - Rent

---

### 💬 Chat Module
- Buyer-seller communication
- Negotiation for rent/price

---

## 🎨 UI / UX System

### Design Language
- Green + White theme
- Clean marketplace aesthetic
- Social-first interaction model

### Core Components
- `AppBottomNavbar` (Animated Notch Navigation)
- `ProductCard` (Feed UI component)
- `AppButton` (Reusable primary/secondary styles)

---

---

## ⚙️ Tech Stack

| Layer | Technology |
|------|------------|
| Frontend | Flutter |
| State Management | Riverpod (StateNotifier) |
| Backend | Supabase + FastAPI |
| Database | PostgreSQL (via Supabase) |
| Storage | Supabase Storage |
| Routing | GoRouter |
| Architecture | Clean Architecture |

---

## 📈 Current Progress

### ✅ Completed
- Authentication flow (full stack)
- ProductDetailsScreen (central screen refactor)
- Product upload pipeline (images + DB + storage mapping)
- Feed UI foundation
- Product listing + retrieval
- AppShell navigation
- Core architecture setup
- Cart system basic logic
- Social media flow
- Offer negotiation system
- Chat system
- SOS expansion logic
- Recommendation system

# 🚀 Future Enhancements 

## 💳 Payments & Monetization
- Payment gateways (UPI, cards, wallets)
- Escrow-based secure transactions
- Refund & dispute handling system

## 🎁 Rewards & Gamification
- Points for listings, sales, and engagement
- User levels and trust badges
- Redeemable rewards store
- Streak-based incentives

## 💬 Chat System Upgrade
- Group chats for buyers and sellers
- Product sharing inside chats
- Negotiation mode for pricing/rent
- Read receipts and reactions

## 🔔 Notifications System
- Real-time in-app + push notifications
- Offer, order, and rental alerts
- Smart priority-based delivery

## 🛡️ Trust & Safety
- User verification system (KYC-based)
- Reputation and trust scoring
- Fraud detection mechanisms

## 🤖 Advanced AI & Recommendations
- Personalized product feed
- Smart pricing suggestions
- Demand and trend prediction

## 🚚 Logistics Integration
- Delivery partner integration
- Pickup and return scheduling
- Live order tracking

## 🌐 Social Expansion
- Fashion-based communities
- User following system
- Rich media feed (posts, reels-style content)

## 📊 Analytics Dashboard
- Seller performance insights
- Product engagement metrics
- Platform-level trend analytics

---

## 🧠 Design Principles

- Feature-first modular architecture
- Reusable UI components
- Strict separation of concerns
- Scalable Supabase schema design
- Production-level state handling (Riverpod)

### Find full case study and design here : https://www.behance.net/gallery/224997633/LoopedIn-Sustainable-fashion-exchange-app

---

## 📌 Project Goal

To build a **real-world sustainable fashion marketplace** that blends:
- Social interaction
- Circular economy principles
- Trust-based transactions
- Scalable backend architecture
- Machine learning

---

## 🧑‍💻 Author

**Kanishka Jha**  
B.Tech, AKGEC Ghaziabad  
Flutter + Backend Developer + ML Engineer                                                                                    
Aim: Product AI Engineer

---

## ⭐ If you like this project

Consider starring the repo and contributing ideas for sustainability-driven features.

