CREATE DATABASE /*!32312 IF NOT EXISTS*/`mydb` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

use mydb;

create table product(
id int AUTO_INCREMENT PRIMARY KEY,
name varchar(20),
description varchar(100),
price decimal(8,3) 
);

create table coupon(
id int AUTO_INCREMENT PRIMARY KEY,
code varchar(20) UNIQUE,
discount decimal(8,3),
exp_date varchar(100) 
);