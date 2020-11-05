create database demo;
use demo;
create table menu(id int, descr nvarchar(50), price int);
insert into menu values
    (1, 'mocha', 40),
    (2, 'latte', 50),
    (3, N'ชามะนาว', 30),
    (4, N'ชาเขียว', 60);
select * from menu;