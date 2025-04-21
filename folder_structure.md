
```text
features/
├── dashboard/
│   ├── presentation/
│   │   ├── dashboard_screen.dart
│   │   ├── dashboard_view_model.dart
│   │   └── widgets/
│   ├── application/
│   │   └── use_cases/
│   │       ├── load_dashboard_summaries_use_case.dart
│   │       ├── trigger_manual_sync_use_case.dart
│   │       └── get_last_sync_info_use_case.dart
│   └── domain/
│       ├── services/
│       └── entities/
│
├── settings/
│   ├── presentation/
│   │   ├── settings_screen.dart
│   │   ├── view_models/
│   │   │   ├── appearance_settings_view_model.dart
│   │   │   ├── user_settings_view_model.dart
│   │   │   └── sync_settings_view_model.dart
│   │   └── widgets/
│   ├── application/
│   │   └── use_cases/
│   │       ├── update_user_profile_use_case.dart
│   │       ├── update_sync_interval_use_case.dart
│   │       ├── load_sync_status_use_case.dart
│   │       └── change_theme_mode_use_case.dart
│   └── domain/
│       ├── services/
│       ├── entities/
│       └── repositories/
│
├── sync/
│   ├── domain/
│   │   ├── repositories/
│   │   ├── services/
│   │   └── entities/
│   ├── application/
│   │   └── use_cases/
│   │       ├── perform_sync_now_use_case.dart
│   │       ├── get_sync_status_use_case.dart
│   │       └── schedule_background_sync_use_case.dart
│   └── infrastructure/
│       └── sync_service_impl.dart
│
├── organization/              # Previously discussed
│   ├── domain/
│   │   ├── entities/user.dart
│   │   └── repositories/user_repository.dart
│   └── application/
│       └── use_cases/get_current_user_use_case.dart

```