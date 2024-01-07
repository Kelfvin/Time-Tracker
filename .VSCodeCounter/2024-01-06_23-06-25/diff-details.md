# Diff Details

Date : 2024-01-06 23:06:25

Directory c:\\Users\\49440\\Desktop\\Time-Tracker

Total : 43 files,  77 codes, 17 comments, 25 blanks, all 119 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/common/controller/category_controller.dart](/lib/common/controller/category_controller.dart) | Dart | 12 | 0 | 4 | 16 |
| [lib/common/controller/record_controller.dart](/lib/common/controller/record_controller.dart) | Dart | 20 | 7 | 7 | 34 |
| [lib/common/controller/user_controller.dart](/lib/common/controller/user_controller.dart) | Dart | 76 | 15 | 25 | 116 |
| [lib/common/dao/category_dao.dart](/lib/common/dao/category_dao.dart) | Dart | 4 | 0 | 0 | 4 |
| [lib/common/dao/event_dao.dart](/lib/common/dao/event_dao.dart) | Dart | 0 | 0 | -4 | -4 |
| [lib/common/dao/record_dao.dart](/lib/common/dao/record_dao.dart) | Dart | 20 | 6 | 5 | 31 |
| [lib/common/dao/user_dao.dart](/lib/common/dao/user_dao.dart) | Dart | 5 | 1 | 1 | 7 |
| [lib/common/model/category.dart](/lib/common/model/category.dart) | Dart | -27 | -1 | -6 | -34 |
| [lib/common/model/event_category.dart](/lib/common/model/event_category.dart) | Dart | 27 | 1 | 6 | 34 |
| [lib/common/model/event_record.dart](/lib/common/model/event_record.dart) | Dart | 30 | 2 | 6 | 38 |
| [lib/common/model/record.dart](/lib/common/model/record.dart) | Dart | -30 | -2 | -6 | -38 |
| [lib/common/user_manager.dart](/lib/common/user_manager.dart) | Dart | -63 | -12 | -22 | -97 |
| [lib/main.dart](/lib/main.dart) | Dart | 4 | 1 | 1 | 6 |
| [lib/page/activity/activity_controller.dart](/lib/page/activity/activity_controller.dart) | Dart | -1 | -1 | -1 | -3 |
| [lib/page/activity/activity_page.dart](/lib/page/activity/activity_page.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/page/activity/widget/activiting_widget.dart](/lib/page/activity/widget/activiting_widget.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/page/activity/widget/event_button.dart](/lib/page/activity/widget/event_button.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/page/category_manage/widget/category_event_list.dart](/lib/page/category_manage/widget/category_event_list.dart) | Dart | -22 | -2 | -2 | -26 |
| [lib/page/home/view.dart](/lib/page/home/view.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/page/login_register/view.dart](/lib/page/login_register/view.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/page/login_register/widgets/body.dart](/lib/page/login_register/widgets/body.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/page/login_register/widgets/login_form.dart](/lib/page/login_register/widgets/login_form.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/page/login_register/widgets/register_form.dart](/lib/page/login_register/widgets/register_form.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/page/record_list/record_list_page.dart](/lib/page/record_list/record_list_page.dart) | Dart | 10 | 0 | 1 | 11 |
| [lib/page/setting/setting_page.dart](/lib/page/setting/setting_page.dart) | Dart | -7 | 2 | 1 | -4 |
| [lib/page/statistic/statistic.dart](/lib/page/statistic/statistic.dart) | Dart | -26 | 0 | -3 | -29 |
| [lib/page/statistic/view.dart](/lib/page/statistic/view.dart) | Dart | 26 | 0 | 3 | 29 |
| [lib/page/time_line/record_list/record_list_page.dart](/lib/page/time_line/record_list/record_list_page.dart) | Dart | 7 | 0 | 1 | 8 |
| [lib/page/time_line/time_line_page.dart](/lib/page/time_line/time_line_page.dart) | Dart | 2 | 1 | -1 | 2 |
| [lib/page/time_line/time_line_page_controller.dart](/lib/page/time_line/time_line_page_controller.dart) | Dart | 23 | 0 | 9 | 32 |
| [lib/page/time_line/timegrid/timgrid_controller.dart](/lib/page/time_line/timegrid/timgrid_controller.dart) | Dart | 196 | 53 | 54 | 303 |
| [lib/page/time_line/timegrid/view.dart](/lib/page/time_line/timegrid/view.dart) | Dart | 26 | 1 | 7 | 34 |
| [lib/page/time_line/timegrid/widget/category_event_line/category_button.dart](/lib/page/time_line/timegrid/widget/category_event_line/category_button.dart) | Dart | 102 | 5 | 14 | 121 |
| [lib/page/time_line/timegrid/widget/category_event_line/category_event_line.dart](/lib/page/time_line/timegrid/widget/category_event_line/category_event_line.dart) | Dart | 21 | 3 | 8 | 32 |
| [lib/page/time_line/timegrid/widget/time_line_bar/time_line_bar.dart](/lib/page/time_line/timegrid/widget/time_line_bar/time_line_bar.dart) | Dart | 21 | 2 | 5 | 28 |
| [lib/page/time_line/timegrid/widget/timegrid.dart](/lib/page/time_line/timegrid/widget/timegrid.dart) | Dart | 247 | 21 | 51 | 319 |
| [lib/page/timegrid/timgrid_controller.dart](/lib/page/timegrid/timgrid_controller.dart) | Dart | -195 | -53 | -58 | -306 |
| [lib/page/timegrid/view.dart](/lib/page/timegrid/view.dart) | Dart | -26 | -1 | -5 | -32 |
| [lib/page/timegrid/widget/category_event_line/category_button.dart](/lib/page/timegrid/widget/category_event_line/category_button.dart) | Dart | -97 | -5 | -14 | -116 |
| [lib/page/timegrid/widget/category_event_line/category_event_line.dart](/lib/page/timegrid/widget/category_event_line/category_event_line.dart) | Dart | -41 | -4 | -10 | -55 |
| [lib/page/timegrid/widget/time_line_bar/time_line_bar.dart](/lib/page/timegrid/widget/time_line_bar/time_line_bar.dart) | Dart | -21 | -2 | -5 | -28 |
| [lib/page/timegrid/widget/timegrid.dart](/lib/page/timegrid/widget/timegrid.dart) | Dart | -243 | -21 | -49 | -313 |
| [pubspec.yaml](/pubspec.yaml) | YAML | 0 | 0 | 1 | 1 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details