-- Create syntax for TABLE 'admin'
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'admin_id',
  `user_id` varchar(255) NOT NULL COMMENT 'user_id',
  `account_ban_authority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:権限なし, 1:管理者権限, 2:更新権限, 3:閲覧権限',
  `class_ban_authority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:権限なし, 1:管理者権限, 2:更新権限, 3:閲覧権限',
  `class_post_ban_authority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:権限なし, 1:管理者権限, 2:更新権限, 3:閲覧権限',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_2` (`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20400834 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'akamai_stream'
CREATE TABLE `akamai_stream` (
  `akamai_stream_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `class_id` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '授業ID',
  `stream_id` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'ストリームID',
  `camera_angle` int(32) unsigned NOT NULL DEFAULT '1' COMMENT 'カメラアングル',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '1:準備中, 2:公開中',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '配信用のユーザー名',
  `password` varchar(255) NOT NULL DEFAULT '' COMMENT '配信用のパスワード',
  `start_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '放送開始日',
  `end_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '放送終了日',
  `on_air_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '録画開始日',
  `off_air_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '録画終了日',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`akamai_stream_id`),
  KEY `class_id` (`class_id`),
  KEY `stream_id` (`stream_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1551 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'akamai_video'
CREATE TABLE `akamai_video` (
  `akamai_video_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `class_id` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '授業ID',
  `bit_rate` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'ビットレート',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`akamai_video_id`),
  UNIQUE KEY `class_id_bit_rate` (`class_id`,`bit_rate`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21398 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'alert_information'
CREATE TABLE `alert_information` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `text` text NOT NULL COMMENT 'お知らせのテキスト',
  `path` varchar(255) NOT NULL COMMENT '表示するページのパス',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除:1',
  `created_at` datetime DEFAULT NULL COMMENT '登録日時',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 COMMENT='授業の臨時お知らせ用テーブル';

-- Create syntax for TABLE 'android_receipt'
CREATE TABLE `android_receipt` (
  `order_id` varchar(255) NOT NULL COMMENT '継続課金されているユーザーが更新するたびにカウントアップされるGoogle WalletのOrderID',
  `user_id` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL COMMENT 'UserIDとSubscriptionIDを基にした一意な識別トークン',
  `receipt` text NOT NULL COMMENT 'json形式の購入情報',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ／0:未削除, 1:削除済',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Android月額課金のレシート管理テーブル';

-- Create syntax for TABLE 'announcement'
CREATE TABLE `announcement` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `provider_id` int(32) unsigned NOT NULL DEFAULT '0',
  `scope` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'アナウンスの対象(全体向け/団体個別向け等)',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'アナウンス開始日時',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'アナウンス終了日時',
  `message` text NOT NULL COMMENT 'お知らせ内容',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'アナウンスの重要度',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `start_end_date` (`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=4237 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'apple_receipt'
CREATE TABLE `apple_receipt` (
  `apple_receipt_id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `original_transaction_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザID',
  `receipt` mediumtext NOT NULL COMMENT 'base64エンコードを施したレシートデータ',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ／0:未削除, 1:削除済',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`apple_receipt_id`),
  KEY `user_id` (`user_id`,`flg_delete`),
  KEY `original_transaction_id` (`original_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'ar_internal_metadata'
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'article'
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_owner_id` int(11) NOT NULL COMMENT '1:3分, 2:授業系, 3:まとめ, 4:コラム',
  `faculty_id` int(11) NOT NULL DEFAULT '10001' COMMENT '10000:共通, 10001:指定なし',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '0:未公開 1:テスト公開 2:本番公開',
  `title` varchar(255) NOT NULL COMMENT '記事タイトル',
  `url` varchar(255) NOT NULL COMMENT '記事URL',
  `text` text NOT NULL COMMENT '記事本文',
  `fb_text` text NOT NULL,
  `ogp_image` varchar(255) DEFAULT NULL,
  `tw_text` text NOT NULL,
  `post_date` datetime NOT NULL COMMENT '記事投稿日',
  `regist_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `flg_delete` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'backoffice_users'
CREATE TABLE `backoffice_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `social_id` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT '',
  `email` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_backoffice_user_social_id` (`social_id`),
  UNIQUE KEY `index_backoffice_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='バックオフィスユーザ情報';

-- Create syntax for TABLE 'biz_introduction_companies'
CREATE TABLE `biz_introduction_companies` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '企業名',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0',
  `order` int(32) NOT NULL DEFAULT '0' COMMENT 'リスト内並び順',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_biz_introduction_companies_01` (`flg_delete`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='法人プラン導入企業例';

-- Create syntax for TABLE 'bot_dictionary'
CREATE TABLE `bot_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(100) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'category'
CREATE TABLE `category` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index, カテゴリーID',
  `name` varchar(100) NOT NULL COMMENT 'カテゴリー名',
  `parent_id` int(32) NOT NULL DEFAULT '0' COMMENT '親カテゴリーのID',
  `layer` enum('top','middle','bottom') NOT NULL DEFAULT 'top' COMMENT 'カテゴリーの種類(大/中/小)',
  `path` varchar(100) DEFAULT NULL COMMENT 'URLパス',
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`)
) ENGINE=InnoDB AUTO_INCREMENT=1173 DEFAULT CHARSET=utf8 COMMENT='クラス用のカテゴリー一覧';

-- Create syntax for TABLE 'chapter'
CREATE TABLE `chapter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `part` int(1) NOT NULL COMMENT 'パート',
  `num` int(5) NOT NULL COMMENT '連番',
  `sec` int(11) NOT NULL COMMENT '経過秒数',
  `title` varchar(255) NOT NULL COMMENT 'チャプタータイトル',
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`,`part`,`num`),
  KEY `class` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60407 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'chapter_201502201800'
CREATE TABLE `chapter_201502201800` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `part` int(1) NOT NULL COMMENT 'パート',
  `num` int(5) NOT NULL COMMENT '連番',
  `sec` int(11) NOT NULL COMMENT '経過秒数',
  `title` varchar(255) NOT NULL COMMENT 'チャプタータイトル',
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`,`part`,`num`),
  KEY `class` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'ci_sessions'
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`),
  KEY `user_session` (`session_id`,`user_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'class'
CREATE TABLE `class` (
  `class_id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index, 授業ID',
  `continuous_id` int(11) DEFAULT NULL COMMENT 'コースID',
  `class_type` int(11) NOT NULL DEFAULT '1' COMMENT '通常授業:1, 課外授業:2, かじり部:3',
  `ust_id` varchar(255) NOT NULL COMMENT 'ustream id',
  `ust_pwd` varchar(255) NOT NULL COMMENT 'ustream movie pass',
  `start_date` datetime NOT NULL COMMENT '放送開始時刻',
  `end_date` datetime NOT NULL COMMENT '放送終了時刻',
  `title` varchar(255) NOT NULL COMMENT '授業名',
  `capasity` int(32) NOT NULL DEFAULT '15' COMMENT '実定員（現地）',
  `capasity_apply` int(32) NOT NULL DEFAULT '18' COMMENT '申込受付定員(現地)',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '0:非公開 1:テスト公開 2:schoo内部コンテンツ本番公開 3:24時間チャンネル本番公開 4:公認チャンネル本番公開',
  `mail_notification_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Mail用通知ステータス/0:通知禁止 1:通知対象 2:通知中 3:通知済',
  `web_notification_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Web用通知ステータス/0:通知禁止 1:通知対象 2:通知中 3:通知済 ',
  `push_notification_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'iOS用通知ステータス/0:通知禁止 1:通知対象 2:通知中 3:通知済',
  `heading` varchar(255) DEFAULT NULL COMMENT '授業説明見出し',
  `summary` text NOT NULL COMMENT '授業概要',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除した場合1',
  `flg_corporation_ng` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '法人ユーザーが閲覧できない == 1',
  `classroom_id` int(11) NOT NULL COMMENT '教室（会場）ID',
  `entry_fee` int(11) NOT NULL DEFAULT '0' COMMENT '参加費',
  `purpose_1` varchar(255) DEFAULT NULL COMMENT '目的１',
  `purpose_2` varchar(255) DEFAULT NULL COMMENT '目的２',
  `purpose_3` varchar(255) DEFAULT NULL COMMENT '目的３',
  `purpose_4` varchar(255) DEFAULT NULL COMMENT '目的４',
  `purpose_5` varchar(255) DEFAULT NULL COMMENT '目的５',
  `preparation_1` varchar(255) DEFAULT NULL COMMENT '予習教材テキスト１',
  `preparation_2` varchar(255) DEFAULT NULL COMMENT '予習教材テキスト２',
  `preparation_3` varchar(255) DEFAULT NULL COMMENT '予習教材テキスト３',
  `preparation_4` varchar(255) DEFAULT NULL COMMENT '予習教材テキスト４',
  `preparation_5` varchar(255) DEFAULT NULL COMMENT '予習教材テキスト５',
  `preparation_url_1` varchar(255) DEFAULT NULL COMMENT '予習教材URL1',
  `preparation_url_2` varchar(255) DEFAULT NULL COMMENT '予習教材URL2',
  `preparation_url_3` varchar(255) DEFAULT NULL COMMENT '予習教材URL3',
  `preparation_url_4` varchar(255) DEFAULT NULL COMMENT '予習教材URL4',
  `preparation_url_5` varchar(255) DEFAULT NULL COMMENT '予習教材URL5',
  `photo_text_1` varchar(255) DEFAULT NULL COMMENT '写真1',
  `photo_url_1` varchar(255) DEFAULT NULL COMMENT '写真1URL',
  `photo_path_1` varchar(255) DEFAULT NULL COMMENT '写真1PATH',
  `photo_text_2` varchar(255) DEFAULT NULL COMMENT '写真２',
  `photo_url_2` varchar(255) DEFAULT NULL COMMENT '写真２URL',
  `photo_path_2` varchar(255) DEFAULT NULL COMMENT '写真２PATH',
  `photo_text_3` varchar(255) DEFAULT NULL COMMENT '写真３',
  `photo_url_3` varchar(255) DEFAULT NULL COMMENT '写真３URL',
  `photo_path_3` varchar(255) DEFAULT NULL COMMENT '写真３PATH',
  `form` tinyint(1) NOT NULL DEFAULT '1' COMMENT '授業種別(1:WEBのみ 2:WEBと現地)',
  `archive_status` int(1) NOT NULL DEFAULT '1' COMMENT '0:archive無 1:archive対象 2:archive準備完了 3:無料公開',
  `archive_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'archive準備完了',
  `slide_code` varchar(100) DEFAULT NULL,
  `total_slide_cnt` int(11) NOT NULL DEFAULT '0' COMMENT '授業の講義資料スライドの総数',
  `slideshare_uri` varchar(250) DEFAULT NULL COMMENT 'スライドシェアのURI',
  `bc_id` varchar(20) DEFAULT NULL COMMENT 'ブライトコーブmedia id',
  `bc_cut_sec` int(11) DEFAULT '0' COMMENT 'BC動画調整時間',
  `amazon_keyword` varchar(255) DEFAULT NULL,
  `twitter_text` text COMMENT 'twitter拡散文言',
  `facebook_text` text COMMENT 'facebook拡散文言',
  `format` varchar(255) DEFAULT NULL COMMENT '授業構成',
  `planner_text` text COMMENT '企画者の声',
  `youtube_id` varchar(100) DEFAULT NULL COMMENT 'youtube_id',
  `local_start_before_time` int(11) NOT NULL DEFAULT '48' COMMENT '申し込み可能になる時間',
  `provider_id` int(32) NOT NULL DEFAULT '1',
  `open_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '授業公開日時',
  `target_id` int(32) unsigned NOT NULL DEFAULT '1' COMMENT 'ターゲットID',
  `target` varchar(255) DEFAULT '' COMMENT 'ターゲット',
  `presenter_id` int(32) DEFAULT NULL COMMENT '学生代表ID',
  `director_id` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'ディレクターID',
  `is_akamai` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Akamai配信フラグ',
  `encode_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'エンコードステータス',
  `encode_date` datetime DEFAULT NULL COMMENT 'エンコード完了日',
  `encode_options` text COMMENT 'エンコードオプション（json形式）',
  `original_video_metadata` text COMMENT '元動画のメタデータ（json形式）',
  `slide_dl_status` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '1:DL不可, 2:DL準備中, 2:DL可',
  PRIMARY KEY (`class_id`),
  KEY `status_date` (`status`,`start_date`),
  KEY `continuous` (`continuous_id`),
  KEY `end_dt` (`end_date`),
  KEY `start_dt` (`start_date`),
  KEY `provider_id_start_date` (`provider_id`,`start_date`),
  KEY `archive_date` (`archive_date`)
) ENGINE=InnoDB AUTO_INCREMENT=4016 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'class_clicked_history'
CREATE TABLE `class_clicked_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `notice_user_id` varchar(255) NOT NULL COMMENT ' 通知先のuser_id',
  `class_id` int(11) NOT NULL COMMENT 'アクティビティを表示させたユーザーが視聴した授業ID',
  `click_user_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'アクティビティを表示させたuser_id',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='アクテビティ経由で授業を視聴した場合、視聴したことをアクティビティ表示ユーザーに通知する';

-- Create syntax for TABLE 'class_community_tags'
CREATE TABLE `class_community_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `identifier` varchar(100) NOT NULL DEFAULT '' COMMENT '識別子として扱う値',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'タグ名',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='コミュニティタグのマスターテーブル';

-- Create syntax for TABLE 'class_director'
CREATE TABLE `class_director` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '名前',
  `profile` text NOT NULL COMMENT 'プロフィール',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='授業ディレクター情報';

-- Create syntax for TABLE 'class_event_calendar'
CREATE TABLE `class_event_calendar` (
  `class_id` int(32) unsigned NOT NULL COMMENT 'クラスID',
  `calendar_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'カレンダーID',
  `event_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'カレンダー内のイベントID',
  `flg_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:有効, 1:無効',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`class_id`,`calendar_id`),
  KEY `calendar_id_event_id` (`calendar_id`,`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Googleカレンダーのイベント管理テーブル';

-- Create syntax for TABLE 'class_experience_types'
CREATE TABLE `class_experience_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'タイプ名',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='授業種別管理のマスターテーブル';

-- Create syntax for TABLE 'class_format'
CREATE TABLE `class_format` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(200) NOT NULL COMMENT '構成名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='授業構成パーツ';

-- Create syntax for TABLE 'class_highlight'
CREATE TABLE `class_highlight` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `body` varchar(255) NOT NULL DEFAULT '' COMMENT '本文',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1: 削除',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='授業の押さえどころ情報';

-- Create syntax for TABLE 'class_introduction_comment'
CREATE TABLE `class_introduction_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `body` text NOT NULL COMMENT '本文',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `commenter_type` int(11) NOT NULL COMMENT 'コメンタータイプ(class_introduction_commenter_typesのid)',
  `commenter_id` int(11) NOT NULL COMMENT 'コメンターID(class_director, teacherのid)',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1: 削除',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='関係者による授業紹介コメント';

-- Create syntax for TABLE 'class_introduction_commenter_types'
CREATE TABLE `class_introduction_commenter_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'コメンタータイプ名',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='授業紹介コメントのコメンタータイプ';

-- Create syntax for TABLE 'class_live_history'
CREATE TABLE `class_live_history` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `class_id` int(32) unsigned NOT NULL COMMENT 'クラスID',
  `status` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '0:放送前,1:放送待機中,9:放送終了,100:放送中(通常),101:放送中(プレミアム限定),109:放送中(管理者限定)',
  `applied_at` datetime NOT NULL COMMENT '適用日時',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  KEY `class_id_applied_at` (`class_id`,`applied_at`)
) ENGINE=InnoDB AUTO_INCREMENT=449 DEFAULT CHARSET=utf8 COMMENT='生放送ステータス履歴';

-- Create syntax for TABLE 'class_play_history_training_user'
CREATE TABLE `class_play_history_training_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `corporation_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理会社ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ライトユーザーID',
  `class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'クラスID',
  `play_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '再生時間',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `corporaition_id_user_id_class_id_play_time` (`corporation_id`,`user_id`,`class_id`,`play_time`,`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='trainingユーザ教室入室毎の再生時間(本体に依存しない)';

-- Create syntax for TABLE 'class_play_history_user'
CREATE TABLE `class_play_history_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_id` int(11) NOT NULL DEFAULT '0',
  `play_time` int(11) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id_class_id_play_time` (`user_id`,`class_id`,`play_time`,`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'class_question'
CREATE TABLE `class_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `question_text` text NOT NULL COMMENT '問題テキスト',
  `answers_json` text NOT NULL COMMENT '解答リストのjsonデータ',
  `correct_index` varchar(16) NOT NULL DEFAULT '0' COMMENT '正答の解答リストインデックス(複数の場合はカンマ区切り)',
  `commentary_html` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '5.5系はCURRENT_TIMESTAMPが複数カラムで使えない',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `class_id` (`class_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1238 DEFAULT CHARSET=utf8 COMMENT='クラスの問題テーブル';

-- Create syntax for TABLE 'class_question_answer'
CREATE TABLE `class_question_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL,
  `class_id` int(11) NOT NULL,
  `correct_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT '正答数',
  `answer_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT '解答数',
  `answer_json` varchar(1024) NOT NULL DEFAULT '0' COMMENT '解答情報のjsonデータ',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '5.5系はCURRENT_TIMESTAMPが複数カラムで使えない',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`class_id`),
  KEY `user_id_and_class_id_and_created_at` (`user_id`,`class_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=10798 DEFAULT CHARSET=utf8 COMMENT='クラスの解答テーブル';

-- Create syntax for TABLE 'class_question_curriculum_answer'
CREATE TABLE `class_question_curriculum_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `curriculum_id` int(10) unsigned NOT NULL,
  `correct_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT '正答数',
  `answer_count` tinyint(4) NOT NULL DEFAULT '0' COMMENT '解答数',
  `answer_json` text NOT NULL COMMENT '解答情報のjsonデータ',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`curriculum_id`,`regist_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='カリキュラム(ルート)の解答テーブル';

-- Create syntax for TABLE 'class_ratings'
CREATE TABLE `class_ratings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'クラスID',
  `type` int(10) unsigned NOT NULL COMMENT 'フィードバックのタイプ 1:満足度',
  `score` int(10) unsigned NOT NULL COMMENT 'フィードバックのスコア',
  `text` varchar(1024) DEFAULT NULL COMMENT 'フィードバックのテキスト',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`class_id`,`type`),
  KEY `user_id_2` (`user_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43668 DEFAULT CHARSET=utf8 COMMENT='授業レーティング';

-- Create syntax for TABLE 'class_recommend'
CREATE TABLE `class_recommend` (
  `class_recommend_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(10) unsigned NOT NULL DEFAULT '0',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '重要度',
  `category_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`class_recommend_id`),
  UNIQUE KEY `category_id_priority` (`category_id`,`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=547 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'class_sample_file'
CREATE TABLE `class_sample_file` (
  `class_sample_file_id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'インデックス',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '資料URL',
  `text` text COMMENT 'フリーテキスト',
  `order_num` tinyint(1) NOT NULL DEFAULT '0' COMMENT '表示順',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'ステータス 0:非表示, 1:表示',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`class_sample_file_id`),
  UNIQUE KEY `class_id_order_num` (`class_id`,`order_num`)
) ENGINE=InnoDB AUTO_INCREMENT=884 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'class_timeline_archive'
CREATE TABLE `class_timeline_archive` (
  `class_id` int(32) NOT NULL,
  `social_stream_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'ストリーム総数',
  `question_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '質問数',
  `understand_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'なるほど数',
  `learned_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '学んだ数',
  `visitor_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '来場者数',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未出力, 1:出力済み',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`class_id`),
  KEY `social_stream_cnt` (`social_stream_cnt`),
  KEY `understand_cnt` (`understand_cnt`),
  KEY `visitor_cnt` (`visitor_cnt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教室タイムラインアーカイブ情報';

-- Create syntax for TABLE 'class_video_encryption'
CREATE TABLE `class_video_encryption` (
  `class_id` int(32) NOT NULL COMMENT 'クラスID',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未生成, 1:生成済み',
  `zip_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未生成, 1:生成済み',
  `size` bigint(32) unsigned NOT NULL DEFAULT '0' COMMENT 'データファイルのサイズ',
  `hash` varchar(255) NOT NULL DEFAULT '' COMMENT 'データファイルのハッシュ値',
  `zip_size` bigint(32) unsigned NOT NULL DEFAULT '0' COMMENT 'zipファイルのサイズ',
  `zip_hash` varchar(255) NOT NULL DEFAULT '' COMMENT 'zipファイルのハッシュ値',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`class_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='授業動画ファイル暗号化情報';

-- Create syntax for TABLE 'classroom'
CREATE TABLE `classroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '教室（会場）ID',
  `name` varchar(255) NOT NULL COMMENT '教室名',
  `url` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL COMMENT '住所',
  `description` varchar(255) NOT NULL COMMENT '詳細',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='教室（会場）';

-- Create syntax for TABLE 'client'
CREATE TABLE `client` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `login_id` varchar(255) NOT NULL DEFAULT '',
  `password` varbinary(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `provider_id` int(32) unsigned NOT NULL,
  `authority` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '権限(admin権限/編集可能/閲覧のみ可能等)',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_id` (`login_id`),
  KEY `provider_id` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'cluster_job_category_recommend_tag'
CREATE TABLE `cluster_job_category_recommend_tag` (
  `cluster_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'クラスター',
  `current_job_type` int(32) unsigned NOT NULL COMMENT '現職種',
  `desired_job_type` int(32) unsigned NOT NULL COMMENT '希望職種',
  `recommend_tag_json` text NOT NULL COMMENT 'オススメのタグ',
  `algorithm_type` tinyint(3) unsigned NOT NULL COMMENT 'アルゴリズムのタイプ',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`cluster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1047 DEFAULT CHARSET=utf8 COMMENT='現職種x希望職種のtagレコメンドデータ';

-- Create syntax for TABLE 'continuous'
CREATE TABLE `continuous` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `planner_text` text NOT NULL,
  `summary` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'contract_arrears'
CREATE TABLE `contract_arrears` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) unsigned NOT NULL COMMENT '契約会社ID',
  `unpaid_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '未払い月',
  `unpaid_amount` bigint(20) NOT NULL DEFAULT '0' COMMENT '未払い額',
  `is_paid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0:無効,1:有効',
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '0:無効,1:有効',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_ca_corporation_id` (`corporation_id`),
  KEY `index_ca_corporation_id_unpaid_date` (`corporation_id`,`unpaid_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='未払い情報';

-- Create syntax for TABLE 'contract_contracts'
CREATE TABLE `contract_contracts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) unsigned NOT NULL COMMENT '契約会社ID',
  `sales_staff_id` int(11) unsigned NOT NULL COMMENT '営業担当者ID',
  `operation_cost` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '初期費用',
  `order_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '受注日',
  `start_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '利用開始日',
  `contract_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '請求適用開始年月',
  `contract_cancel_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '解約適用開始年月',
  `contract_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0:ビジネス,1:ライトA,2:プラス',
  `contract_period` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '契約期間(月)',
  `contract_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '契約数',
  `billing_units` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '請求単位(1-12ヶ月)',
  `discount_rate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '値引き率(0-100)',
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '0:無効,1:有効',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_cc_corporation_id` (`corporation_id`),
  KEY `index_cc_sales_staff_id` (`sales_staff_id`),
  KEY `index_cc_corporation_id_contract_date` (`corporation_id`,`contract_date`),
  KEY `index_cc_corporation_id_sales_staff_id_contract_date` (`corporation_id`,`sales_staff_id`,`contract_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='契約情報';

-- Create syntax for TABLE 'contract_corporations'
CREATE TABLE `contract_corporations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '会社名',
  `postcode` varchar(12) NOT NULL DEFAULT '' COMMENT '郵便番号',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '住所1',
  `address2` varchar(255) NOT NULL DEFAULT '' COMMENT '住所2',
  `bank_accounts` text NOT NULL,
  `billing_method` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '請求方法',
  `memo` text NOT NULL,
  `client_name` varchar(255) NOT NULL DEFAULT '' COMMENT '担当者名',
  `client_email` varchar(255) NOT NULL DEFAULT '' COMMENT '担当者email',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_contract_corporation_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1485 DEFAULT CHARSET=utf8 COMMENT='契約会社情報';

-- Create syntax for TABLE 'contract_payments'
CREATE TABLE `contract_payments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) unsigned NOT NULL COMMENT '契約会社ID',
  `payment_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '支払日',
  `payment_amount` bigint(20) NOT NULL DEFAULT '0' COMMENT '支払額',
  `unpaid_amount` bigint(20) NOT NULL DEFAULT '0' COMMENT '未払額',
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '0:無効,1:有効',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_cp_corporation_id` (`corporation_id`),
  KEY `index_cp_corporation_id_payment_date` (`corporation_id`,`payment_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支払い情報';

-- Create syntax for TABLE 'contract_sales_staffs'
CREATE TABLE `contract_sales_staffs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `memo` text NOT NULL,
  `is_active` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '0:無効,1:有効',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_contract_sales_staff_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='法人スタッフ情報';

-- Create syntax for TABLE 'corporation_admin_mails'
CREATE TABLE `corporation_admin_mails` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sending_type` tinyint(4) NOT NULL DEFAULT '0',
  `mail_type` tinyint(4) NOT NULL DEFAULT '0',
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `mail_send_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_allowed_categories'
CREATE TABLE `corporation_allowed_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `corporation_to_category` (`corporation_id`,`category_id`),
  KEY `index_corporation_id` (`corporation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_attachments'
CREATE TABLE `corporation_attachments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL DEFAULT '0',
  `staff_id` int(11) DEFAULT '0',
  `file_type` int(11) NOT NULL DEFAULT '1',
  `path` varchar(255) NOT NULL DEFAULT '',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `page_count` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `published_status` int(11) NOT NULL DEFAULT '0',
  `message` text,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `deleted_flag` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_bouncd_mail_messages'
CREATE TABLE `corporation_bouncd_mail_messages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `error_message_key` varchar(255) DEFAULT NULL,
  `message` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_business_categories'
CREATE TABLE `corporation_business_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_businesses'
CREATE TABLE `corporation_businesses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_casual_staffs'
CREATE TABLE `corporation_casual_staffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT '',
  `email` varchar(255) NOT NULL,
  `encrypted_password` varchar(255) NOT NULL,
  `memo` varchar(255) DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '1',
  `expiration_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_casual_staff_email` (`email`),
  KEY `index_casual_staff_corporation_id` (`corporation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_casual_staffs_tags'
CREATE TABLE `corporation_casual_staffs_tags` (
  `corporation_casual_staff_id` int(11) NOT NULL,
  `corporation_casual_tag_id` int(11) NOT NULL,
  UNIQUE KEY `corporation_casual_staff_tag` (`corporation_casual_staff_id`,`corporation_casual_tag_id`),
  KEY `corporation_casual_staff_id` (`corporation_casual_staff_id`),
  KEY `corporation_casual_tag_id` (`corporation_casual_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_casual_tags'
CREATE TABLE `corporation_casual_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL,
  `label` varchar(64) NOT NULL,
  `color` varchar(6) NOT NULL DEFAULT 'e11d21',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `corporation_id_label` (`corporation_id`,`label`),
  KEY `corporation_id` (`corporation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_contract_allow_ips'
CREATE TABLE `corporation_contract_allow_ips` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_contract_id` int(11) NOT NULL DEFAULT '0',
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `ip_1` smallint(6) NOT NULL DEFAULT '0',
  `ip_2` smallint(6) NOT NULL DEFAULT '0',
  `ip_3` smallint(6) NOT NULL DEFAULT '0',
  `ip_4` smallint(6) NOT NULL DEFAULT '0',
  `subnet_mask` smallint(6) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_corporation_contract_allow_ips_on_corporation_contract_id` (`corporation_contract_id`),
  KEY `index_corporation_contract_allow_ips_on_ip` (`ip_1`,`ip_2`,`ip_3`,`ip_4`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_contracts'
CREATE TABLE `corporation_contracts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL DEFAULT '0',
  `contract_type` tinyint(4) NOT NULL DEFAULT '0',
  `people_count` int(11) NOT NULL DEFAULT '0',
  `contract_start_dt` datetime DEFAULT NULL,
  `re_activation_month` tinyint(2) unsigned DEFAULT NULL COMMENT '派遣スタッフの２０時間の制限をクリアする月',
  `start_dt` datetime NOT NULL,
  `end_dt` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_corporation_contracts_on_corporation_id` (`corporation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_course_categories'
CREATE TABLE `corporation_course_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_course_targets'
CREATE TABLE `corporation_course_targets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_curriculum_classes'
CREATE TABLE `corporation_curriculum_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(11) NOT NULL DEFAULT '0',
  `course_id` int(11) DEFAULT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `order_number` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=823 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_curriculum_reports'
CREATE TABLE `corporation_curriculum_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(11) NOT NULL,
  `staff_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_at` datetime DEFAULT NULL,
  `flg_read` tinyint(4) NOT NULL DEFAULT '0',
  `reply_staff_id` int(11) DEFAULT NULL,
  `reply_body` text COLLATE utf8mb4_unicode_ci,
  `reply_status` tinyint(4) NOT NULL DEFAULT '0',
  `reply_updated_at` datetime DEFAULT NULL,
  `flg_reply_read` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_curriculum_staffs'
CREATE TABLE `corporation_curriculum_staffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(11) DEFAULT NULL,
  `corporation_staff_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_curriculum_template_classes'
CREATE TABLE `corporation_curriculum_template_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(11) NOT NULL DEFAULT '0',
  `course_id` int(11) NOT NULL DEFAULT '0',
  `order_number` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_corporation_curriculum_template_classes_01` (`curriculum_id`,`course_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_curriculum_template_to_job_kind_maps'
CREATE TABLE `corporation_curriculum_template_to_job_kind_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL,
  `job_kind_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_curriculum_template_to_job_title_maps'
CREATE TABLE `corporation_curriculum_template_to_job_title_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL,
  `job_title_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_curriculum_template_to_theme_maps'
CREATE TABLE `corporation_curriculum_template_to_theme_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL,
  `theme_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_curriculum_templates'
CREATE TABLE `corporation_curriculum_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `show_lp` tinyint(4) NOT NULL DEFAULT '0',
  `description_lp` text,
  `postscript_lp` text,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_curriculums'
CREATE TABLE `corporation_curriculums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL DEFAULT '0',
  `corporation_staff_id` int(11) NOT NULL DEFAULT '0',
  `curriculum_name` varchar(255) NOT NULL DEFAULT '',
  `curriculum_start_at` datetime DEFAULT NULL,
  `curriculum_end_at` datetime DEFAULT NULL,
  `curriculum_description` text,
  `report_type` tinyint(4) NOT NULL DEFAULT '0',
  `report_title` text,
  `report_body` text,
  `flg_draft` tinyint(1) NOT NULL DEFAULT '0',
  `boolean` tinyint(1) NOT NULL DEFAULT '0',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_faq_categories'
CREATE TABLE `corporation_faq_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `order_number` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_corporation_faq_categories_on_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_faqs'
CREATE TABLE `corporation_faqs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT '1',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `feature` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_corporation_faqs_on_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_groups'
CREATE TABLE `corporation_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ancestry` varchar(255) DEFAULT NULL,
  `corporation_id` int(11) NOT NULL DEFAULT '0',
  `order_number` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `code` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_corporation_groups_on_ancestry` (`ancestry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_groups_to_admins'
CREATE TABLE `corporation_groups_to_admins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `staff_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_groups_to_staffs'
CREATE TABLE `corporation_groups_to_staffs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `staff_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_guarantee_courses'
CREATE TABLE `corporation_guarantee_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `guarantee_year` float DEFAULT NULL,
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_corporation_guarantee_courses_01` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_job_kind_groups'
CREATE TABLE `corporation_job_kind_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `order_number` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_job_kinds'
CREATE TABLE `corporation_job_kinds` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `job_kind_group_id` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `order_number` int(11) NOT NULL DEFAULT '1',
  `path` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description_lp` text,
  `postscript_lp` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_job_titles'
CREATE TABLE `corporation_job_titles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `order_number` int(11) NOT NULL DEFAULT '1',
  `path` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `description_lp` text,
  `postscript_lp` text,
  `only_lp` int(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_lms'
CREATE TABLE `corporation_lms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL,
  `plan` int(11) DEFAULT '0',
  `storage` int(11) DEFAULT '3',
  `secret_key` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_mail_transfer_histories'
CREATE TABLE `corporation_mail_transfer_histories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `mail_type` tinyint(4) NOT NULL DEFAULT '0',
  `email` text NOT NULL,
  `send_status` tinyint(4) NOT NULL DEFAULT '1',
  `message` text,
  `smpt_status_code` varchar(255) DEFAULT '',
  `diagnostic_code` varchar(255) DEFAULT '',
  `error_message_key` varchar(255) DEFAULT '',
  `mail_send_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4739 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_movie_attend_statuses'
CREATE TABLE `corporation_movie_attend_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `position` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_movie_comments'
CREATE TABLE `corporation_movie_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_movie_list_maps'
CREATE TABLE `corporation_movie_list_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `movie_list_id` int(11) DEFAULT NULL,
  `order_number` int(11) DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_movie_lists'
CREATE TABLE `corporation_movie_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_movie_play_histories'
CREATE TABLE `corporation_movie_play_histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `play_time` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_movies'
CREATE TABLE `corporation_movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '名称未設定',
  `video_path` text COLLATE utf8mb4_unicode_ci,
  `video` text COLLATE utf8mb4_unicode_ci,
  `image_key` text COLLATE utf8mb4_unicode_ci,
  `image_path` text COLLATE utf8mb4_unicode_ci,
  `size` int(11) DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `movie_time` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  `published_status` tinyint(4) NOT NULL DEFAULT '0',
  `deleted_flag` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_notifications'
CREATE TABLE `corporation_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `published_at` datetime NOT NULL,
  `is_featured` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_corporation_notifications_on_published_at` (`published_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_play_history_statistics'
CREATE TABLE `corporation_play_history_statistics` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `corporation_id` int(11) NOT NULL DEFAULT '0',
  `staff_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL DEFAULT '0',
  `play_time` int(11) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `attend_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '受講状況ステータス 0:受講中, 1:受講完了',
  `env` int(2) DEFAULT NULL COMMENT '端末種別',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_class_id_regist_date_u` (`user_id`,`class_id`,`regist_date`),
  KEY `index_corporation_id` (`corporation_id`),
  KEY `index_user_id` (`user_id`),
  KEY `index_staff_id` (`staff_id`),
  KEY `index_user_id_class_id` (`user_id`,`class_id`),
  KEY `index_staff_id_class_id` (`staff_id`,`class_id`),
  KEY `index_user_id_class_id_regist_date` (`user_id`,`class_id`,`regist_date`),
  KEY `index_staff_id_class_id_regist_date` (`staff_id`,`class_id`,`regist_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_staff_statements'
CREATE TABLE `corporation_staff_statements` (
  `staff_id` int(11) NOT NULL DEFAULT '0',
  `approval_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `index_corporation_staff_statements_on_staff_id` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_staff_to_user_maps'
CREATE TABLE `corporation_staff_to_user_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_staff_id` int(11) NOT NULL DEFAULT '0',
  `user_id` varchar(255) NOT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `flg_private_mail` tinyint(1) DEFAULT '1' COMMENT '0: 会社のメールアドレスしか登録されていない, 1: プライベートメールアドレスが登録されている',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corporation_staff_to_user_maps_on_user_id` (`user_id`),
  UNIQUE KEY `index_corporation_staff_to_user_maps_on_confirmation_token` (`confirmation_token`),
  KEY `index_corporation_staff_to_user_maps_on_corporation_staff_id` (`corporation_staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29071 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_staffs'
CREATE TABLE `corporation_staffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `authority` tinyint(4) NOT NULL DEFAULT '0',
  `corporation_id` int(11) NOT NULL DEFAULT '0',
  `job_kind_id` int(11) DEFAULT '0' COMMENT '職種',
  `job_title_id` int(11) DEFAULT '0' COMMENT '職位',
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `confirmation_admin_sent_at` datetime DEFAULT NULL,
  `failed_attempts` int(11) NOT NULL DEFAULT '0',
  `unlock_token` varchar(255) DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `premium_type` tinyint(4) NOT NULL DEFAULT '1',
  `expire_date` datetime DEFAULT NULL,
  `reservation_date` datetime DEFAULT NULL,
  `memo` varchar(255) DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `sex` tinyint(4) NOT NULL DEFAULT '9',
  `birthday` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corporation_staffs_on_email` (`email`),
  UNIQUE KEY `index_corporation_staffs_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_corporation_staffs_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_corporation_staffs_on_unlock_token` (`unlock_token`),
  KEY `index_corporation_staffs_on_corporation_id` (`corporation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63786 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_staffs_tags'
CREATE TABLE `corporation_staffs_tags` (
  `corporation_staff_id` int(11) NOT NULL,
  `corporation_tag_id` int(11) NOT NULL,
  UNIQUE KEY `corporation_staff_tag` (`corporation_staff_id`,`corporation_tag_id`),
  KEY `corporation_staff_id` (`corporation_staff_id`),
  KEY `corporation_tag_id` (`corporation_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_tags'
CREATE TABLE `corporation_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL,
  `label` varchar(64) NOT NULL,
  `color` varchar(6) NOT NULL DEFAULT 'e11d21',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `corporation_id_label` (`corporation_id`,`label`),
  KEY `corporation_id` (`corporation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12624 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_themes'
CREATE TABLE `corporation_themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` int(11) DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_lp` text COLLATE utf8mb4_unicode_ci,
  `postscript_lp` text COLLATE utf8mb4_unicode_ci,
  `only_lp` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'corporation_tmp_cautions'
CREATE TABLE `corporation_tmp_cautions` (
  `staff_id` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_user_group_maps'
CREATE TABLE `corporation_user_group_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_staff_id` int(11) NOT NULL DEFAULT '0',
  `corporation_user_group_id` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corporation_user_group_maps_on_corporation_id_and_group_id` (`corporation_staff_id`,`corporation_user_group_id`),
  KEY `index_corporation_user_group_maps_on_corporation_user_group_id` (`corporation_user_group_id`),
  KEY `index_corporation_user_group_maps_on_corporation_staff_id` (`corporation_staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_user_groups'
CREATE TABLE `corporation_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `corporation_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corporation_user_groups_on_corporation_id_and_name` (`corporation_id`,`name`),
  KEY `index_corporation_user_groups_on_corporation_id` (`corporation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporation_user_notifications'
CREATE TABLE `corporation_user_notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `corporation_staff_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `text` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'corporations'
CREATE TABLE `corporations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `business_category_id` int(11) DEFAULT NULL COMMENT '業種',
  `comeback_mail_flag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '休眠復帰メールを送る == 1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `api_token` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `distributor` smallint(6) NOT NULL DEFAULT '0',
  `flg_except` tinyint(4) NOT NULL DEFAULT '0',
  `csv_download_flg` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_corporations_on_name` (`name`),
  UNIQUE KEY `index_corporations_on_email` (`email`),
  UNIQUE KEY `index_corporations_on_confirmation_token` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=830 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'coupon_plans'
CREATE TABLE `coupon_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_service_id` int(11) NOT NULL,
  `valid_term` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_coupon_plans_on_name_en` (`name_en`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'coupon_services'
CREATE TABLE `coupon_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_coupon_services_on_name_en` (`name_en`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'coupons'
CREATE TABLE `coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_plan_id` int(11) NOT NULL,
  `serial_number` varchar(255) NOT NULL,
  `expire_date` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `usage_count` int(4) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_index` (`coupon_plan_id`,`serial_number`)
) ENGINE=InnoDB AUTO_INCREMENT=12937 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'course'
CREATE TABLE `course` (
  `course_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT '科目ID',
  `faculty_id` int(32) unsigned NOT NULL COMMENT '学部ID',
  `type` enum('basic','advance','special') NOT NULL COMMENT '科目種別 basic:基礎 / advance:応用  / special:専門 ※enum型は列挙順にソートするので、授業で受けるべき順にtypeを定義する',
  `name` varchar(255) NOT NULL COMMENT '名前',
  `description` text COMMENT '概要',
  `target_id` int(32) unsigned NOT NULL DEFAULT '1' COMMENT 'ターゲットID',
  `target` varchar(255) DEFAULT NULL COMMENT 'ターゲット',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '0:非公開 1:テスト公開 2:本番公開 9:休講',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5001 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'course_rating_score'
CREATE TABLE `course_rating_score` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `course_id` int(11) NOT NULL COMMENT 'コースID',
  `score` float NOT NULL COMMENT '集計後の点数。class_type&user_typeごとに集計します',
  `class_type` tinyint(1) NOT NULL COMMENT '0: 全て / 1: 生放送 / 2: 録画',
  `user_type` tinyint(1) NOT NULL COMMENT '0: 全て / 1: toC会員 / 2: 法人会員',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`,`class_type`,`user_type`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=utf8 COMMENT='授業評価の整形情報';

-- Create syntax for TABLE 'course_tag'
CREATE TABLE `course_tag` (
  `course_tag_id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index, コースタグID',
  `name` varchar(100) NOT NULL COMMENT 'コースタグ名',
  `description` text COMMENT '説明',
  `path` varchar(100) DEFAULT NULL COMMENT 'URLパス',
  `parent_id` int(32) NOT NULL DEFAULT '0' COMMENT '親コースタグID',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '種類',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_tag_id`),
  UNIQUE KEY `path` (`path`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8 COMMENT='コースタグ';

-- Create syntax for TABLE 'curriculum'
CREATE TABLE `curriculum` (
  `curriculum_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'カリキュラムID',
  `name` varchar(255) NOT NULL COMMENT '名前',
  `description` text COMMENT '概要',
  `summary` text COMMENT 'ルートのサマリー',
  `completion_term` int(10) unsigned DEFAULT NULL COMMENT '理想的な履修期間(日数)',
  `question_count` int(10) unsigned DEFAULT NULL COMMENT '最終テストの出題数',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_route_curriculum` int(1) NOT NULL DEFAULT '1' COMMENT 'ルート用カリキュラムかどうか 0:旧カリキュラム, 1:新カリキュラム',
  `interview_items_json` text COMMENT 'マスタープラン用のインタービュー項目のリストJSON',
  PRIMARY KEY (`curriculum_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'daily_kpi'
CREATE TABLE `daily_kpi` (
  `daily_kpi_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1:全体、2:WD学部, 3:PG学部, 4:BE学部, 5:SU学部, 6:MK学部',
  `class_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '授業数',
  `reserved_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '授業の受けたい数',
  `live_attend_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '受講数',
  `faculty_user_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '学部所属者数',
  `premium_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '現在のプレミアム数',
  `premium_contract_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'プレミアム契約数',
  `premium_cancel_cnt` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'プレミアム解約数',
  `target_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '対象日',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`daily_kpi_id`),
  KEY `type_regist_date` (`type`,`target_date`)
) ENGINE=InnoDB AUTO_INCREMENT=4423 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'delayed_jobs'
CREATE TABLE `delayed_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL DEFAULT '0',
  `attempts` int(11) NOT NULL DEFAULT '0',
  `handler` text NOT NULL,
  `last_error` text,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `locked_by` varchar(255) DEFAULT NULL,
  `queue` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delayed_jobs_priority` (`priority`,`run_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'device'
CREATE TABLE `device` (
  `instance_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) NOT NULL,
  `fcm_registration_token` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`instance_id`),
  UNIQUE KEY `index_device_on_user_id_and_fcm_registration_token` (`user_id`,`fcm_registration_token`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'director'
CREATE TABLE `director` (
  `director_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名前',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`director_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'display_list'
CREATE TABLE `display_list` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `display_group_id` int(32) unsigned NOT NULL COMMENT 'グループID',
  `sort_order` int(32) unsigned NOT NULL COMMENT 'ソート順序',
  `display_type_id` int(32) unsigned NOT NULL COMMENT 'タイプID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'リスト名',
  `summary` text NOT NULL COMMENT '概要',
  `limit_count` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '表示件数上限(0は制限なし)',
  `optional_json_text` text NOT NULL COMMENT 'タイプ別拡張jsonデータ',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_group_id_sort_order` (`display_group_id`,`sort_order`),
  KEY `display_type_id` (`display_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8 COMMENT='表示リストデータ';

-- Create syntax for TABLE 'display_list_group'
CREATE TABLE `display_list_group` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'グループID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'グループ名',
  `summary` text NOT NULL COMMENT '概要',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'デフォルトで利用されるグループ判定',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='表示リストグループ';

-- Create syntax for TABLE 'display_list_type'
CREATE TABLE `display_list_type` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `display_list_type_id` int(32) unsigned NOT NULL COMMENT 'タイプID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'タイプ名',
  `summary` text NOT NULL COMMENT '概要(表示仕様)',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_list_type_id` (`display_list_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='表示リストタイプマスター';

-- Create syntax for TABLE 'e_on_stream'
CREATE TABLE `e_on_stream` (
  `id` varchar(35) NOT NULL,
  `s_id` int(32) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `regist_date` datetime NOT NULL,
  `elapsed_ms` int(32) NOT NULL COMMENT '授業開始時刻からの経過ミリ秒',
  `user_id` varchar(255) NOT NULL,
  `class_id` int(32) NOT NULL COMMENT 'class_id',
  PRIMARY KEY (`id`),
  KEY `stream` (`s_id`,`elapsed_ms`),
  KEY `like_user` (`class_id`,`user_id`,`type`,`s_id`),
  KEY `class_id_and_elapsed_ms` (`class_id`,`elapsed_ms`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'event_reservations'
CREATE TABLE `event_reservations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL COMMENT 'related `events.id`',
  `user_id` varchar(255) NOT NULL COMMENT 'related `user.user_id`',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_event_reservations_01` (`event_id`,`user_id`),
  KEY `idx_event_reservations_01` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='イベント参加予約情報を記録する';

-- Create syntax for TABLE 'events'
CREATE TABLE `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(32) NOT NULL COMMENT '識別子として用いる文字列',
  `title` varchar(255) NOT NULL COMMENT 'イベント名',
  `start_datetime` datetime NOT NULL COMMENT 'イベントの開催開始時刻',
  `end_datetime` datetime NOT NULL COMMENT 'イベントの開催終了時刻',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_events_01` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='イベント管理用マスター';

-- Create syntax for TABLE 'exam_reviews'
CREATE TABLE `exam_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam_submission_id` int(10) unsigned NOT NULL COMMENT 'レビュー対象の提出課題id',
  `reviewer_id` int(10) unsigned NOT NULL COMMENT 'レビュワーのid',
  `title` varchar(255) NOT NULL COMMENT 'レビューのタイトル',
  `text` text NOT NULL COMMENT 'レビュー内容',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`id`),
  KEY `exam_submission_id` (`exam_submission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=844 DEFAULT CHARSET=utf8 COMMENT='提出課題へのレビュー';

-- Create syntax for TABLE 'exam_submissions'
CREATE TABLE `exam_submissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL,
  `exam_id` int(11) NOT NULL COMMENT '提出対象の課題ID',
  `description` varchar(2048) NOT NULL COMMENT '課題説明/コメント',
  `assets_key` varchar(32) NOT NULL COMMENT 'アセットのパスキー',
  `assets_json` text NOT NULL COMMENT 'アセット情報のJsonText',
  `is_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT '提出課題の有効1/無効0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`id`),
  KEY `assets_key` (`assets_key`),
  KEY `user_id` (`user_id`,`is_active`,`update_date`),
  KEY `exam_id` (`exam_id`,`is_active`,`update_date`),
  KEY `user_id_2` (`user_id`,`exam_id`,`is_active`,`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提出課題情報';

-- Create syntax for TABLE 'exams'
CREATE TABLE `exams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(10) unsigned NOT NULL COMMENT '課題が所属するカリキュラムID',
  `course_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '課題が紐付くルート内のコースセクションID、0の場合は最終課題',
  `title` text NOT NULL COMMENT '課題のタイトル',
  `description` text NOT NULL COMMENT '課題内容のテキスト',
  `handouts` text COMMENT '課題で使用する配布素材',
  `criteria` text NOT NULL COMMENT '課題の評価ポイントのテキスト',
  `required_submissions` text NOT NULL COMMENT '改題の必須提出物の説明テキスト',
  `optional_submissions` text COMMENT 'オプションの提出項目',
  `faq` text COMMENT 'よくある質問のテキスト',
  `completion_term` int(10) unsigned NOT NULL COMMENT '理想的な履修期間(日数)',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`id`),
  KEY `curriculum_id` (`curriculum_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='ルートの課題情報';

-- Create syntax for TABLE 'faculty'
CREATE TABLE `faculty` (
  `faculty_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT '学部ID',
  `path` varchar(255) NOT NULL COMMENT '学部ページのURLに使用される文字列',
  `name` varchar(255) NOT NULL COMMENT '名前',
  `subtitle` varchar(1000) DEFAULT NULL COMMENT '学部を説明するサブタイトル',
  `description` text COMMENT '概要',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`faculty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'favorite_class'
CREATE TABLE `favorite_class` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `class_id` int(32) unsigned NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`class_id`),
  KEY `user_id_update_date` (`user_id`,`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=297811 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'feature_ad_info'
CREATE TABLE `feature_ad_info` (
  `ad_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '広告id',
  `title` varchar(255) NOT NULL COMMENT '表示タイトル',
  `image_url_pc` varchar(255) NOT NULL COMMENT 'PC用画像URL',
  `image_url_sp` varchar(255) NOT NULL COMMENT 'SP用画像URL',
  `ad_type` tinyint(3) unsigned NOT NULL COMMENT '広告のタイプ 0:リンク系(お知らせ／キャンペーン／その他),1:LIVE授業, 2:再放送, 3:録画授業, 4:録画授業(無料)',
  `class_start_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `class_end_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `link_url` varchar(255) NOT NULL COMMENT 'リンクURL',
  `ga_event` varchar(255) NOT NULL COMMENT 'google analytics event id',
  `priority` int(10) unsigned NOT NULL COMMENT '表示の優先順位',
  `ad_hide_usertype` tinyint(3) unsigned NOT NULL COMMENT '広告を表示しないユーザーのタイプ 0: なし (全員),1: プレミアム会員,2: マスタープラン会員,3: プレミアム + マスタープラン',
  `display_page_type` tinyint(3) unsigned NOT NULL COMMENT '広告を表示する面のタイプ 0: 両方,1: ゲストページのみ,2: 会員ページのみ',
  `ad_open_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `ad_close_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`ad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='サービストップのカルーセル枠の内容';

-- Create syntax for TABLE 'featured_course_lists'
CREATE TABLE `featured_course_lists` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'リストの名前',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='任意のコースをリスト化したデータ';

-- Create syntax for TABLE 'free_class_for_careeful'
CREATE TABLE `free_class_for_careeful` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `start_date` datetime NOT NULL COMMENT '公開開始時刻',
  `end_date` datetime NOT NULL COMMENT '公開終了時刻',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_free_class_for_careeful_on_class_id` (`class_id`,`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='キャリフル用無料授業対象一覧';

-- Create syntax for TABLE 'goods'
CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '購入履歴ID',
  `price` int(11) NOT NULL COMMENT '税抜き価格',
  `name` varchar(45) NOT NULL,
  `regist_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `flg_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'group_feed'
CREATE TABLE `group_feed` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `parent_id` int(32) DEFAULT NULL COMMENT '親コメントID',
  `group_id` int(32) NOT NULL COMMENT 'グループID',
  `user_id` varchar(255) DEFAULT NULL COMMENT '学籍番号',
  `type` enum('post','join','watch','attend') NOT NULL COMMENT 'post:投稿, join:参加, watch:受けたい, attend:着席',
  `class_id` int(32) DEFAULT NULL COMMENT '授業ID',
  `text` text COMMENT '本文',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  `image_1` varchar(255) DEFAULT NULL COMMENT '画像1',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`id`),
  KEY `group_id_type` (`group_id`,`type`,`update_date`),
  KEY `parent_id` (`parent_id`,`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=11679 DEFAULT CHARSET=utf8 COMMENT='グループ投稿';

-- Create syntax for TABLE 'group_feed_like'
CREATE TABLE `group_feed_like` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `group_feed_id` int(32) NOT NULL COMMENT 'グループ投稿ID',
  `user_id` varchar(8) NOT NULL COMMENT '学籍番号',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`id`),
  KEY `group_feed_id` (`group_feed_id`,`update_date`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13860 DEFAULT CHARSET=utf8 COMMENT='グループ投稿いいね';

-- Create syntax for TABLE 'group_tag'
CREATE TABLE `group_tag` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `name` varchar(100) NOT NULL COMMENT 'タグ名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8 COMMENT='グループ用のタグ';

-- Create syntax for TABLE 'groups'
CREATE TABLE `groups` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `name` varchar(255) NOT NULL COMMENT 'グループ名',
  `open_status` enum('member','all') NOT NULL DEFAULT 'all' COMMENT 'member: 招待者限定公開, all:完全公開',
  `post_status` enum('admin','member','all') NOT NULL DEFAULT 'member' COMMENT '投稿権限 admin:管理者のみ, member:管理者とメンバーのみ, all:全てユーザー',
  `comment_status` enum('admin','member','all') NOT NULL DEFAULT 'member' COMMENT 'コメント権限 admin:管理者のみ, member:管理者とメンバーのみ, all:全てユーザー',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '1:通常グループ, 2:カリキュラム用グループ',
  `skin` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'スキン',
  `pic_url` varchar(255) DEFAULT NULL COMMENT '画像のURL',
  `description` text COMMENT 'グループ説明',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`id`),
  KEY `open_status` (`open_status`,`flg_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 COMMENT='グループ';

-- Create syntax for TABLE 'growth_push_tag'
CREATE TABLE `growth_push_tag` (
  `growth_push_tag_id` int(32) unsigned NOT NULL COMMENT 'タグID',
  `tag_name` varchar(255) NOT NULL COMMENT 'タグ名',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`growth_push_tag_id`),
  UNIQUE KEY `tag_name` (`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'hall_questions'
CREATE TABLE `hall_questions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'halls'
CREATE TABLE `halls` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `corporation_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `note` text COLLATE utf8mb4_unicode_ci,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `pattern` int(2) NOT NULL DEFAULT '0',
  `class_id` int(11) DEFAULT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `video_speed` float NOT NULL DEFAULT '1',
  `auto_start` int(1) DEFAULT '0',
  `matome` int(11) NOT NULL DEFAULT '1',
  `matome_seconds` int(11) NOT NULL DEFAULT '180',
  `character` int(11) NOT NULL DEFAULT '1',
  `character_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stream_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0:下書き, 1:実施中, 2:実施済',
  `limited` int(11) NOT NULL DEFAULT '0',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'hearingsheet_agenda'
CREATE TABLE `hearingsheet_agenda` (
  `hearingsheet_agenda_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `type` int(32) NOT NULL DEFAULT '1' COMMENT 'タイプ',
  `main_order` int(32) NOT NULL DEFAULT '1' COMMENT '展開部分の順番',
  `start_time` time DEFAULT NULL COMMENT '開始時間',
  `duration_minutes` int(32) DEFAULT '0' COMMENT '所要時間(分)',
  `start_slide_page` int(32) DEFAULT NULL COMMENT 'スライドの開始ページ',
  `end_slide_page` int(32) DEFAULT NULL COMMENT 'スライドの終了ページ',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hearingsheet_agenda_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3584 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'hearingsheet_agenda_detail'
CREATE TABLE `hearingsheet_agenda_detail` (
  `hearingsheet_agenda_detail_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `main_order` int(32) unsigned NOT NULL COMMENT '展開部分の順番',
  `content` varchar(255) NOT NULL COMMENT '投稿する内容',
  `question_format` tinyint(1) NOT NULL DEFAULT '0' COMMENT '質問形式',
  `slide_page` int(32) DEFAULT NULL COMMENT '該当スライドのページ',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hearingsheet_agenda_detail_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'hearingsheet_class'
CREATE TABLE `hearingsheet_class` (
  `hearingsheet_class_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `start_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '放送開始時刻',
  `class_minutes` int(32) NOT NULL DEFAULT '0' COMMENT '授業時間',
  `entry_minutes` int(32) NOT NULL DEFAULT '0' COMMENT '当日入り時間',
  `meeting_place` int(32) NOT NULL DEFAULT '0' COMMENT '当日待ち合わせ場所',
  `studio_entry_minutes` int(32) NOT NULL DEFAULT '0' COMMENT 'スタジオ入り時間',
  `faculty_id` int(32) NOT NULL DEFAULT '0' COMMENT '学部ID',
  `title` varchar(255) DEFAULT NULL COMMENT '授業名',
  `meeting_content` text COMMENT '授業概要',
  `purpose_1` varchar(255) DEFAULT NULL COMMENT '学べること1',
  `purpose_2` varchar(255) DEFAULT NULL COMMENT '学べること2',
  `purpose_3` varchar(255) DEFAULT NULL COMMENT '学べること3',
  `summary` text COMMENT '授業内容',
  `target_id` int(32) unsigned NOT NULL DEFAULT '1' COMMENT 'ターゲットID',
  `target` varchar(255) NOT NULL DEFAULT '' COMMENT 'ターゲット',
  `preparation_1` varchar(255) DEFAULT NULL COMMENT '予習教材テキスト1',
  `preparation_2` varchar(255) DEFAULT NULL COMMENT '予習教材テキスト2',
  `preparation_url_1` varchar(255) DEFAULT NULL COMMENT '予習教材URL1',
  `preparation_url_2` varchar(255) DEFAULT NULL COMMENT '予習教材URL2',
  `archive_status` int(32) NOT NULL DEFAULT '0' COMMENT '録画ステータス',
  `class_format` tinyint(1) NOT NULL DEFAULT '0' COMMENT '授業形式',
  `class_format_detail` text COMMENT '授業形式詳細',
  `studio_set` int(32) NOT NULL DEFAULT '0' COMMENT 'スタジオセット',
  `director_id` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'ディレクターID',
  `is_course_class` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'コース授業かの判定',
  `course_class_order` tinyint(3) unsigned DEFAULT NULL COMMENT 'コースの授業の順番',
  `course_name` varchar(255) DEFAULT NULL COMMENT 'コース名',
  `course_description` text COMMENT 'コース概要',
  `tag_json` varchar(255) DEFAULT NULL COMMENT 'JSON形式のタグ',
  `category_json` varchar(255) DEFAULT NULL COMMENT 'JSON形式のカテゴリ',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hearingsheet_class_id`),
  UNIQUE KEY `class_id` (`class_id`),
  KEY `course_name` (`course_name`),
  KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'hearingsheet_teacher'
CREATE TABLE `hearingsheet_teacher` (
  `hearingsheet_teacher_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `teacher_id` int(32) DEFAULT NULL COMMENT '先生ID',
  `role` varchar(255) DEFAULT NULL COMMENT '役割',
  `pc_usage` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'PC接続',
  `dress_change` tinyint(1) NOT NULL DEFAULT '0' COMMENT '衣装替え',
  `name` varchar(255) DEFAULT NULL COMMENT '名前',
  `profile` text COMMENT 'プロフィール',
  `job` varchar(255) DEFAULT NULL COMMENT '職業等',
  `ruby` varchar(50) DEFAULT NULL,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hearingsheet_teacher_id`),
  UNIQUE KEY `class_teacher` (`class_id`,`teacher_id`),
  KEY `class_id` (`class_id`),
  KEY `teacher_id` (`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=541 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'hearingsheet_timeline'
CREATE TABLE `hearingsheet_timeline` (
  `hearingsheet_timeline_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `main_order` int(32) unsigned NOT NULL COMMENT '展開部分の順番',
  `content` varchar(255) NOT NULL COMMENT '投稿する内容',
  `url` varchar(255) NOT NULL COMMENT '投稿するURL',
  `slide_page` int(11) DEFAULT NULL COMMENT '該当スライドのページ',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hearingsheet_timeline_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=714 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'hearingsheet_token'
CREATE TABLE `hearingsheet_token` (
  `hearingsheet_token_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) unsigned NOT NULL,
  `token` varchar(255) NOT NULL COMMENT 'トークン',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hearingsheet_token_id`),
  UNIQUE KEY `class_id` (`class_id`),
  KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=486 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'ignore_list'
CREATE TABLE `ignore_list` (
  `user_id` varchar(8) NOT NULL COMMENT 'ユーザID',
  `ignore_user_id` varchar(8) NOT NULL COMMENT '無視ユーザID',
  `regist_date` datetime NOT NULL COMMENT '登録日',
  `update_date` datetime NOT NULL COMMENT '更新日',
  `flg_delete` tinyint(1) NOT NULL COMMENT '削除フラグ',
  KEY `user` (`user_id`,`flg_delete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'ignored_class'
CREATE TABLE `ignored_class` (
  `user_id` varchar(8) NOT NULL DEFAULT '0' COMMENT 'ユーザーID',
  `class_id` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '授業ID',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`class_id`),
  KEY `user_id_update_date` (`user_id`,`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'incentive_history'
CREATE TABLE `incentive_history` (
  `incentive_history_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '対象ユーザー',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'インセンティブ種類 1:新規学部登録',
  `faculty_id` tinyint(1) unsigned DEFAULT NULL COMMENT 'null:学部未選択, 0:学部非所属を選択,n:選択した学部ID',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`incentive_history_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2346 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'invitation_guest'
CREATE TABLE `invitation_guest` (
  `invitation_guest_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '招待されたユーザー',
  `invitation_host_id` int(32) unsigned NOT NULL COMMENT 'invitation_hostのID',
  `incentive_item` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'インセンティブ品 0:なし,1:チケット',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '種類 1:定常招待, 2:キャンペーン',
  `ref` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '経路 0:デフォルト, 1:メール, 2:FB, 3:TW, 4:LINE',
  `env` tinyint(1) unsigned DEFAULT NULL COMMENT 'クライアント情報 0:web_pc / 1:web_iphone / 2:web_ipad / 3:web_android / 4:app_ios',
  `is_received` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'インセンティブ受け取ったかの判定 0:受け取っていない, 1:受け取った',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`invitation_guest_id`),
  KEY `user_id` (`user_id`),
  KEY `invitation_host_id` (`invitation_host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'invitation_history'
CREATE TABLE `invitation_history` (
  `invitation_history_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(16) NOT NULL,
  `invitation_host_id` int(32) unsigned NOT NULL,
  `method` tinyint(1) unsigned DEFAULT '0' COMMENT '招待方法 1:メール, 2:FB, 3:TW, 4:LINE',
  `env` tinyint(1) unsigned DEFAULT NULL COMMENT 'クライアント情報 0:web_pc / 1:web_iphone / 2:web_ipad / 3:web_android / 4:app_ios',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`invitation_history_id`),
  KEY `user_id` (`user_id`),
  KEY `invitation_host_id` (`invitation_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3695 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'invitation_host'
CREATE TABLE `invitation_host` (
  `invitation_host_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `is_premium` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '招待時のプレミアム判定 0:オープン,1:プレミアム',
  `incentive_item` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'インセンティブ品 0:なし,1:チケット,2:グッズ,3:レビュー権',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1:定常招待, 2:キャンペーン',
  `is_received` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'インセンティブ受け取ったかの判定 0:受け取っていない, 1:受け取った',
  `token` varchar(255) NOT NULL COMMENT 'トークン',
  `options` text COMMENT '追加情報',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`invitation_host_id`),
  UNIQUE KEY `token` (`token`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=162794 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'job'
CREATE TABLE `job` (
  `job_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `queue_name` varchar(64) NOT NULL DEFAULT '' COMMENT 'MessageQueueのキュー名',
  `command` varbinary(255) NOT NULL DEFAULT '' COMMENT 'ジョブを実行するコマンド',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`job_id`),
  UNIQUE KEY `queue_name` (`queue_name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'leave_questionnaire'
CREATE TABLE `leave_questionnaire` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザーID',
  `reason_id` int(11) NOT NULL COMMENT 'leave_questionnaire_reasonsテーブルのidが入ります',
  `comment` text COMMENT '自由記述のテキストが入ります',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='無料退会時のアンケートを管理';

-- Create syntax for TABLE 'leave_questionnaire_categories'
CREATE TABLE `leave_questionnaire_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'leave_questionnaire_reasonsテーブルの’category_idと同値です',
  `category_name` varchar(255) NOT NULL COMMENT 'カテゴリー名',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='アンケートのカテゴリーを管理するマスターテーブル';

-- Create syntax for TABLE 'leave_questionnaire_reasons'
CREATE TABLE `leave_questionnaire_reasons` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_id` int(11) unsigned NOT NULL COMMENT 'leave_questionnaire_categoriesテーブルの’idと同値です',
  `reason_text` varchar(255) NOT NULL COMMENT '質問内容',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除した場合1',
  `sort_id` int(11) unsigned NOT NULL COMMENT '表示順を管理するID',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='アンケートの質問内容を管理するマスターテーブル';

-- Create syntax for TABLE 'mail_schedule'
CREATE TABLE `mail_schedule` (
  `mail_schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `send_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '送信日時',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '送信ステータス',
  `title` varchar(255) DEFAULT NULL COMMENT 'タイトル',
  `body_text` text COMMENT 'テキスト本文',
  `body_html` text COMMENT 'HTML本文',
  `sender_name` varchar(255) DEFAULT NULL,
  `send_cnt` int(32) NOT NULL COMMENT '送信者数',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`mail_schedule_id`),
  KEY `send_date` (`send_date`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8 COMMENT='メールスケジュール';

-- Create syntax for TABLE 'mail_template'
CREATE TABLE `mail_template` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'テンプレート名',
  `sender_name` varchar(255) DEFAULT NULL COMMENT '送信者名',
  `subject` text NOT NULL COMMENT '題名テンプレート',
  `body` text NOT NULL COMMENT '本文テンプレート',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='メールテンプレート格納テーブル';

-- Create syntax for TABLE 'mail_title'
CREATE TABLE `mail_title` (
  `mail_title_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'メールタイプ',
  `title` text NOT NULL COMMENT 'メールタイトル',
  `send_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mail_title_id`),
  KEY `send_date` (`send_date`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8 COMMENT='メールタイトル';

-- Create syntax for TABLE 'mail_transition'
CREATE TABLE `mail_transition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sum` int(32) NOT NULL COMMENT '送信者数の合計',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:全体, 1:メルマガ, 2:受けない, 3:直前受けたい, 4:前日受けたい, 5:新着入稿, 6:受け忘れ',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9546 DEFAULT CHARSET=utf8 COMMENT='メール送信数の推移格納table';

-- Create syntax for TABLE 'map_category'
CREATE TABLE `map_category` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `category_id` int(32) NOT NULL COMMENT 'カテゴリーID',
  PRIMARY KEY (`id`),
  KEY `user` (`user_id`),
  KEY `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=447745 DEFAULT CHARSET=utf8 COMMENT='クラス用のカテゴリー一覧';

-- Create syntax for TABLE 'map_category_tag'
CREATE TABLE `map_category_tag` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `category_id` int(32) NOT NULL COMMENT 'category id',
  `tag_id` varchar(40) NOT NULL COMMENT 'tag id',
  PRIMARY KEY (`id`),
  KEY `tag` (`tag_id`),
  KEY `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='カテゴリとタグのマッピング用table';

-- Create syntax for TABLE 'map_category_to_class'
CREATE TABLE `map_category_to_class` (
  `category_id` int(32) NOT NULL,
  `class_id` int(32) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`,`class_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='授業とカテゴリーのマッピング';

-- Create syntax for TABLE 'map_category_to_course'
CREATE TABLE `map_category_to_course` (
  `category_id` int(32) NOT NULL,
  `course_id` int(32) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`,`course_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='コースとカテゴリーのマッピング';

-- Create syntax for TABLE 'map_class_to_class_community_tags'
CREATE TABLE `map_class_to_class_community_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'マッピングID',
  `class_id` int(32) NOT NULL COMMENT 'class_id',
  `class_community_tag_id` int(11) NOT NULL COMMENT 'コミュニティタグのID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_class_id_class_community_tag_id` (`class_id`,`class_community_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8 COMMENT='コミュニティタグのマッピングテーブル';

-- Create syntax for TABLE 'map_class_to_class_experience_type'
CREATE TABLE `map_class_to_class_experience_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'マッピングID',
  `class_id` int(32) NOT NULL COMMENT 'class_id',
  `class_experience_type_id` int(11) NOT NULL COMMENT '授業種別のID',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 COMMENT='授業種別とマスターのマッピングテーブル';

-- Create syntax for TABLE 'map_class_to_corporation'
CREATE TABLE `map_class_to_corporation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(10) unsigned NOT NULL,
  `corporation_id` int(10) unsigned NOT NULL,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_to_corporation_id` (`class_id`,`corporation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='特定の法人のみが閲覧できる授業のmapping';

-- Create syntax for TABLE 'map_class_to_external_service'
CREATE TABLE `map_class_to_external_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(10) unsigned NOT NULL COMMENT '授業id',
  `external_service_id` int(10) unsigned NOT NULL COMMENT '対象となる連携先: 1:BENEFIT ONE, 2:CW, 3:DODA, 4:EN, 5:MyNAVI, 6:YAHOO',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`,`external_service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='授業と連携サービスとのマッピング';

-- Create syntax for TABLE 'map_class_to_faculty'
CREATE TABLE `map_class_to_faculty` (
  `map_class_to_faculty_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'マッピングID',
  `class_id` int(32) unsigned NOT NULL COMMENT '授業ID',
  `course_id` int(32) unsigned NOT NULL COMMENT 'コースID',
  `curriculum_id` int(32) unsigned NOT NULL COMMENT 'カリキュラムID',
  `faculty_id` int(32) unsigned NOT NULL COMMENT '学部ID',
  `class_order` tinyint(1) unsigned NOT NULL COMMENT '授業の順番',
  `course_order` tinyint(1) unsigned NOT NULL COMMENT 'コースの順番',
  `curriculum_order` tinyint(1) unsigned NOT NULL COMMENT 'カリキュラムの順番',
  `course_section` tinyint(1) unsigned NOT NULL COMMENT 'コースのセクション',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`map_class_to_faculty_id`),
  UNIQUE KEY `faculty_id_2` (`faculty_id`,`curriculum_id`,`course_id`,`class_id`),
  KEY `class_id` (`class_id`),
  KEY `course_id` (`course_id`),
  KEY `curriculum_id` (`curriculum_id`),
  KEY `faculty_id` (`faculty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9351 DEFAULT CHARSET=utf8;

-- Create syntax for VIEW 'map_course_to_class_v'
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `map_course_to_class_v`
AS SELECT
   distinct `co`.`course_id` AS `course_id`,
   `co`.`name` AS `course_name`,
   `co`.`type` AS `course_type`,
   `co`.`faculty_id` AS `faculty_id`,
   `co`.`description` AS `course_description`,
   `co`.`target_id` AS `course_target_id`,
   `co`.`target` AS `course_target`,
   `co`.`status` AS `course_status`,
   `co`.`regist_date` AS `course_regist_date`,
   `co`.`update_date` AS `course_update_date`,
   `cl`.`class_id` AS `class_id`,
   `cl`.`status` AS `class_status`,
   `cl`.`archive_status` AS `class_archive_status`,
   `cl`.`start_date` AS `class_start_date`,
   `cl`.`end_date` AS `class_end_date`,
   `cl`.`title` AS `class_title`,
   `cl`.`class_type` AS `class_type`,
   `cl`.`flg_corporation_ng` AS `class_flg_corporation_ng`,
   `m`.`class_order` AS `class_order`
FROM ((`course` `co` join `map_class_to_faculty` `m` on((`co`.`course_id` = `m`.`course_id`))) join `class` `cl` on(((`cl`.`class_id` = `m`.`class_id`) and (`cl`.`flg_delete` = 0))));

-- Create syntax for TABLE 'map_course_to_course_tag'
CREATE TABLE `map_course_to_course_tag` (
  `course_id` int(32) NOT NULL COMMENT 'コースID',
  `course_tag_id` int(32) NOT NULL COMMENT 'コースタグID',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`,`course_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='コースとコースタグのマッピングテーブル';

-- Create syntax for TABLE 'map_course_to_featured_course_list'
CREATE TABLE `map_course_to_featured_course_list` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `course_list_id` int(32) NOT NULL COMMENT 'コースリストid',
  `course_id` int(32) NOT NULL COMMENT 'コースid',
  `order` int(32) NOT NULL DEFAULT '0' COMMENT 'リスト内並び順',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_map_course_to_featured_course_list_01` (`course_list_id`,`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='コースリストとコースのマッピング';

-- Create syntax for TABLE 'map_curriculum_to_group'
CREATE TABLE `map_curriculum_to_group` (
  `map_curriculum_to_group_id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `curriculum_id` int(32) unsigned NOT NULL COMMENT 'カリキュラムID',
  `group_id` int(32) unsigned NOT NULL COMMENT 'グループID',
  `route_term` int(11) NOT NULL DEFAULT '0' COMMENT 'ルートターム',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '1:議論, 2:Q&A',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`map_curriculum_to_group_id`),
  UNIQUE KEY `curriculum_id_group_id` (`curriculum_id`,`group_id`),
  KEY `curriculum_id` (`curriculum_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'map_faculty_to_class'
CREATE TABLE `map_faculty_to_class` (
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `section_id` int(32) unsigned DEFAULT NULL COMMENT 'セクションID',
  `class_order` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '同一セクション内での授業の並び順。数字が小さいほうが優先。',
  `course_id` int(32) unsigned DEFAULT NULL COMMENT '科目ID',
  `faculty_id` int(32) unsigned NOT NULL COMMENT '学部ID',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`class_id`,`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'map_group_group_tag'
CREATE TABLE `map_group_group_tag` (
  `group_id` int(32) NOT NULL COMMENT 'グループID',
  `group_tag_id` int(32) NOT NULL COMMENT 'タグID（ハッシュ値40文字)',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`group_id`,`group_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='グループとタグのマッピングテーブル';

-- Create syntax for TABLE 'map_movie_to_movie_segment'
CREATE TABLE `map_movie_to_movie_segment` (
  `movie_id` int(32) unsigned NOT NULL COMMENT '映像ID',
  `movie_segment_id` int(32) unsigned NOT NULL COMMENT '映像セグメントID',
  `order_num` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '同一セグメント内での並び順。数字が小さいほうが優先。',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`movie_id`,`movie_segment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'map_sqls_to_sql_tags'
CREATE TABLE `map_sqls_to_sql_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sql_id` bigint(20) NOT NULL DEFAULT '0',
  `sql_tag_id` bigint(20) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_map_sqls_to_sql_tags_on_sql_id_and_sql_tag_id` (`sql_id`,`sql_tag_id`),
  KEY `index_map_sqls_to_sql_tags_on_sql_id` (`sql_id`),
  KEY `index_map_sqls_to_sql_tags_on_sql_tag_id` (`sql_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'map_teacher_to_curriculum'
CREATE TABLE `map_teacher_to_curriculum` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `teacher_id` int(10) unsigned NOT NULL COMMENT '先生id',
  `curriculum_id` int(10) unsigned NOT NULL COMMENT '対象のカリキュラムID',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`,`curriculum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='先生とカリキュラム（ルート）のマッピング';

-- Create syntax for TABLE 'map_user_group'
CREATE TABLE `map_user_group` (
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `group_id` int(32) NOT NULL COMMENT 'グループID',
  `is_created` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:非作成者, 1:作成者',
  `status` enum('leave','join','admin','ban') NOT NULL COMMENT 'leave:退会者, join:参加者, admin:管理者, ban:強制退会者',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ユーザーとグループのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_benchmark'
CREATE TABLE `map_user_schoo_to_benchmark` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `benchmark_contact_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `benchmark_contact_id` (`benchmark_contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BenchmarkコンタクトIDとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_benefitone'
CREATE TABLE `map_user_schoo_to_benefitone` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `benefitone_sid` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `benefitone_sid` (`benefitone_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ベネフィット・ワンとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_bizene'
CREATE TABLE `map_user_schoo_to_bizene` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `bizene_map_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `bizene_map_id` (`bizene_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ビジエネとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_careeful'
CREATE TABLE `map_user_schoo_to_careeful` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `careeful_map_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'schoo側のユーザIDを使用してユニークにしている。現在使用していない。',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `careeful_map_id` (`careeful_map_id`),
  KEY `index_map_user_schoo_to_careeful_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='キャリフルとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_cw'
CREATE TABLE `map_user_schoo_to_cw` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `cw_map_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `map_id` (`cw_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='クラウドワークスとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_doda'
CREATE TABLE `map_user_schoo_to_doda` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `doda_map_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `doda_map_id` (`doda_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DODAとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_en'
CREATE TABLE `map_user_schoo_to_en` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `en_map_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `map_id` (`en_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='エン・ジャパンとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_linkacademy'
CREATE TABLE `map_user_schoo_to_linkacademy` (
  `map_user_schoo_to_linkacademy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `linkacademy_id` varchar(64) NOT NULL COMMENT '受講生番号',
  `linkacademy_school_code` int(10) unsigned NOT NULL COMMENT '校舎コード',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`map_user_schoo_to_linkacademy_id`),
  UNIQUE KEY `uq_map_user_to_coupon_01` (`user_id`),
  UNIQUE KEY `uq_map_user_to_coupon_02` (`linkacademy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='リンクアカデミー（AVIVA/DAIEI）ユーザーとschoo WEB-campusユーザーのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_mynavi'
CREATE TABLE `map_user_schoo_to_mynavi` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `mynavi_map_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `map_id` (`mynavi_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='マイナビとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_recruitjobs'
CREATE TABLE `map_user_schoo_to_recruitjobs` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `recruitjobs_map_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `map_id` (`recruitjobs_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='リクルートジョブズとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_schoo_to_yahoo'
CREATE TABLE `map_user_schoo_to_yahoo` (
  `user_id` varchar(8) NOT NULL DEFAULT '',
  `yahoo_map_id` varchar(255) NOT NULL DEFAULT '',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `map_id` (`yahoo_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Yahooとスクーのユーザのマッピングテーブル';

-- Create syntax for TABLE 'map_user_to_class'
CREATE TABLE `map_user_to_class` (
  `user_id` varchar(8) NOT NULL DEFAULT '0',
  `class_id` int(32) unsigned NOT NULL DEFAULT '0',
  `attend_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '受講状況ステータス 1:受講中, 2:受講完了',
  `attend_status_update_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT 'attend_statusの更新日時',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ビデオの最終再生位置',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`class_id`),
  KEY `user_id` (`user_id`,`update_date`),
  KEY `user_id_attend_status` (`user_id`,`attend_status`,`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'map_user_to_coupon'
CREATE TABLE `map_user_to_coupon` (
  `map_user_to_coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `coupon_id` int(10) unsigned NOT NULL,
  `coupon_service_name_en` varchar(255) NOT NULL,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`map_user_to_coupon_id`),
  UNIQUE KEY `uq_map_user_to_coupon_01` (`coupon_id`),
  UNIQUE KEY `uq_map_user_to_coupon_02` (`user_id`,`coupon_service_name_en`)
) ENGINE=InnoDB AUTO_INCREMENT=3448 DEFAULT CHARSET=utf8 COMMENT='発行したクーポンとユーザーのマッピングテーブル';

-- Create syntax for TABLE 'map_user_to_curriculum'
CREATE TABLE `map_user_to_curriculum` (
  `user_id` varchar(8) NOT NULL DEFAULT '0',
  `curriculum_id` int(32) unsigned NOT NULL DEFAULT '0',
  `join_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '参加ステータス 1:参加中, 2:中断中',
  `attend_pace` tinyint(1) NOT NULL DEFAULT '0' COMMENT '受講ペース',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`curriculum_id`),
  KEY `curriculum_id_join_status` (`curriculum_id`,`join_status`),
  KEY `curriculum_id_regist_date` (`curriculum_id`,`regist_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'map_user_to_slide_password'
CREATE TABLE `map_user_to_slide_password` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザid',
  `slide_password` varchar(255) NOT NULL COMMENT 'パスワード',
  `is_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'パスワードの有効性　1:有効,0:無効',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`slide_password`)
) ENGINE=InnoDB AUTO_INCREMENT=813 DEFAULT CHARSET=utf8 COMMENT='ユーザーのダウンロード資料用パスワード';

-- Create syntax for TABLE 'masterplan_interviews'
CREATE TABLE `masterplan_interviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` text COMMENT '事前ヒアリングの質問テキスト',
  `answer_json` text COMMENT '質問の答えのデータJSON',
  `type` int(10) unsigned NOT NULL COMMENT '質問項目の種類　1:セレクトボックス 2:チェックボックス(複数選択可), 3:テキスト, 4:トグル, 5:ラジオボタン',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='マスタープランユーザーの事前ヒアリング項目テーブル';

-- Create syntax for TABLE 'masterplan_invitation_histories'
CREATE TABLE `masterplan_invitation_histories` (
  `masterplan_invitation_histories_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `w_id` varchar(50) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`masterplan_invitation_histories_id`),
  UNIQUE KEY `uq_masterplan_invitation_histories_01` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='マスタープラン招待割引コードの適用履歴';

-- Create syntax for TABLE 'masterplan_user_info'
CREATE TABLE `masterplan_user_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL,
  `route_id` int(10) unsigned NOT NULL,
  `interview_answers_json` text COMMENT '事前ヒアリングの結果JSON',
  `final_test_review_key` varchar(64) DEFAULT NULL,
  `certificate_key` varchar(64) DEFAULT NULL,
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=319 DEFAULT CHARSET=utf8 COMMENT='マスタープランユーザーの事前ヒアリング結果を保存するテーブル';

-- Create syntax for TABLE 'mem_stream'
CREATE TABLE `mem_stream` (
  `id` varchar(40) NOT NULL,
  `expire` int(11) NOT NULL COMMENT '有効期限(unix time)',
  PRIMARY KEY (`id`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'memo'
CREATE TABLE `memo` (
  `user_id` varchar(8) NOT NULL COMMENT 'user_id',
  `class_id` int(32) NOT NULL COMMENT 'class_id',
  `text` text NOT NULL COMMENT 'text',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_delete` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'minute'
CREATE TABLE `minute` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `youtube_id` varchar(100) NOT NULL COMMENT 'YouTube id',
  `title` text NOT NULL COMMENT 'タイトル',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'ステータス 0:準備中 1:予約中 2:本番公開中',
  `class_id` int(32) NOT NULL COMMENT 'クラスID',
  `description` text COMMENT 'SEO用のdescription',
  `detail_text` text NOT NULL COMMENT '動画説明',
  `facebook_text` text NOT NULL COMMENT 'facebook拡散文言',
  `twitter_text` text NOT NULL COMMENT 'twitter拡散文言',
  `play_time` time NOT NULL COMMENT '再生時間',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '動画の種類 0:なし, 1:ビジネス',
  `view_cnt` int(32) NOT NULL DEFAULT '0' COMMENT '視聴回数',
  `flg_featured` tinyint(1) NOT NULL DEFAULT '0' COMMENT '注目フラグ 0:注目されていない, 1:注目されている',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済',
  `regist_date` datetime NOT NULL COMMENT '作成日',
  `update_date` datetime DEFAULT NULL COMMENT '更新日',
  PRIMARY KEY (`id`),
  UNIQUE KEY `youtube` (`youtube_id`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8 COMMENT='スクーminute用テーブル';

-- Create syntax for TABLE 'monthly_live_class_theme'
CREATE TABLE `monthly_live_class_theme` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'テーマ名',
  `copy` varchar(255) NOT NULL DEFAULT '' COMMENT 'キャッチフレーズ',
  `body` text NOT NULL COMMENT '本文',
  `year_month` int(10) unsigned NOT NULL COMMENT '対象の年と月',
  `image_url_large` varchar(255) DEFAULT NULL COMMENT '画像URL（大）',
  `image_url_small` varchar(255) DEFAULT NULL COMMENT '画像URL（小）',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: 非公開 1:公開',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1: 削除',
  `created_at` datetime DEFAULT NULL COMMENT '作成日',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='毎月の生放送のテーマを管理するテーブル';

-- Create syntax for TABLE 'movie'
CREATE TABLE `movie` (
  `movie_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT '映像ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'タイトル',
  `file_url` varchar(255) DEFAULT NULL COMMENT '映像ファイルURL',
  `akamai_path` varchar(255) DEFAULT NULL COMMENT 'アカマイの映像パス',
  `start_second` int(32) unsigned DEFAULT NULL COMMENT '映像の開始秒数',
  `end_second` int(32) unsigned DEFAULT NULL COMMENT '映像の終了秒数',
  `description` text COMMENT '説明文',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'movie_history'
CREATE TABLE `movie_history` (
  `movie_history_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `movie_id` int(32) unsigned NOT NULL COMMENT 'ムービーID',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`movie_history_id`),
  KEY `user_id` (`user_id`),
  KEY `movie_id` (`movie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=698 DEFAULT CHARSET=utf8 COMMENT='映像の視聴履歴';

-- Create syntax for TABLE 'movie_segment'
CREATE TABLE `movie_segment` (
  `movie_segment_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT '映像セグメントID',
  `title` varchar(255) DEFAULT NULL COMMENT 'タイトル',
  `directory` varchar(255) NOT NULL COMMENT 'ディレクトリ',
  `subdirectory` varchar(255) DEFAULT NULL COMMENT 'サブディレクトリ',
  `description` text COMMENT '説明文',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`movie_segment_id`),
  KEY `directory` (`directory`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'news'
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '0:未公開, 1:テスト公開, 2:本番公開',
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '0:お知らせ, 1:授業関連, 2:キャンペーン, 3:その他',
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `fb_text` text NOT NULL,
  `ogp_image` varchar(255) DEFAULT NULL COMMENT 'OGP画像のURL',
  `tw_text` text NOT NULL,
  `post_date` datetime NOT NULL,
  `regist_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `flg_delete` int(1) NOT NULL DEFAULT '0',
  `flg_web` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Web表示フラグ 0:非表示, 1:表示',
  `flg_biz` tinyint(1) NOT NULL DEFAULT '0' COMMENT '法人web表示フラグ 0:非表示, 1:表示',
  `flg_ios` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'iOS表示フラグ 0:非表示, 1:表示',
  `flg_android` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Android表示フラグ 0:非表示, 1:表示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'notification'
CREATE TABLE `notification` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `reaction_id` int(8) NOT NULL COMMENT 'likeのあったコメントID',
  `reaction_parent_id` int(32) DEFAULT NULL COMMENT '親コメントID',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ(0,1)',
  `flg_notification` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'like通知フラグ(0,1)',
  `flg_like_notification` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'like通知フラグ(0,1)',
  PRIMARY KEY (`id`),
  KEY `target_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3721 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'notification_contents'
CREATE TABLE `notification_contents` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `text` text NOT NULL COMMENT '通知内容',
  `text_type` tinyint(1) NOT NULL COMMENT '通知内容種別',
  `create_dt` datetime NOT NULL COMMENT '作成日',
  `create_user_id` varchar(255) NOT NULL COMMENT '通知作成者ID',
  `code` varchar(40) NOT NULL COMMENT '開封済みフラグ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=533 DEFAULT CHARSET=utf8 COMMENT='通知内容table';

-- Create syntax for TABLE 'notifications'
CREATE TABLE `notifications` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `user_id` varchar(255) NOT NULL COMMENT '通知ユーザID',
  `create_user_id` varchar(255) NOT NULL COMMENT '通知作成ユーザID',
  `content_id` int(32) NOT NULL COMMENT '送信内容ID',
  `template_id` int(32) NOT NULL DEFAULT '0' COMMENT 'テンプレートID',
  `flg_opened` tinyint(1) NOT NULL DEFAULT '0' COMMENT '開封済みフラグ',
  `create_dt` datetime NOT NULL COMMENT '作成日',
  `opened_dt` datetime DEFAULT NULL COMMENT '開封日',
  PRIMARY KEY (`id`),
  KEY `by_user_id` (`user_id`,`flg_opened`),
  KEY `create_dt` (`create_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知table';

-- Create syntax for TABLE 'opinion_to_dev'
CREATE TABLE `opinion_to_dev` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザーID',
  `text` text NOT NULL COMMENT '要望',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='開発への要望を管理するテーブル';

-- Create syntax for TABLE 'portfolio'
CREATE TABLE `portfolio` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL,
  `curriculum_id` int(11) NOT NULL,
  `description` varchar(2048) NOT NULL COMMENT 'ポートフォリオ説明/コメント',
  `assets_key` varchar(32) NOT NULL COMMENT 'アセットのパスキー',
  `assets_json` text NOT NULL COMMENT 'アセット情報のJsonText',
  `is_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'ポートフォリオの有効1/無効0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`id`),
  KEY `assets_key` (`assets_key`),
  KEY `user_id` (`user_id`,`is_active`,`update_date`),
  KEY `curriculum_id` (`curriculum_id`,`is_active`,`update_date`),
  KEY `user_id_2` (`user_id`,`curriculum_id`,`is_active`,`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='ポートフォリオ情報';

-- Create syntax for TABLE 'premium_cancel_questionnaire'
CREATE TABLE `premium_cancel_questionnaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL DEFAULT '',
  `reason_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '退会理由番号',
  `category_id` tinyint(4) NOT NULL DEFAULT '0' COMMENT '退会理由のカテゴリ',
  `detail` text COMMENT '退会理由自由記述',
  `regist_date` datetime DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `update_date` (`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=12144 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'premium_purchase_questionnaire'
CREATE TABLE `premium_purchase_questionnaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL DEFAULT '',
  `item_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '項目番号',
  `category_id` tinyint(4) NOT NULL DEFAULT '0' COMMENT '項目のカテゴリ',
  `detail` text COMMENT '自由記述',
  `purchase_id` int(11) NOT NULL DEFAULT '0' COMMENT '購入履歴ID',
  `regist_date` datetime DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `update_date` (`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'presenter'
CREATE TABLE `presenter` (
  `presenter_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT '学生代表ID',
  `name` varchar(255) NOT NULL COMMENT '名前',
  `post` varchar(255) DEFAULT NULL COMMENT '役職',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`presenter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'provider'
CREATE TABLE `provider` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '担当部署メールアドレス(アラートが届くメールアドレス)',
  `official_email` varchar(255) NOT NULL DEFAULT '' COMMENT '公式アカウント用メールアドレス',
  `logo_img_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'ロゴ画像のパス',
  `site_url` varchar(255) NOT NULL DEFAULT '' COMMENT 'WebサイトのURL',
  `summary` varchar(255) NOT NULL DEFAULT '' COMMENT '団体概要',
  `comment` text NOT NULL COMMENT '団体説明',
  `path` varchar(100) DEFAULT NULL COMMENT '団体詳細ページパス',
  `header_img_path` varchar(255) NOT NULL DEFAULT '' COMMENT '公認団体ページ：ヘッダー画像パス',
  `background_img_path` varchar(255) NOT NULL DEFAULT '' COMMENT '公認団体ページ：背景画像パス',
  `background_color_code` varchar(10) NOT NULL DEFAULT '' COMMENT '背景色のカラーコード',
  `header_color_code` varchar(10) NOT NULL DEFAULT '' COMMENT '公認団体ページ：hタグのカラーコード',
  `header_font_color_code` varchar(10) NOT NULL DEFAULT '777777' COMMENT '公認団体ページ：hタグ文字のカラーコード',
  `is_public_channel_page` tinyint(1) NOT NULL DEFAULT '0' COMMENT '公認団体ページ：公開設定 0:非公開, 1:公開',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'purchase'
CREATE TABLE `purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '購入履歴ID',
  `user_id` varchar(8) NOT NULL,
  `price` int(11) NOT NULL COMMENT '\\''税込価格\\''',
  `goods_id` int(11) NOT NULL,
  `purchase_date` datetime NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0:GMOカード(525円) / 1:iOS自動課金 / 2: 法人プレミアム / 3: GMOカード(980円)',
  `w_id` varchar(50) NOT NULL,
  `flg_delete` int(11) NOT NULL DEFAULT '0',
  `cancel_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '解約日',
  `expire_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT 'Appleレシートの有効期限',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `type_history` int(11) NOT NULL DEFAULT '1' COMMENT '複数種類のプレミアム会員の遷移履歴',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `goods_id` (`user_id`,`goods_id`,`flg_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=55595 DEFAULT CHARSET=utf8 COMMENT='ユーザの月額課金(プレミアム会員)状態を管理するテーブル';

-- Create syntax for TABLE 'purchase_bank_transfer'
CREATE TABLE `purchase_bank_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL,
  `w_id` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未決済 / 1:決済完了済み',
  `purchase_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_and_w_id` (`user_id`,`w_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8 COMMENT='銀行振込の状態を管理するテーブル';

-- Create syntax for TABLE 'purchase_carrier'
CREATE TABLE `purchase_carrier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL,
  `access_id` varchar(32) NOT NULL COMMENT '取引ID',
  `access_pass` varchar(32) NOT NULL COMMENT '取引パスワード',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'プレミアム会員タイプ',
  `w_id` varchar(50) NOT NULL COMMENT 'スクー側で一意に識別するためのOrderID',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_w_id` (`user_id`,`w_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='キャリア課金の取引データを管理するテーブル';

-- Create syntax for TABLE 'purchase_class_history'
CREATE TABLE `purchase_class_history` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `class_id` int(32) unsigned NOT NULL COMMENT 'クラスID',
  `purchase_id` int(32) unsigned NOT NULL COMMENT '課金ID',
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザーID',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `purchase_id` (`purchase_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='課金流入元クラス履歴';

-- Create syntax for TABLE 'purchase_credit_installment'
CREATE TABLE `purchase_credit_installment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `w_id` varchar(50) NOT NULL,
  `method` tinyint(4) NOT NULL DEFAULT '1',
  `pay_times` tinyint(4) NOT NULL DEFAULT '1',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_w_id` (`w_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'purchase_customer_types'
CREATE TABLE `purchase_customer_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` int(10) unsigned NOT NULL COMMENT '識別子として扱う値',
  `title` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_purchase_customer_types_01` (`identifier`),
  KEY `idx_purchase_customer_types_01` (`status`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='顧客区分情報を管理するマスター';

-- Create syntax for TABLE 'purchase_goods'
CREATE TABLE `purchase_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` int(10) unsigned NOT NULL COMMENT '識別子として扱う値',
  `title` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_purchase_goods_01` (`identifier`),
  KEY `idx_purchase_goods_01` (`status`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商品区分を管理するマスター';

-- Create syntax for TABLE 'purchase_goods_items'
CREATE TABLE `purchase_goods_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL COMMENT 'related `purchase_goods.id`',
  `identifier` int(10) unsigned NOT NULL COMMENT '識別子として扱う値',
  `title` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_purchase_goods_items_01` (`identifier`),
  KEY `idx_purchase_goods_items_01` (`status`,`goods_id`),
  KEY `idx_purchase_goods_items_02` (`status`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='品目区分を管理するマスター';

-- Create syntax for TABLE 'purchase_history'
CREATE TABLE `purchase_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `action_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT 'アクションした日時',
  `action_target` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'アクションの対象',
  `premium_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'プレミアム会員の種類',
  `action` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'アクション内容',
  `options` varchar(255) NOT NULL COMMENT '追加情報',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32926 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'purchase_masterplan_term'
CREATE TABLE `purchase_masterplan_term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route_id` int(11) NOT NULL DEFAULT '0',
  `start_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `flg_delete` int(11) NOT NULL DEFAULT '0',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8 COMMENT='マスタープランの開始可能日時の管理テーブル';

-- Create syntax for TABLE 'purchase_payment_methods'
CREATE TABLE `purchase_payment_methods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` int(10) unsigned NOT NULL COMMENT '識別子として扱う値',
  `title` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_purchase_payment_methods_01` (`identifier`),
  KEY `idx_purchase_payment_methods_01` (`status`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='支払方法区分を管理するマスター';

-- Create syntax for TABLE 'purchase_settlement_means'
CREATE TABLE `purchase_settlement_means` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` int(10) unsigned NOT NULL COMMENT '識別子として扱う値',
  `title` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_purchase_settlement_means_01` (`identifier`),
  KEY `idx_purchase_settlement_means_01` (`status`,`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='決済手段区分を管理するマスター';

-- Create syntax for TABLE 'purchase_student_discount_status'
CREATE TABLE `purchase_student_discount_status` (
  `purchase_student_discount_status_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `w_id` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`purchase_student_discount_status_id`),
  UNIQUE KEY `uq_purchase_student_discount_status_01` (`user_id`,`w_id`),
  KEY `idx_purchase_student_discount_status_01` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生料金で契約したユーザーの状態管理を行う';

-- Create syntax for TABLE 'purchase_types'
CREATE TABLE `purchase_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL COMMENT 'related `purchase.type`',
  `goods_item_id` int(10) unsigned NOT NULL COMMENT 'related `purchase_goods_items.id`',
  `customer_type_id` int(10) unsigned NOT NULL COMMENT 'related `purchase_customer_types.id`',
  `settlement_means_id` int(10) unsigned NOT NULL COMMENT 'related `purchase_settlement_means.id`',
  `payment_method_id` int(10) unsigned NOT NULL COMMENT 'related `purchase_payment_methods.id`',
  `price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当該契約タイプにおける定価',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `type_history_ext` tinyint(2) unsigned NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT '値が意味することを記す（内部向け）',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_purchase_types_01` (`type`),
  KEY `idx_purchase_types_01` (`status`,`type`),
  KEY `idx_purchase_types_02` (`status`,`goods_item_id`),
  KEY `idx_purchase_types_03` (`status`,`customer_type_id`),
  KEY `idx_purchase_types_04` (`status`,`settlement_means_id`),
  KEY `idx_purchase_types_05` (`status`,`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='契約タイプ（purchaseテーブルに保持されているtype値）を管理するマスター（mapデータ）';

-- Create syntax for TABLE 'push_message'
CREATE TABLE `push_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1:5分前 / 2:新着',
  `env` tinyint(4) NOT NULL COMMENT 'userテーブルのenvに対応',
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2305 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'push_notification_history'
CREATE TABLE `push_notification_history` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `instance_id` int(32) unsigned NOT NULL COMMENT 'デバイスID',
  `push_notification_types_id` int(32) NOT NULL COMMENT '通知タイプID',
  `is_active` int(32) NOT NULL DEFAULT '0' COMMENT '0:無効, 1:有効',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='プッシュ通知の許諾履歴テーブル';

-- Create syntax for TABLE 'push_notification_types'
CREATE TABLE `push_notification_types` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT '通知タイプID',
  `identifier` int(32) unsigned NOT NULL COMMENT '通知タイプの識別子として扱う値',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '通知タイプ名',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='プッシュ通知タイプのマスターテーブル';

-- Create syntax for TABLE 'push_react_history'
CREATE TABLE `push_react_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `push_message_id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `sent_date` datetime NOT NULL,
  `react_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `key_for_update` (`push_message_id`,`user_id`),
  KEY `react_date` (`react_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'push_tokens'
CREATE TABLE `push_tokens` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `user_id` varchar(255) NOT NULL COMMENT '通知ユーザID',
  `token` varchar(255) NOT NULL COMMENT 'push token',
  `os` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1:iOS 2:android',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:スク生, 1:schoo録画版',
  `expire_dt` datetime NOT NULL COMMENT 'tokenの有効期限',
  `create_dt` datetime NOT NULL COMMENT '作成日',
  `update_dt` datetime DEFAULT NULL COMMENT 'token更新日',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1:有効, 0:無効',
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_uniquedevice` (`user_id`,`os`),
  KEY `by_is_active` (`is_active`),
  KEY `by_uniquetoken` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='push用token格納table';

-- Create syntax for TABLE 'reaction'
CREATE TABLE `reaction` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `parent_id` int(32) DEFAULT NULL COMMENT '親コメントID',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `user_id` varchar(8) NOT NULL COMMENT '学籍番号',
  `text` text NOT NULL COMMENT '本文',
  `flg_share` tinyint(1) NOT NULL DEFAULT '0' COMMENT '外部サービス投稿フラグ',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `latest_child_date` datetime NOT NULL COMMENT '子コメント最新登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ',
  `child_count` int(11) NOT NULL DEFAULT '0' COMMENT 'リアクションについたcomment数',
  `type` int(1) DEFAULT '0' COMMENT '0:リアクション 1:質問',
  `title` varchar(255) DEFAULT NULL COMMENT 'タイトル',
  `kind` int(1) NOT NULL DEFAULT '0' COMMENT '0:フリー 1:誰か教えて 2:課題提出',
  `flg_parent_delete` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `thread` (`class_id`,`type`,`parent_id`,`flg_delete`),
  KEY `notification` (`parent_id`,`regist_date`),
  KEY `class` (`class_id`,`flg_delete`),
  KEY `user_post` (`user_id`,`parent_id`,`flg_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=7741 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'reaction_like'
CREATE TABLE `reaction_like` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `reaction_id` int(32) NOT NULL COMMENT 'コメントID',
  `user_id` varchar(8) NOT NULL COMMENT '学籍番号',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ(0,1)',
  `class_id` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reaction_id` (`reaction_id`,`user_id`),
  KEY `parent_id` (`reaction_id`),
  KEY `search_class` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8519 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'regist_mail'
CREATE TABLE `regist_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail` varchar(255) NOT NULL,
  `regist_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'roll_history'
CREATE TABLE `roll_history` (
  `roll_id` varchar(35) NOT NULL COMMENT 'このIDをもとに、退席データを入力する。出席した時点でhiddenにroll_idを出力し、退出時にapiにroll_idをを渡す。',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `user_id` varchar(8) NOT NULL COMMENT '学籍番号',
  `entry_time` datetime NOT NULL COMMENT '出席日時',
  `exit_time` datetime NOT NULL COMMENT '退出日時',
  `type` int(1) NOT NULL COMMENT '現在未使用(2014/06/24)',
  `env` int(2) DEFAULT NULL COMMENT '端末種別',
  PRIMARY KEY (`roll_id`),
  KEY `join` (`class_id`,`user_id`),
  KEY `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出席管理用テーブル';

-- Create syntax for TABLE 'rollbook_off'
CREATE TABLE `rollbook_off` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `class_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:通常授業, 2:課外授業',
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時(削除フラグが立った時)',
  `flg_attendance` tinyint(1) NOT NULL DEFAULT '0' COMMENT '出欠（当日きたかどうか）',
  `attend_date` datetime DEFAULT NULL COMMENT '出欠登録日時',
  `flg_cancel` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'キャンセルしたら1',
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=937 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'rollbook_on'
CREATE TABLE `rollbook_on` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `class_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:通常授業, 2:課外授業',
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時(削除フラグが立った時)',
  `flg_attendance` tinyint(1) NOT NULL DEFAULT '0' COMMENT '出欠（当日見たかどうか）',
  `attend_date` datetime DEFAULT NULL COMMENT '出欠登録日時',
  `flg_cancel` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'キャンセルしたら1',
  UNIQUE KEY `id` (`id`),
  KEY `class_id` (`class_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20514 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'schema_migrations'
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'section'
CREATE TABLE `section` (
  `section_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'セクションID',
  `course_id` int(32) unsigned NOT NULL COMMENT '科目ID',
  `section_order` int(32) unsigned NOT NULL DEFAULT '0' COMMENT '同一科目内でのセクションの並び順。数字が大きいほうが優先。',
  `name` varchar(1000) NOT NULL COMMENT '名前',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'short_url'
CREATE TABLE `short_url` (
  `base_url` varchar(255) DEFAULT NULL COMMENT '元となるURL',
  `short_url` varchar(255) DEFAULT NULL COMMENT 'ショートURL',
  `code` varchar(255) DEFAULT NULL COMMENT 'code'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'slide_download_history'
CREATE TABLE `slide_download_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL COMMENT 'ユーザID',
  `class_id` int(10) unsigned NOT NULL COMMENT '授業id',
  `pdf_hash` varchar(255) NOT NULL COMMENT 'DLされたPDFのHash値',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`regist_date`),
  KEY `class_id` (`class_id`,`regist_date`)
) ENGINE=InnoDB AUTO_INCREMENT=5395 DEFAULT CHARSET=utf8 COMMENT='資料DLの履歴';

-- Create syntax for TABLE 'social_action_stream'
CREATE TABLE `social_action_stream` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `class_id` int(32) unsigned NOT NULL COMMENT 'クラスID',
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザーID',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:無効 1:しりたい 2:なるほど',
  `value` decimal(6,3) NOT NULL DEFAULT '0.000' COMMENT 'アクション効果値',
  `elapsed_ms` bigint(32) NOT NULL DEFAULT '0' COMMENT '授業開始時刻からの経過ミリ秒(このテーブルのは本当にミリ秒)',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  KEY `class_id_type_elapsed_ms` (`class_id`,`type`,`elapsed_ms`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='タイムラインストリームアクションデータ';

-- Create syntax for TABLE 'social_stream'
CREATE TABLE `social_stream` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `user_id` varchar(8) NOT NULL COMMENT '学籍番号',
  `text` text NOT NULL COMMENT '本文',
  `flg_share` tinyint(1) NOT NULL DEFAULT '0' COMMENT '外部サービス投稿フラグ',
  `class_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:通常授業, 2:課外授業',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時(削除フラグが立った時？)',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ0:削除しない1:削除する',
  `flg_twitter` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'twitter反映フラグ',
  `type` int(11) DEFAULT '0' COMMENT '0:チャット(通常発言) 1:質問 2:管理者発言 3:お知らせ 4:着席 5:受けたい声 6:なるほど 7:学んだ',
  `elapsed_ms` int(32) NOT NULL COMMENT '授業開始時刻からの経過ミリ秒',
  `env` tinyint(4) DEFAULT NULL COMMENT '投稿時のクライアント情報 0:web_pc / 1:web_iphone / 2:web_ipad / 3:web_android / 4:app_ios',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `class_id` (`class_id`),
  KEY `stream` (`class_id`,`id`,`elapsed_ms`),
  KEY `class_id_and_elapsed_ms` (`class_id`,`elapsed_ms`)
) ENGINE=InnoDB AUTO_INCREMENT=1224588 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'sql_tags'
CREATE TABLE `sql_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sql_tags_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'sqls'
CREATE TABLE `sqls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `query` text NOT NULL,
  `description` text,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sqls_on_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'support_tool_role_master'
CREATE TABLE `support_tool_role_master` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'support_tool_user_role'
CREATE TABLE `support_tool_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `support_tool_user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'support_tool_users'
CREATE TABLE `support_tool_users` (
  `support_tool_user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `support_tool_user_google_id` varchar(255) NOT NULL DEFAULT '',
  `support_tool_user_name` varchar(255) NOT NULL DEFAULT '',
  `support_tool_user_email` varchar(255) NOT NULL DEFAULT '',
  `support_tool_user_avatar` varchar(255) NOT NULL DEFAULT '',
  `support_tool_user_token` varchar(255) NOT NULL DEFAULT '',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`support_tool_user_id`),
  UNIQUE KEY `support_tool_user_unique` (`support_tool_user_google_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'tag'
CREATE TABLE `tag` (
  `id` varchar(40) NOT NULL COMMENT 'ハッシュ値40文字',
  `tag` varchar(100) NOT NULL COMMENT 'タグ名',
  `category_id` int(32) NOT NULL COMMENT 'カテゴリーID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`),
  KEY `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='クラス用のタグ一覧';

-- Create syntax for TABLE 'tags'
CREATE TABLE `tags` (
  `class_id` int(32) NOT NULL COMMENT 'クラスID',
  `tag_id` varchar(40) NOT NULL COMMENT 'tagID（ハッシュ値40文字)',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `class` (`class_id`),
  KEY `tag` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'target'
CREATE TABLE `target` (
  `target_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ターゲットID',
  `title` varchar(255) NOT NULL COMMENT 'ターゲット名',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`target_id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'teacher'
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '先生ID',
  `name` varchar(255) NOT NULL COMMENT '名前',
  `profile` text NOT NULL COMMENT 'プロフィール',
  `job` varchar(255) DEFAULT NULL COMMENT '職業等',
  `post` varchar(30) DEFAULT NULL,
  `ruby` varchar(50) DEFAULT NULL,
  `provider_id` int(32) NOT NULL DEFAULT '1',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `provider_id_update_date` (`provider_id`,`update_date`)
) ENGINE=InnoDB AUTO_INCREMENT=1843 DEFAULT CHARSET=utf8 COMMENT='先生情報';

-- Create syntax for TABLE 'teachers'
CREATE TABLE `teachers` (
  `class_id` int(32) NOT NULL COMMENT 'クラスID',
  `teacher_id` int(11) NOT NULL COMMENT '先生ID',
  `index` int(11) NOT NULL DEFAULT '1' COMMENT '順番',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`class_id`,`index`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'tentative_reservation_schedule'
CREATE TABLE `tentative_reservation_schedule` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `provider_id` int(32) unsigned NOT NULL,
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '仮押の開始日時',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '仮押の終了日時',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `provider_id` (`provider_id`),
  KEY `start_end_date` (`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='スケジュールの仮押日時の管理テーブル';

-- Create syntax for TABLE 'ticket'
CREATE TABLE `ticket` (
  `ticket_id` int(32) unsigned NOT NULL AUTO_INCREMENT COMMENT 'table id',
  `user_id` varchar(16) NOT NULL,
  `type` tinyint(1) unsigned DEFAULT '1' COMMENT '1:入学チケット(画像登録も含む), 2:定常招待チケット, 8:キャンペーンチケット, 9:CS(ユーザー対応)チケット',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未削除, 1:削除済み',
  `consume_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT 'チケット消費日',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日/削除日flg_delete=1の場合)',
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=492628 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'tmp_purchase_platinum'
CREATE TABLE `tmp_purchase_platinum` (
  `user_id` varchar(8) NOT NULL,
  `w_id` varchar(50) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='高ARPPU会員のGMOオーダーID(w_id)を管理するテーブル';

-- Create syntax for TABLE 'trial_attend_history'
CREATE TABLE `trial_attend_history` (
  `trial_attend_history_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) unsigned NOT NULL COMMENT 'ユーザーID',
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `user_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'お試し受講時のユーザーステータス 1:仮登録, 2:オープン学生',
  `env` tinyint(1) DEFAULT NULL COMMENT '会員登録時のクライアント情報 0:web_pc / 1:web_iphone / 2:web_ipad / 3:web_android / 4:app_ios',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trial_attend_history_id`),
  KEY `class_id` (`class_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8251 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'ua_enquete'
CREATE TABLE `ua_enquete` (
  `os` varchar(50) NOT NULL,
  `os_version` varchar(50) NOT NULL,
  `hard` varchar(50) NOT NULL,
  `browser` varchar(50) NOT NULL,
  `ua` varchar(255) NOT NULL,
  `answer` int(11) NOT NULL,
  `is_watch` int(11) NOT NULL COMMENT '0:fasle 1:true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'unregistered_class'
CREATE TABLE `unregistered_class` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL,
  `provider_id` int(32) unsigned NOT NULL COMMENT '公認団体id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '未登録授業ステータス(承認待ち/差戻/下書き等)',
  `comment` text NOT NULL COMMENT '差し戻しの際のコメント',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_id` (`class_id`),
  KEY `provider_id` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2875 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'unregistered_user'
CREATE TABLE `unregistered_user` (
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザーID',
  `random_passwd` varchar(255) NOT NULL COMMENT 'ランダムに発行されたパスワード',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'unviewable_class'
CREATE TABLE `unviewable_class` (
  `unviewable_class_id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL,
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`unviewable_class_id`),
  UNIQUE KEY `class_id` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user'
CREATE TABLE `user` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `open_id` varchar(255) DEFAULT NULL COMMENT 'facebook ID, twitter IDなどの外部サービスにおける固有ID',
  `flg_open_id` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'facebook ID, twitter IDなどの外部サービスにおける固有ID 識別flg facebook:0',
  `name` varchar(255) NOT NULL COMMENT '氏名',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性別　0:男性 1:女性 9:初期値',
  `mail` varchar(255) DEFAULT NULL COMMENT 'メールアドレス',
  `flg_mail` tinyint(1) DEFAULT '9' COMMENT '0:通知禁止, [1, 4, 6, 9]:授業通知可能,[3, 4, 8, 9]:お知らせ可能, [5, 6, 8, 9]:受けたいリマインド通知',
  `mail_status` varchar(255) NOT NULL DEFAULT '11000' COMMENT 'メールステータス(4桁の0/1で表された数字) 1桁目:授業関連, 2桁目:サービス関連（キャンペーン、新機能追加など）, 3桁目:受けたいリマインド, 4桁目:グループ投稿へのコメント通知, 5目:グループ投稿へのいいね通知',
  `is_active_mail` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1:有効, 0:無効',
  `birthday` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '生年月日',
  `flg_birthday` tinyint(1) DEFAULT '1' COMMENT '0:非表示, 1:表示',
  `address` varchar(255) DEFAULT NULL COMMENT '住所',
  `company` varchar(255) DEFAULT NULL COMMENT '勤務先',
  `pic_url` varchar(255) DEFAULT NULL COMMENT 'プロフィール画像のurl. プロトコルいか全ての文字列',
  `pic_big` varchar(255) DEFAULT NULL COMMENT 'プロフィール写真、最も大きいサイズ',
  `introduce` text COMMENT '自己紹介',
  `will` text COMMENT '学びたいこと',
  `web_address` varchar(255) DEFAULT NULL COMMENT 'ホームページ',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` datetime NOT NULL COMMENT '更新日時',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:在籍, 1:退学済',
  `tw_token` varchar(255) DEFAULT NULL COMMENT 'twitterのaccess_token',
  `tw_token_secret` varchar(255) DEFAULT NULL COMMENT 'twitterのaccess_token_secret',
  `tw_user_id` varchar(255) DEFAULT NULL COMMENT 'twitterのuser_id',
  `tw_screen_name` varchar(255) DEFAULT NULL COMMENT 'twitterのscreen_name',
  `status` int(11) NOT NULL COMMENT '2:停学中',
  `is_public_profile` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'プロフィール公開フラグ',
  `is_public_history` int(1) NOT NULL DEFAULT '1' COMMENT '1:true 0:false',
  `flg_push` tinyint(1) NOT NULL DEFAULT '9' COMMENT '0:通知禁止 [1, 4, 6, 9]:授業通知可能(新着授業通知),[5, 6, 8, 9]:受けたいリマインド通知, [3, 4, 8, 9]:お知らせ可能(お知らせ)',
  `env` tinyint(4) DEFAULT NULL COMMENT '会員登録時のクライアント情報 0:web_pc / 1:web_iphone / 2:web_ipad / 3:web_android / 4:app_ios',
  `first_name` varchar(100) NOT NULL COMMENT 'ファーストネーム',
  `last_name` varchar(100) NOT NULL COMMENT 'ラストネーム',
  `faculty_id` int(32) unsigned DEFAULT NULL COMMENT 'null:学部未選択, 0:学部非所属を選択,n:選択した学部ID',
  `is_public_faculty` tinyint(1) NOT NULL DEFAULT '1' COMMENT '学部の公開設定 0:非公開 / 1:公開',
  `is_public_fb` tinyint(1) NOT NULL DEFAULT '1',
  `is_public_tw` tinyint(1) NOT NULL DEFAULT '1',
  `is_public_activity_group` tinyint(1) NOT NULL DEFAULT '1',
  `is_public_attend_fb` tinyint(1) NOT NULL DEFAULT '1',
  `is_public_attend_group` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `user` (`user_id`,`open_id`),
  UNIQUE KEY `mail` (`mail`),
  KEY `user_id` (`user_id`),
  KEY `fb_id` (`open_id`,`flg_delete`),
  KEY `id_faculty` (`faculty_id`,`is_public_faculty`,`flg_delete`),
  KEY `id_user` (`user_id`,`flg_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=307485 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_attributes'
CREATE TABLE `user_attributes` (
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `prefecture_id` tinyint(4) NOT NULL COMMENT '都道府県ID',
  `job_id` tinyint(4) NOT NULL COMMENT '職業ID',
  `job_category_id` tinyint(4) NOT NULL COMMENT '職種ID',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ユーザの分析用属性情報';

-- Create syntax for TABLE 'user_chapter'
CREATE TABLE `user_chapter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザーID',
  `chapter_id` int(11) NOT NULL COMMENT 'チャプターID',
  `flg_watch` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '実際に閲覧したかどうかのフラグ',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'ユーザーが手動で管理する受講完了ステータス',
  `flg_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '削除フラグ',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ユーザーごとの既読チャプター用テーブル';

-- Create syntax for TABLE 'user_contracts'
CREATE TABLE `user_contracts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT 'related `user.user_id`',
  `purchase_type_id` int(11) unsigned NOT NULL COMMENT 'related `purchase_types.id`',
  `start_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '契約開始日時',
  `end_at` datetime DEFAULT NULL COMMENT '契約終了日時',
  `flg_cancelled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '途中解約されているかどうか',
  `cancelled_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_contracts_01` (`user_id`,`flg_cancelled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='契約情報';

-- Create syntax for TABLE 'user_experiences'
CREATE TABLE `user_experiences` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `body` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'user_id_count'
CREATE TABLE `user_id_count` (
  `id_seq` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=20429073 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_id_seq'
CREATE TABLE `user_id_seq` (
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ユーザIDsequence';

-- Create syntax for TABLE 'user_info'
CREATE TABLE `user_info` (
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `mail` varchar(255) DEFAULT NULL COMMENT 'メールアドレス',
  `flg_mail` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0:配信しない, 1:配信する。',
  `company` varchar(255) DEFAULT NULL COMMENT '勤務先',
  `introduce` text COMMENT '自己紹介',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_confirmed_mail` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'メール認証済みフラグ\\n0:未 1:済',
  `flg_birthday` tinyint(1) NOT NULL DEFAULT '1' COMMENT '誕生日を公開するか',
  `flg_category` tinyint(1) NOT NULL DEFAULT '0' COMMENT '興味カテゴリー登録フラグ//0：未登録/1：登録済',
  `last_activity` datetime DEFAULT NULL COMMENT '最終ログイン日時',
  `ticket` int(32) unsigned NOT NULL DEFAULT '0' COMMENT 'チケット枚数',
  `tmp` varchar(255) DEFAULT NULL COMMENT 'tmp',
  `mail_update_date` datetime DEFAULT NULL COMMENT 'メールアドレス更新日時',
  PRIMARY KEY (`user_id`),
  KEY `last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ユーザ情報（更新性の高い情報）';

-- Create syntax for TABLE 'user_info_extra'
CREATE TABLE `user_info_extra` (
  `user_id` varchar(255) NOT NULL,
  `use_video_resume` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'ビデオ再生位置のレジューム機能を利用するか',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ユーザ情報拡張オプション';

-- Create syntax for TABLE 'user_interesting_job_categories'
CREATE TABLE `user_interesting_job_categories` (
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `interesting_job_category_id` tinyint(4) NOT NULL COMMENT '興味のある職種ID',
  `regist_date` datetime NOT NULL COMMENT '登録日時',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`interesting_job_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ユーザの分析用属性情報(興味のある職種)';

-- Create syntax for TABLE 'user_jobs'
CREATE TABLE `user_jobs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_dt` datetime DEFAULT NULL,
  `end_dt` datetime DEFAULT NULL,
  `current_status` tinyint(4) DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'user_life'
CREATE TABLE `user_life` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `country` varchar(100) DEFAULT NULL COMMENT '国',
  `state` varchar(100) DEFAULT NULL COMMENT '都道府県',
  `city` varchar(100) DEFAULT NULL COMMENT '市区町村',
  PRIMARY KEY (`id`),
  KEY `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_notice'
CREATE TABLE `user_notice` (
  `id` int(32) NOT NULL AUTO_INCREMENT COMMENT 'table index',
  `from_user_id` varchar(255) NOT NULL DEFAULT '00000000' COMMENT '送り手',
  `to_user_id` varchar(255) NOT NULL COMMENT '受け手',
  `type` enum('entry','ticket','report_comment','report_like','report_comment_like','group_post_comment','group_activity_comment','group_post_like','group_comment_like','group_activity_like') NOT NULL,
  `class_id` int(32) DEFAULT NULL COMMENT '授業ID',
  `group_feed_id` int(32) DEFAULT NULL COMMENT 'フィードID',
  `regist_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登録日',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`id`),
  KEY `to_user_id` (`to_user_id`,`regist_date`)
) ENGINE=InnoDB AUTO_INCREMENT=217677 DEFAULT CHARSET=utf8 COMMENT='ユーザー通知';

-- Create syntax for TABLE 'user_open_id'
CREATE TABLE `user_open_id` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `open_id` varchar(255) NOT NULL,
  `open_id_type` tinyint(4) NOT NULL COMMENT '1:yahoo, 2:facebook',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_open_id` (`user_id`,`open_id`),
  UNIQUE KEY `open_id` (`open_id`,`open_id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='userのopen_idを管理';

-- Create syntax for TABLE 'user_passwd'
CREATE TABLE `user_passwd` (
  `user_id` varchar(255) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  `regist_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_passwd_reset'
CREATE TABLE `user_passwd_reset` (
  `id` varchar(40) NOT NULL COMMENT '暗号',
  `user_id` varchar(255) NOT NULL,
  `expire` int(11) NOT NULL COMMENT '有効期限(unix time)',
  PRIMARY KEY (`id`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_phonenumber'
CREATE TABLE `user_phonenumber` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT 'related `user.user_id`',
  `phonenumber` varchar(16) NOT NULL COMMENT '電話番号を示す文字列',
  `flg_callable_times` int(10) NOT NULL DEFAULT '0' COMMENT '電話可能な時間帯情報をビット演算で管理する値',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_phonenumber_01` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='ユーザーの電話番号情報';

-- Create syntax for TABLE 'user_purchased_histories'
CREATE TABLE `user_purchased_histories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT 'related `user.user_id`',
  `purchase_type_id` int(11) unsigned NOT NULL COMMENT 'related `purchase_types.id`',
  `price` int(11) NOT NULL COMMENT '購入価格',
  `contract_start_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '契約開始日時',
  `contract_end_at` datetime DEFAULT NULL COMMENT '契約終了日時',
  `transaction_id` int(11) unsigned NOT NULL COMMENT 'related `user_transactions.id`',
  `flg_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '削除されているかどうか',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_purchased_histories_01` (`flg_deleted`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='購入情報';

-- Create syntax for TABLE 'user_skills'
CREATE TABLE `user_skills` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `year` smallint(6) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create syntax for TABLE 'user_suspend'
CREATE TABLE `user_suspend` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `class_id` int(11) DEFAULT '0' COMMENT '停学になった際の授業ID （あれば）',
  `social_stream_id` int(32) NOT NULL DEFAULT '0' COMMENT 'BANされたsocial_stream_id（あれば）',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `admin_user_id` varchar(255) NOT NULL COMMENT 'BANしたuser_id',
  `type` int(1) NOT NULL DEFAULT '0' COMMENT '1:アカウントBAN, 2:授業BAN, 3:投稿BAN',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0:通常 1:BANされている',
  `comment` text COMMENT 'BANした理由',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `class_id` (`class_id`),
  KEY `social_stream_id` (`social_stream_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_token'
CREATE TABLE `user_token` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '学籍番号',
  `token` varchar(255) NOT NULL COMMENT 'トークン',
  `type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '0: refresh_token',
  `flg_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:有効, 1:無効',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`,`type`),
  KEY `user_id` (`user_id`),
  KEY `token_2` (`token`),
  KEY `token_3` (`token`,`type`,`flg_delete`)
) ENGINE=InnoDB AUTO_INCREMENT=21755 DEFAULT CHARSET=utf8 COMMENT='ユーザトークン(gRPC用)';

-- Create syntax for TABLE 'user_transactions'
CREATE TABLE `user_transactions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT 'related `user.user_id`',
  `order_id` varchar(32) NOT NULL COMMENT 'オーダーID',
  `settlement_means_id` int(10) unsigned NOT NULL COMMENT '支払区分 / related `purchase_settlement_means.id`',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: 未登録, 1: 登録済, 2: 実行済, 9: 異常',
  `access_id` varchar(32) DEFAULT NULL COMMENT '取引ID',
  `access_pass` varchar(32) DEFAULT NULL COMMENT '取引パスワード',
  `created_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_transactions_01` (`order_id`),
  KEY `idx_user_transactions_01` (`status`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='取引情報';

-- Create syntax for TABLE 'user_viewed_class_notification'
CREATE TABLE `user_viewed_class_notification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '授業を視聴したユーザーID',
  `class_id` int(32) NOT NULL COMMENT '視聴した授業ID',
  `course_tag_parent_id` int(32) unsigned NOT NULL COMMENT '視聴した授業の親カテゴリー',
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_id_class_id` (`user_id`,`class_id`),
  KEY `idx_course_tag_parent_id_updated_at` (`course_tag_parent_id`,`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='アクテビティを表示する用のテーブル';

-- Create syntax for TABLE 'view_history'
CREATE TABLE `view_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(32) NOT NULL,
  `regist_date` datetime NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` varchar(8) NOT NULL,
  `type` int(1) NOT NULL COMMENT '0:通常 1:プレミアム',
  `env` int(2) DEFAULT NULL COMMENT '端末種別',
  `is_ticket` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'チケット受講判定 0:チケット未使用 ,1:チケット使用',
  `exit_time` datetime DEFAULT NULL COMMENT '退出日時',
  PRIMARY KEY (`id`),
  KEY `class` (`class_id`,`user_id`,`type`,`regist_date`),
  KEY `user` (`user_id`,`type`,`regist_date`),
  KEY `regist_date` (`regist_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'wallet'
CREATE TABLE `wallet` (
  `user_id` varchar(8) NOT NULL,
  `id` varchar(50) NOT NULL COMMENT '\\''wallet_id\\''  eddcf84b42e0d3ea598a7410bca9204925c041b5',
  `cc_num` varchar(45) NOT NULL,
  `cc_ym` varchar(4) NOT NULL COMMENT '\\''YYMM o埋め\\''',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '\\''0:無効 1:正常 9:異常\\''',
  `seq` int(3) NOT NULL COMMENT 'GMO側の連番を格納',
  `flg_delete` int(11) DEFAULT '0',
  `cc_name` varchar(255) NOT NULL COMMENT 'カード名義人',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `expire` (`cc_ym`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'watch_list'
CREATE TABLE `watch_list` (
  `class_id` int(32) NOT NULL COMMENT '授業ID',
  `user_id` varchar(8) NOT NULL COMMENT 'ユーザID',
  `type` int(11) NOT NULL COMMENT '0:登録 1:見た',
  `env` int(2) DEFAULT NULL COMMENT '受けたいを最後に押したときのクライアント情報 0:web_pc / 1:web_iphone / 2:web_ipad / 3:web_android / 4:app_ios(sukunama)',
  `regist_date` datetime NOT NULL COMMENT '登録日',
  `update_date` datetime NOT NULL COMMENT '更新日',
  `flg_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`class_id`,`user_id`,`type`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ウォッチリスト';

-- Create syntax for TABLE 'watch_list_course'
CREATE TABLE `watch_list_course` (
  `course_id` int(32) unsigned NOT NULL COMMENT 'コースID',
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザID',
  `list_id` varchar(255) NOT NULL COMMENT 'リストID(UUID)',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0:登録 1:見た',
  `env` int(2) DEFAULT NULL COMMENT '0:WebPC, 1:WebIPhone, 2:WebIPad, 3:WebAndroid, 4:AppIPhone, 5:AppIPad, 6:AppAndroid',
  `flg_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:有効, 1:無効',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`course_id`,`user_id`,`list_id`),
  KEY `user_id` (`user_id`),
  KEY `user_id_list_id` (`user_id`,`list_id`),
  KEY `user_id_list_id_regist_date` (`user_id`,`list_id`,`regist_date`),
  KEY `user_id_list_id_update_date` (`user_id`,`list_id`,`update_date`),
  KEY `flg_delete_update_date` (`flg_delete`,`update_date`),
  KEY `flg_delete_type` (`flg_delete`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='コースお気に入りリスト';

-- Create syntax for TABLE 'watch_list_course_backup'
CREATE TABLE `watch_list_course_backup` (
  `course_id` int(32) unsigned NOT NULL COMMENT 'コースID',
  `user_id` varchar(255) NOT NULL COMMENT 'ユーザID',
  `list_id` varchar(255) NOT NULL COMMENT 'リストID(UUID)',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0:登録 1:見た',
  `env` int(2) DEFAULT NULL COMMENT '0:WebPC, 1:WebIPhone, 2:WebIPad, 3:WebAndroid, 4:AppIPhone, 5:AppIPad, 6:AppAndroid',
  `flg_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:有効, 1:無効',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '作成日時(他テーブルに合わせる)',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時(他テーブルに合わせる)',
  PRIMARY KEY (`course_id`,`user_id`,`list_id`),
  KEY `user_id` (`user_id`),
  KEY `user_id_list_id` (`user_id`,`list_id`),
  KEY `user_id_list_id_regist_date` (`user_id`,`list_id`,`regist_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='コースお気に入りリスト';

-- Create syntax for TABLE 'word_blacklist'
CREATE TABLE `word_blacklist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'グループID',
  `word` varchar(24) NOT NULL COMMENT '禁止ワード',
  `note` varchar(255) NOT NULL COMMENT '備考',
  `regist_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `word` (`word`),
  KEY `group_word` (`group`,`word`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8 COMMENT='禁止ワードリスト';