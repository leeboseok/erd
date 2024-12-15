DROP TABLE IF EXISTS `delivery_address`;

CREATE TABLE `delivery_address` (
	`delivery_addr_id`	BIGINT	NOT NULL,
	`user_id`	INT	NOT NULL,
	`delivery_address_title`	VARCHAR(20)	NULL,
	`recipient_name`	VARCHAR(20)	NULL,
	`recipient_phone`	VARCHAR(20)	NULL,
	`address`	VARCHAR(50)	NULL,
	`address_detail`	VARCHAR(50)	NULL,
	`zip_code`	VARCHAR(10)	NULL,
	`is_default_address`	VARCHAR(1)	NULL	DEFAULT N
);

DROP TABLE IF EXISTS `delivery_status_history`;

CREATE TABLE `delivery_status_history` (
	`delivery_status_history_id`	BIGINT	NOT NULL,
	`delivery_info_id`	BIGINT	NOT NULL,
	`prev_status_code`	VARCHAR(4)	NULL,
	`new_status_code`	VARCHAR(4)	NULL,
	`change_reason`	VARCHAR(200)	NULL,
	`change_time`	TIMESTAMP	NULL
);

DROP TABLE IF EXISTS `refund`;

CREATE TABLE `refund` (
	`refund_id`	BIGINT	NOT NULL,
	`payment_id`	BIGINT	NOT NULL,
	`return_id`	BIGINT	NOT NULL,
	`user_id`	VARCHAR(25)	NOT NULL,
	`refund_receipt_date`	TIMESTAMP	NULL	DEFAULT CURRENT_TIMESTAMP,
	`refund_completion_date`	TIMESTAMP	NULL	DEFAULT CURRENT_TIMESTAMP,
	`refund_amount`	INT	NULL,
	`refund_status`	VARCHAR(5)	NULL	COMMENT '진행중,완료',
	`refund_reason`	VARCHAR(5)	NULL	COMMENT '주문취소,반품취소',
	`refund_type`	VARCHAR(5)	NULL	COMMENT '부분환불,전체환불'
);

DROP TABLE IF EXISTS `delivery_fee_policy`;

CREATE TABLE `delivery_fee_policy` (
	`delivery_fee_policy_id`	BIGINT	NOT NULL,
	`min_price`	INT	NULL	DEFAULT 0	COMMENT '무료배송 조건',
	`base_fee`	INT	NULL	DEFAULT 0,
	`start_date`	DATE	NULL,
	`end_date`	DATE	NULL
);

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
	`order_id`	BIGINT	NOT NULL,
	`order_number`	VARCHAR(40)	NULL,
	`order_datetime`	TIMESTAMP	NULL,
	`total_product_amount`	INT	NULL	COMMENT '할인, 포인트적용 이전 금액',
	`total_delivery_fee`	INT	NULL,
	`total_point_discount`	INT	NULL,
	`total_product_discount`	INT	NULL,
	`total_payment_amount`	INT	NULL	COMMENT '할인, 포인트적용 이후 금액',
	`order_status`	VARCHAR(10)	NULL	COMMENT '결제대기, 결제완료'
);

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
	`payment_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`payment_method`	VARCHAR(10)	NULL	COMMENT '카드 ,휴대폰결제, 현금, 간편결제',
	`total_payment_amount`	INT	NULL,
	`payment_status`	VARCHAR(10)	NULL	COMMENT '결제 완료, 결제 취소',
	`payment_date`	TIMESTAMP	NULL
);

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
	`user_id`	INT	NOT NULL,
	`customer_rank_code`	INT	NOT NULL,
	`customer_rank_score`	INT	NULL,
	`rank_assessment_start_date`	VARCHAR(10)	NULL,
	`rank_assessment_deadline`	VARCHAR(10)	NULL,
	`rating_amount`	INT	NULL
);

DROP TABLE IF EXISTS `order_product`;

CREATE TABLE `order_product` (
	`order_product_id`	BIGINT	NOT NULL,
	`product_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`option_id`	INT	NOT NULL,
	`order_product_option`	VARCHAR(200)	NULL	COMMENT '브라/ 블랙/ 75A',
	`order_product_quantity`	INT	NULL	COMMENT '3',
	`total_order_amount`	SMALLINT	NULL	COMMENT '3*15000 = 4.5',
	`total_discount_amount`	INT	NULL	COMMENT '15000 -> 13000  = 2000*3',
	`order_product_status`	VARCHAR(40)	NULL	COMMENT '반품접수,  결제 취소, 주문취소결제, 완료 결제 대기'
);

DROP TABLE IF EXISTS `body`;

CREATE TABLE `body` (
	`user_id`	INT	NOT NULL,
	`height`	VARCHAR(5)	NULL,
	`weight`	VARCHAR(5)	NULL,
	`bra_size`	VARCHAR(10)	NULL,
	`panty_size`	VARCHAR(1)	NULL,
	`user_age`	INT	NOT NULL,
	`user_gender`	VARCHAR(5)	NOT NULL
);

DROP TABLE IF EXISTS `customer_rank`;

CREATE TABLE `customer_rank` (
	`customer_rank_code`	INT	NOT NULL,
	`rank_name`	VARCHAR(10)	NULL,
	`rank_score_criteria`	INT	NOT NULL,
	`discount_rate`	INT	NOT NULL,
	`accumulation_rate`	INT	NOT NULL,
	`rank_based_coupon`	INT	NOT NULL	COMMENT '등급별로 쿠폰이 여러개 일수가 있다',
	`rank_updated`	VARCHAR(8)	NULL
);

DROP TABLE IF EXISTS `item_price`;

CREATE TABLE `item_price` (
	`item_id`	BIGINT	NOT NULL,
	`unit_price`	INT	NOT NULL,
	`list_price`	INT	NOT NULL,
	`sales_price`	INT	NOT NULL,
	`rate`	INT	NOT NULL,
	`registration_date`	TIMESTAMP	NOT NULL,
	`registor_id`	VARCHAR(10)	NULL,
	`price_start`	TIMESTAMP	NULL,
	`price_end`	TIMESTAMP	NULL
);

DROP TABLE IF EXISTS `inventory_history`;

CREATE TABLE `inventory_history` (
	`price_history`	BIGINT	NOT NULL,
	`item_num`	BIGINT	NOT NULL,
	`before_unit_price`	INT	NULL,
	`before_list_price`	INT	NULL,
	`before_sales_price`	INT	NULL,
	`before_rate`	INT	NULL,
	`change_reason`	VARCHAR(255)	NULL,
	`registor_id`	VARCHAR(25)	NULL,
	`change_date`	TIMESTAMP	NULL,
	`up_change_date`	TIMESTAMP	NULL	COMMENT 'up = unit price',
	`lp_change_date`	TIMESTAMP	NULL	COMMENT 'lp = list price',
	`sp_change_date`	TIMESTAMP	NULL	COMMENT 'sp = sales price',
	`r_change_date`	TIMESTAMP	NULL	COMMENT 'r = rate'
);

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
	`user_id`	INT	NOT NULL,
	`employment_date`	VARCHAR(8)	NULL,
	`salary`	INT	NULL,
	`job_grade`	VARCHAR(5)	NULL
);

DROP TABLE IF EXISTS `item_review_comment`;

CREATE TABLE `item_review_comment` (
	`comment_id`	BIGINT	NOT NULL,
	`comment_id_p`	BIGINT	NOT NULL,
	`revie_num`	BIGINT	NOT NULL,
	`writer_id`	VARCHAR(20)	NULL,
	`content`	VARCHAR(255)	NULL,
	`write_date`	TIMESTAMP	NULL,
	`modify_date`	TIMESTAMP	NULL,
	`like_count`	INT	NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `product_review`;

CREATE TABLE `product_review` (
	`review_id`	BIGINT	NOT NULL,
	`item_id`	BIGINT	NOT NULL,
	`writer_id`	VARCHAR(25)	NOT NULL,
	`content`	VARCHAR(255)	NOT NULL,
	`keyword`	VARCHAR(100)	NOT NULL,
	`buy_method`	VARCHAR(100)	NULL	COMMENT '구매확정, 재구매, 할인구매, 이벤트구매',
	`poto_url`	VARCHAR(100)	NULL,
	`write_date`	TIMESTAMP	NULL,
	`modify_date`	TIMESTAMP	NULL,
	`like_count`	INT	NULL	DEFAULT 0,
	`image1`	VARCHAR(50)	NULL,
	`image2`	VARCHAR(50)	NULL,
	`image3`	VARCHAR(50)	NULL,
	`image4`	VARCHAR(50)	NULL
);

DROP TABLE IF EXISTS `delivery_info`;

CREATE TABLE `delivery_info` (
	`delivery_info_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`delivery_addr_id`	BIGINT	NOT NULL,
	`delivery_type`	VARCHAR(4)	NULL,
	`delivery_status`	VARCHAR(4)	NULL,
	`tracking_number`	VARCHAR(20)	NULL,
	`delivery_memo`	VARCHAR(50)	NULL,
	`create_date`	TIMESTAMP	NULL,
	`update_date`	TIMESTAMP	NULL,
	`delivery_completion_date`	VARCHAR(8)	NULL,
	`delivery_company_code`	VARCHAR(10)	NULL,
	`delivery_company_name`	VARCHAR(20)	NULL,
	`delivery_contact_number`	VARCHAR(20)	NULL,
	`delivery_url`	VARCHAR(100)	NULL
);

DROP TABLE IF EXISTS `system_code`;

CREATE TABLE `system_code` (
	`code_id`	BIGINT	NOT NULL,
	`code`	VARCHAR(4)	NULL,
	`code_name`	VARCHAR(20)	NULL,
	`code_type`	VARCHAR(10)	NULL,
	`code_type_name`	VARCHAR(20)	NULL,
	`code_order`	INT	NULL,
	`is_use_code`	VARCHAR(1)	NULL	DEFAULT Y,
	`note`	VARCHAR(100)	NULL
);

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
	`notification_number`	INT	NOT NULL,
	`user_id`	VARCHAR(25)	NOT NULL,
	`notification_content`	VARCHAR(500)	NULL,
	`notification_datetime`	TIMESTAMP	NULL,
	`notification_type`	VARCHAR(25)	NULL,
	`notification_status`	VARCHAR(10)	NULL
);

DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
	`permission_id`	INT	NOT NULL,
	`permission_name`	VARCHAR(25)	NOT NULL
);

DROP TABLE IF EXISTS `wishlist`;

CREATE TABLE `wishlist` (
	`wishlist_number`	INT	NOT NULL,
	`user_id`	VARCHAR(25)	NOT NULL,
	`item_id`	BIGINT	NOT NULL,
	`wishlist_choice_date`	VARCHAR(10)	NOT NULL
);

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
	`cart_id`	BIGINT	NOT NULL,
	`product_id`	BIGINT	NOT NULL,
	`user_id`	INT	NOT NULL,
	`option_id`	INT	NOT NULL	COMMENT '브라/65A/레드',
	`product_order_option`	VARCHAR(200)	NULL	COMMENT '사이즈/컬러',
	`quantity`	INT	NULL
);

DROP TABLE IF EXISTS `question`;

CREATE TABLE `question` (
	`question_id`	INT	NOT NULL,
	`user_id`	INT	NOT NULL,
	`question_type`	VARCHAR(25)	NOT NULL	COMMENT '배송관련 문의/주문관련 문의/ 이벤트 문의',
	`question_content`	VARCHAR(500)	NULL,
	`question_date`	VARCHAR(8)	NULL,
	`question_atch_file`	VARCHAR(255)	NULL,
	`inquiry_privacy_status`	VARCHAR(1)	NOT NULL	COMMENT '전체공개 / 비공개',
	`question_status`	VARCHAR(10)	NOT NULL	COMMENT '처리 완료/ 처리중'
);

DROP TABLE IF EXISTS `card_payment`;

CREATE TABLE `card_payment` (
	`card_payment_id`	VARCHAR(255)	NOT NULL,
	`vat`	INT	NULL,
	`card_number`	VARCHAR(30)	NULL,
	`card_name`	VARCHAR(30)	NULL,
	`Installment_type`	VARCHAR(30)	NULL,
	`approval_number`	VARCHAR(30)	NULL
);

DROP TABLE IF EXISTS `bank_payment`;

CREATE TABLE `bank_payment` (
	`bank_payment_id`	BIGINT	NOT NULL,
	`virtual_account_number`	BIGINT	NULL,
	`bank_name`	VARCHAR(20)	NULL,
	`depositor_name`	VARCHAR(50)	NULL
);

DROP TABLE IF EXISTS `point`;

CREATE TABLE `point` (
	`user_id`	INT	NOT NULL,
	`point_balance`	INT	NOT NULL,
	`total_earned_points`	INT	NOT NULL	COMMENT '지급, 회수 ,소멸',
	`total_used_points`	INT	NOT NULL	COMMENT '리뷰 작성, 상품구매,',
	`point_start_date`	VARCHAR(8)	NULL,
	`point_end_date`	VARCHAR(8)	NOT NULL,
	`point_last_update`	TIMESTAMP	NULL,
	`point_status`	VARCHAR(20)	NULL	COMMENT '유효, 만료'
);

DROP TABLE IF EXISTS `customer_record`;

CREATE TABLE `customer_record` (
	`customer_record_code`	INT	NOT NULL,
	`user_id`	INT	NOT NULL,
	`recent_order_date`	TIMESTAMP	NULL,
	`review_cnt`	INT	NULL
);

DROP TABLE IF EXISTS `order_cancle`;

CREATE TABLE `order_cancle` (
	`order_cancellation_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`cancellation_reason`	VARCHAR(50)	NULL,
	`cancellation_details`	VARCHAR(200)	NULL,
	`cancel_datetime`	TIMESTAMP	NULL
);

DROP TABLE IF EXISTS `admin_permission`;

CREATE TABLE `admin_permission` (
	`admikn_permission_id`	VARCHAR(255)	NOT NULL,
	`permission_id`	INT	NOT NULL,
	`user_id`	VARCHAR(25)	NOT NULL,
	`permission_expiry_date`	TIMESTAMP	NULL,
	`permission_grant_date`	TIMESTAMP	NULL
);

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
	`answer_id`	INT	NOT NULL,
	`question_id`	INT	NOT NULL,
	`user_id`	INT	NOT NULL,
	`comment_content`	VARCHAR(500)	NULL,
	`comment_date`	TIMESTAMP	NULL,
	`comment_atch_file`	VARCHAR(255)	NULL,
	`answer_status`	VARCHAR(10)	NOT NULL,
	`admin_id`	VARCHAR(25)	NULL,
	`answer_privacy_status`	VARCHAR(1)	NOT NULL
);

DROP TABLE IF EXISTS `delivery_additional_fee_policy`;

CREATE TABLE `delivery_additional_fee_policy` (
	`delivery_add_fee_policy_id`	BIGINT	NOT NULL,
	`company_code`	VARCHAR(10)	NULL,
	`additional_fee`	INT	NULL,
	`start_zip_code`	INT	NULL,
	`end_zip_code`	INT	NULL
);

DROP TABLE IF EXISTS `return_status`;

CREATE TABLE `return_status` (
	`return_status_id`	BIGINT	NOT NULL,
	`return_id`	BIGINT	NOT NULL,
	`status_change_date`	TIMESTAMP	NULL	DEFAULT CURRENT_TIMESTAMP,
	`prev_status_code`	VARCHAR(4)	NULL	COMMENT '수거중, 수거완료,수거실패',
	`new_status_code`	VARCHAR(4)	NULL,
	`return_status_memo`	VARCHAR(255)	NULL
);

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
	`item_id`	BIGINT	NOT NULL,
	`item_status_code`	INT	NOT NULL,
	`category_bottom_code`	INT	NOT NULL,
	`category_mid_code`	INT	NOT NULL,
	`category_top_code`	INT	NOT NULL,
	`item_name`	VARCHAR(100)	NULL,
	`wish_count`	INT	NULL	DEFAULT 0,
	`review`	INT	NULL	DEFAULT 0,
	`item_name_en`	VARCHAR(100)	NULL,
	`is_discount`	VARCHAR(1)	NULL	DEFAULT N	COMMENT 'N = NO / Y = YES',
	`item_description`	VARCHAR(255)	NULL,
	`item_fabric`	VARCHAR(255)	NULL,
	`item_tags`	VARCHAR(100)	NULL,
	`thumbnail`	VARCHAR(50)	NULL	COMMENT '썸네일, 메인',
	`image1`	VARCHAR(100)	NULL,
	`image2`	VARCHAR(100)	NULL,
	`image3`	VARCHAR(100)	NULL,
	`image4`	VARCHAR(100)	NULL,
	`is_option`	VARCHAR(1)	NULL	DEFAULT Y,
	`is_ad`	VARCHAR(1)	NULL	DEFAULT N,
	`sale_price`	VARCHAR(30)	NULL,
	`discount_price`	VARCHAR(30)	NULL,
	`is_adult`	VARCHAR(1)	NULL	DEFAULT N,
	`item_origin`	VARCHAR(20)	NULL,
	`item_manufacture`	VARCHAR(20)	NULL,
	`memo`	VARCHAR(255)	NULL	COMMENT '등록자 전용 상품 관리용 메모',
	`total_sales`	INT	NULL,
	`washing_method`	VARCHAR(100)	NULL,
	`is_delete_item`	VARCHAR(1)	NULL	DEFAULT N,
	`start_discount`	TIMESTAMP	NULL,
	`end_discount`	TIMESTAMP	NULL,
	`start_sale`	TIMESTAMP	NULL,
	`end_sale`	TIMESTAMP	NULL,
	`item_register_date`	TIMESTAMP	NULL,
	`is_delete_item_date`	TIMESTAMP	NULL,
	`registor_id`	VARCHAR(25)	NULL
);

DROP TABLE IF EXISTS `inventory_location_adjustment`;

CREATE TABLE `inventory_location_adjustment` (
	`inv_location_id`	VARCHAR(255)	NOT NULL	COMMENT 'inv = inventory',
	`inv_manage_code`	BIGINT	NOT NULL,
	`before_location`	VARCHAR(50)	NULL,
	`after_location`	VARCHAR(50)	NULL,
	`lo_change_reason`	VARCHAR(255)	NULL	COMMENT 'lo = location',
	`change_date`	TIMESTAMP	NULL,
	`admin_id`	VARCHAR(20)	NOT NULL
);

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`user_id`	INT	NOT NULL,
	`user_type`	VARCHAR(10)	NOT NULL	COMMENT '관리자, 구매자(고객)',
	`user_login_id`	VARCHAR(25)	NULL	COMMENT '일단 냅둬',
	`user_pw`	VARCHAR(30)	NOT NULL,
	`user_email`	VARCHAR(255)	NULL,
	`user_phone_number`	VARCHAR(20)	NULL,
	`user_gender`	VARCHAR(1)	NOT NULL,
	`user_age`	INT	NOT NULL,
	`user_profile_picture`	VARCHAR(255)	NULL,
	`user_email_verification`	VARCHAR(1)	NOT NULL,
	`user_phone_number_verification`	VARCHAR(1)	NOT NULL,
	`user_account_number`	INT	NULL,
	`user_bank_name`	VARCHAR(20)	NULL,
	`user_account_creation_date`	VARCHAR(8)	NOT NULL,
	`user_account_modification_date`	VARCHAR(8)	NULL,
	`last_login_time`	TIMESTAMP	NULL,
	`user_account_status`	VARCHAR(255)	NULL
);

DROP TABLE IF EXISTS `inventory`;

CREATE TABLE `inventory` (
	`inv_code`	BIGINT	NOT NULL,
	`item_id`	BIGINT	NOT NULL,
	`option_id`	INT	NOT NULL,
	`inv_status_code`	INT	NULL	COMMENT '입고완료, 입고대기,  재고확보, 재고부족,',
	`m_level_code`	INT	NULL	COMMENT 'm = management',
	`inv_qnt`	BIGINT	NULL	COMMENT 'qnt = quantity',
	`entrance_qnt`	INT	NULL,
	`shipment_qnt`	INT	NULL,
	`location_item`	VARCHAR(40)	NULL,
	`post_num`	VARCHAR(10)	NULL,
	`post_address`	VARCHAR(20)	NULL,
	`admin_id`	VARCHAR(20)	NULL,
	`is_supply`	VARCHAR(1)	NULL	DEFAULT Y,
	`manager_id`	VARCHAR(20)	NOT NULL,
	`is_inspected`	VARCHAR(1)	NULL	DEFAULT N,
	`inspected_date`	TIMESTAMP	NULL,
	`is_ready_shipment`	VARCHAR(20)	NULL,
	`is_special`	VARCHAR(1)	NULL	DEFAULT N,
	`min_count`	INT	NULL	DEFAULT 0,
	`max_count`	BIGINT	NULL,
	`entrance_date`	TIMESTAMP	NULL,
	`shipping_date`	TIMESTAMP	NULL
);

DROP TABLE IF EXISTS `product_inventory_grade`;

CREATE TABLE `product_inventory_grade` (
	`m_level_code`	INT	NOT NULL	COMMENT 'm = management',
	`m_level_name`	VARCHAR(5)	NULL	COMMENT '신상, 일반, 반품, 폐기대상',
	`m_level_explanation`	VARCHAR(30)	NULL
);

DROP TABLE IF EXISTS `option`;

CREATE TABLE `option` (
	`option_id`	INT	NOT NULL,
	`item_id`	BIGINT	NOT NULL,
	`color`	VARCHAR(15)	NOT NULL,
	`size`	VARCHAR(8)	NOT NULL	COMMENT '브라 : 컵/사이즈 팬티 : 사이즈',
	`option_type`	VARCHAR(20)	NOT NULL
);

DROP TABLE IF EXISTS `item_status`;

CREATE TABLE `item_status` (
	`item_status_code`	INT	NOT NULL,
	`status`	VARCHAT(10)	NULL,
	`explanation`	VARCHAT(80)	NULL
);

DROP TABLE IF EXISTS `inventory_status_code`;

CREATE TABLE `inventory_status_code` (
	`inv_status_code`	INT	NOT NULL,
	`status`	VARCHAR(10)	NULL,
	`explanation`	VARCHAR(80)	NULL
);

DROP TABLE IF EXISTS `return`;

CREATE TABLE `return` (
	`return_id`	BIGINT	NOT NULL,
	`order_product_id`	BIGINT	NOT NULL,
	`user_id`	VARCHAR(25)	NOT NULL,
	`return_reason_code`	VARCHAR(4)	NULL,
	`return_status_code`	VARCHAR(4)	NULL	COMMENT '반품접수,반품중,반품완료',
	`recovery_request`	VARCHAR(255)	NULL,
	`recovery_expected_day`	VARCHAR(8)	NULL,
	`refund_expected_amount`	INT	NULL,
	`return_reason`	VARCHAR(255)	NULL,
	`return_memo`	VARCHAR(255)	NULL,
	`return_receipt_date`	TIMESTAMP	NULL	DEFAULT CURRENT_TIMESTAMP,
	`return_completion_date`	TIMESTAMP	NULL	DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `category_top`;

CREATE TABLE `category_top` (
	`category_top_code`	INT	NOT NULL,
	`category_top_name`	VARCHAR(15)	NULL,
	`is_subcategory`	VARCHAR(1)	NULL,
	`is_supercategory`	VARCHAR(1)	NULL,
	`category_registration_date`	VARCHAR(8)	NULL,
	`category_deletion_date`	VARCHAR(8)	NULL
);

DROP TABLE IF EXISTS `category_mid`;

CREATE TABLE `category_mid` (
	`category_mid_code`	INT	NOT NULL,
	`category_top_code`	INT	NOT NULL,
	`category_mid_name`	VARCHAR(15)	NULL,
	`is_subcategory`	VARCHAR(1)	NULL,
	`is_supercategory`	VARCHAR(1)	NULL,
	`category_registration_date`	VARCHAR(8)	NULL,
	`category_deletion_date`	VARCHAR(8)	NULL
);

DROP TABLE IF EXISTS `category_bottom`;

CREATE TABLE `category_bottom` (
	`category_bottom_code`	INT	NOT NULL,
	`category_mid_code`	INT	NOT NULL,
	`category_top_code`	INT	NOT NULL,
	`category_bottom_name`	VARCHAR(15)	NULL,
	`is_subcategory`	VARCHAR(1)	NULL,
	`is_supercategory`	VARCHAR(1)	NULL,
	`category_registration_date`	VARCHAR(8)	NULL,
	`category_deletion_date`	VARCHAR(8)	NULL
);

DROP TABLE IF EXISTS `point_history`;

CREATE TABLE `point_history` (
	`point_history_id`	INT	NOT NULL,
	`user_id`	INT	NOT NULL,
	`payment_id`	BIGINT	NOT NULL	COMMENT '여러 포인트를 사용할 수 있음',
	`order_id`	BIGINT	NOT NULL	COMMENT '여러 종류의 포인트 적립 가능.',
	`point_change_amount`	INT	NULL	COMMENT '적립/사용(+/-)',
	`remain_point`	INT	NULL,
	`point_type`	VARCHAR((20)	NOT NULL	COMMENT '적립/사용/만료',
	`point_accrual_date`	TIMESTAMP	NULL
);

ALTER TABLE `delivery_address` ADD CONSTRAINT `PK_DELIVERY_ADDRESS` PRIMARY KEY (
	`delivery_addr_id`
);

ALTER TABLE `delivery_status_history` ADD CONSTRAINT `PK_DELIVERY_STATUS_HISTORY` PRIMARY KEY (
	`delivery_status_history_id`
);

ALTER TABLE `refund` ADD CONSTRAINT `PK_REFUND` PRIMARY KEY (
	`refund_id`
);

ALTER TABLE `delivery_fee_policy` ADD CONSTRAINT `PK_DELIVERY_FEE_POLICY` PRIMARY KEY (
	`delivery_fee_policy_id`
);

ALTER TABLE `order` ADD CONSTRAINT `PK_ORDER` PRIMARY KEY (
	`order_id`
);

ALTER TABLE `payment` ADD CONSTRAINT `PK_PAYMENT` PRIMARY KEY (
	`payment_id`
);

ALTER TABLE `customer` ADD CONSTRAINT `PK_CUSTOMER` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `order_product` ADD CONSTRAINT `PK_ORDER_PRODUCT` PRIMARY KEY (
	`order_product_id`
);

ALTER TABLE `body` ADD CONSTRAINT `PK_BODY` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `customer_rank` ADD CONSTRAINT `PK_CUSTOMER_RANK` PRIMARY KEY (
	`customer_rank_code`
);

ALTER TABLE `item_price` ADD CONSTRAINT `PK_ITEM_PRICE` PRIMARY KEY (
	`item_id`
);

ALTER TABLE `inventory_history` ADD CONSTRAINT `PK_INVENTORY_HISTORY` PRIMARY KEY (
	`price_history`
);

ALTER TABLE `admin` ADD CONSTRAINT `PK_ADMIN` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `item_review_comment` ADD CONSTRAINT `PK_ITEM_REVIEW_COMMENT` PRIMARY KEY (
	`comment_id`
);

ALTER TABLE `product_review` ADD CONSTRAINT `PK_PRODUCT_REVIEW` PRIMARY KEY (
	`review_id`
);

ALTER TABLE `delivery_info` ADD CONSTRAINT `PK_DELIVERY_INFO` PRIMARY KEY (
	`delivery_info_id`
);

ALTER TABLE `system_code` ADD CONSTRAINT `PK_SYSTEM_CODE` PRIMARY KEY (
	`code_id`
);

ALTER TABLE `notification` ADD CONSTRAINT `PK_NOTIFICATION` PRIMARY KEY (
	`notification_number`
);

ALTER TABLE `permission` ADD CONSTRAINT `PK_PERMISSION` PRIMARY KEY (
	`permission_id`
);

ALTER TABLE `wishlist` ADD CONSTRAINT `PK_WISHLIST` PRIMARY KEY (
	`wishlist_number`
);

ALTER TABLE `cart` ADD CONSTRAINT `PK_CART` PRIMARY KEY (
	`cart_id`
);

ALTER TABLE `question` ADD CONSTRAINT `PK_QUESTION` PRIMARY KEY (
	`question_id`
);

ALTER TABLE `card_payment` ADD CONSTRAINT `PK_CARD_PAYMENT` PRIMARY KEY (
	`card_payment_id`
);

ALTER TABLE `bank_payment` ADD CONSTRAINT `PK_BANK_PAYMENT` PRIMARY KEY (
	`bank_payment_id`
);

ALTER TABLE `point` ADD CONSTRAINT `PK_POINT` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `customer_record` ADD CONSTRAINT `PK_CUSTOMER_RECORD` PRIMARY KEY (
	`customer_record_code`
);

ALTER TABLE `order_cancle` ADD CONSTRAINT `PK_ORDER_CANCLE` PRIMARY KEY (
	`order_cancellation_id`
);

ALTER TABLE `admin_permission` ADD CONSTRAINT `PK_ADMIN_PERMISSION` PRIMARY KEY (
	`admikn_permission_id`
);

ALTER TABLE `comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (
	`answer_id`
);

ALTER TABLE `delivery_additional_fee_policy` ADD CONSTRAINT `PK_DELIVERY_ADDITIONAL_FEE_POLICY` PRIMARY KEY (
	`delivery_add_fee_policy_id`
);

ALTER TABLE `return_status` ADD CONSTRAINT `PK_RETURN_STATUS` PRIMARY KEY (
	`return_status_id`
);

ALTER TABLE `item` ADD CONSTRAINT `PK_ITEM` PRIMARY KEY (
	`item_id`
);

ALTER TABLE `inventory_location_adjustment` ADD CONSTRAINT `PK_INVENTORY_LOCATION_ADJUSTMENT` PRIMARY KEY (
	`inv_location_id`
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `inventory` ADD CONSTRAINT `PK_INVENTORY` PRIMARY KEY (
	`inv_code`
);

ALTER TABLE `product_inventory_grade` ADD CONSTRAINT `PK_PRODUCT_INVENTORY_GRADE` PRIMARY KEY (
	`m_level_code`
);

ALTER TABLE `option` ADD CONSTRAINT `PK_OPTION` PRIMARY KEY (
	`option_id`
);

ALTER TABLE `item_status` ADD CONSTRAINT `PK_ITEM_STATUS` PRIMARY KEY (
	`item_status_code`
);

ALTER TABLE `inventory_status_code` ADD CONSTRAINT `PK_INVENTORY_STATUS_CODE` PRIMARY KEY (
	`inv_status_code`
);

ALTER TABLE `return` ADD CONSTRAINT `PK_RETURN` PRIMARY KEY (
	`return_id`
);

ALTER TABLE `category_top` ADD CONSTRAINT `PK_CATEGORY_TOP` PRIMARY KEY (
	`category_top_code`
);

ALTER TABLE `category_mid` ADD CONSTRAINT `PK_CATEGORY_MID` PRIMARY KEY (
	`category_mid_code`,
	`category_top_code`
);

ALTER TABLE `category_bottom` ADD CONSTRAINT `PK_CATEGORY_BOTTOM` PRIMARY KEY (
	`category_bottom_code`,
	`category_mid_code`,
	`category_top_code`
);

ALTER TABLE `point_history` ADD CONSTRAINT `PK_POINT_HISTORY` PRIMARY KEY (
	`point_history_id`
);

ALTER TABLE `delivery_address` ADD CONSTRAINT `FK_user_TO_delivery_address_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `delivery_status_history` ADD CONSTRAINT `FK_delivery_info_TO_delivery_status_history_1` FOREIGN KEY (
	`delivery_info_id`
)
REFERENCES `delivery_info` (
	`delivery_info_id`
);

ALTER TABLE `refund` ADD CONSTRAINT `FK_payment_TO_refund_1` FOREIGN KEY (
	`payment_id`
)
REFERENCES `payment` (
	`payment_id`
);

ALTER TABLE `refund` ADD CONSTRAINT `FK_return_TO_refund_1` FOREIGN KEY (
	`return_id`
)
REFERENCES `return` (
	`return_id`
);

ALTER TABLE `payment` ADD CONSTRAINT `FK_order_TO_payment_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `customer` ADD CONSTRAINT `FK_user_TO_customer_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `customer` ADD CONSTRAINT `FK_customer_rank_TO_customer_1` FOREIGN KEY (
	`customer_rank_code`
)
REFERENCES `customer_rank` (
	`customer_rank_code`
);

ALTER TABLE `order_product` ADD CONSTRAINT `FK_item_TO_order_product_1` FOREIGN KEY (
	`product_id`
)
REFERENCES `item` (
	`item_id`
);

ALTER TABLE `order_product` ADD CONSTRAINT `FK_order_TO_order_product_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `order_product` ADD CONSTRAINT `FK_option_TO_order_product_1` FOREIGN KEY (
	`option_id`
)
REFERENCES `option` (
	`option_id`
);

ALTER TABLE `body` ADD CONSTRAINT `FK_user_TO_body_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `item_price` ADD CONSTRAINT `FK_item_TO_item_price_1` FOREIGN KEY (
	`item_id`
)
REFERENCES `item` (
	`item_id`
);

ALTER TABLE `inventory_history` ADD CONSTRAINT `FK_item_price_TO_inventory_history_1` FOREIGN KEY (
	`item_num`
)
REFERENCES `item_price` (
	`item_id`
);

ALTER TABLE `admin` ADD CONSTRAINT `FK_user_TO_admin_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `item_review_comment` ADD CONSTRAINT `FK_item_review_comment_TO_item_review_comment_1` FOREIGN KEY (
	`comment_id_p`
)
REFERENCES `item_review_comment` (
	`comment_id`
);

ALTER TABLE `item_review_comment` ADD CONSTRAINT `FK_product_review_TO_item_review_comment_1` FOREIGN KEY (
	`revie_num`
)
REFERENCES `product_review` (
	`review_id`
);

ALTER TABLE `product_review` ADD CONSTRAINT `FK_item_TO_product_review_1` FOREIGN KEY (
	`item_id`
)
REFERENCES `item` (
	`item_id`
);

ALTER TABLE `delivery_info` ADD CONSTRAINT `FK_order_TO_delivery_info_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `delivery_info` ADD CONSTRAINT `FK_delivery_address_TO_delivery_info_1` FOREIGN KEY (
	`delivery_addr_id`
)
REFERENCES `delivery_address` (
	`delivery_addr_id`
);

ALTER TABLE `notification` ADD CONSTRAINT `FK_user_TO_notification_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `wishlist` ADD CONSTRAINT `FK_user_TO_wishlist_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `wishlist` ADD CONSTRAINT `FK_item_TO_wishlist_1` FOREIGN KEY (
	`item_id`
)
REFERENCES `item` (
	`item_id`
);

ALTER TABLE `cart` ADD CONSTRAINT `FK_item_TO_cart_1` FOREIGN KEY (
	`product_id`
)
REFERENCES `item` (
	`item_id`
);

ALTER TABLE `cart` ADD CONSTRAINT `FK_user_TO_cart_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `cart` ADD CONSTRAINT `FK_option_TO_cart_1` FOREIGN KEY (
	`option_id`
)
REFERENCES `option` (
	`option_id`
);

ALTER TABLE `question` ADD CONSTRAINT `FK_user_TO_question_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `card_payment` ADD CONSTRAINT `FK_payment_TO_card_payment_1` FOREIGN KEY (
	`card_payment_id`
)
REFERENCES `payment` (
	`payment_id`
);

ALTER TABLE `bank_payment` ADD CONSTRAINT `FK_payment_TO_bank_payment_1` FOREIGN KEY (
	`bank_payment_id`
)
REFERENCES `payment` (
	`payment_id`
);

ALTER TABLE `point` ADD CONSTRAINT `FK_customer_TO_point_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `customer` (
	`user_id`
);

ALTER TABLE `customer_record` ADD CONSTRAINT `FK_customer_TO_customer_record_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `customer` (
	`user_id`
);

ALTER TABLE `order_cancle` ADD CONSTRAINT `FK_order_TO_order_cancle_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `admin_permission` ADD CONSTRAINT `FK_permission_TO_admin_permission_1` FOREIGN KEY (
	`permission_id`
)
REFERENCES `permission` (
	`permission_id`
);

ALTER TABLE `admin_permission` ADD CONSTRAINT `FK_admin_TO_admin_permission_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `admin` (
	`user_id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_question_TO_comment_1` FOREIGN KEY (
	`question_id`
)
REFERENCES `question` (
	`question_id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_admin_TO_comment_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `admin` (
	`user_id`
);

ALTER TABLE `return_status` ADD CONSTRAINT `FK_return_TO_return_status_1` FOREIGN KEY (
	`return_id`
)
REFERENCES `return` (
	`return_id`
);

ALTER TABLE `item` ADD CONSTRAINT `FK_item_status_TO_item_1` FOREIGN KEY (
	`item_status_code`
)
REFERENCES `item_status` (
	`item_status_code`
);

ALTER TABLE `item` ADD CONSTRAINT `FK_category_bottom_TO_item_1` FOREIGN KEY (
	`category_bottom_code`
)
REFERENCES `category_bottom` (
	`category_bottom_code`
);

ALTER TABLE `item` ADD CONSTRAINT `FK_category_bottom_TO_item_2` FOREIGN KEY (
	`category_mid_code`
)
REFERENCES `category_bottom` (
	`category_mid_code`
);

ALTER TABLE `item` ADD CONSTRAINT `FK_category_bottom_TO_item_3` FOREIGN KEY (
	`category_top_code`
)
REFERENCES `category_bottom` (
	`category_top_code`
);

ALTER TABLE `inventory_location_adjustment` ADD CONSTRAINT `FK_inventory_TO_inventory_location_adjustment_1` FOREIGN KEY (
	`inv_manage_code`
)
REFERENCES `inventory` (
	`inv_code`
);

ALTER TABLE `inventory` ADD CONSTRAINT `FK_item_TO_inventory_1` FOREIGN KEY (
	`item_id`
)
REFERENCES `item` (
	`item_id`
);

ALTER TABLE `inventory` ADD CONSTRAINT `FK_option_TO_inventory_1` FOREIGN KEY (
	`option_id`
)
REFERENCES `option` (
	`option_id`
);

ALTER TABLE `inventory` ADD CONSTRAINT `FK_inventory_status_code_TO_inventory_1` FOREIGN KEY (
	`inv_status_code`
)
REFERENCES `inventory_status_code` (
	`inv_status_code`
);

ALTER TABLE `inventory` ADD CONSTRAINT `FK_product_inventory_grade_TO_inventory_1` FOREIGN KEY (
	`m_level_code`
)
REFERENCES `product_inventory_grade` (
	`m_level_code`
);

ALTER TABLE `option` ADD CONSTRAINT `FK_item_TO_option_1` FOREIGN KEY (
	`item_id`
)
REFERENCES `item` (
	`item_id`
);

ALTER TABLE `return` ADD CONSTRAINT `FK_order_product_TO_return_1` FOREIGN KEY (
	`order_product_id`
)
REFERENCES `order_product` (
	`order_product_id`
);

ALTER TABLE `category_mid` ADD CONSTRAINT `FK_category_top_TO_category_mid_1` FOREIGN KEY (
	`category_top_code`
)
REFERENCES `category_top` (
	`category_top_code`
);

ALTER TABLE `category_bottom` ADD CONSTRAINT `FK_category_mid_TO_category_bottom_1` FOREIGN KEY (
	`category_mid_code`
)
REFERENCES `category_mid` (
	`category_mid_code`
);

ALTER TABLE `category_bottom` ADD CONSTRAINT `FK_category_mid_TO_category_bottom_2` FOREIGN KEY (
	`category_top_code`
)
REFERENCES `category_mid` (
	`category_top_code`
);

ALTER TABLE `point_history` ADD CONSTRAINT `FK_customer_TO_point_history_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `customer` (
	`user_id`
);

ALTER TABLE `point_history` ADD CONSTRAINT `FK_payment_TO_point_history_1` FOREIGN KEY (
	`payment_id`
)
REFERENCES `payment` (
	`payment_id`
);

ALTER TABLE `point_history` ADD CONSTRAINT `FK_order_TO_point_history_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

