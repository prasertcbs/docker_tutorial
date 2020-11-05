create database demo;
use demo;
create table menu(id int, descr varchar(50), price int);
insert into menu values
    (1, 'mocha', 40),
    (2, 'latte', 50),
    (3, 'ชามะนาว', 30),
    (4, 'ชาเขียว', 60);
select * from menu;