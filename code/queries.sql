-- Создать таблицу student с полями student_id serial, first_name varchar,
-- last_name varchar, birthday date, phone varchar
create table student (
    student_id serial,
    first_name varchar(60),
    last_name varchar(60),
    birthday date,
    phone varchar(60)
);

-- Добавить в таблицу после создания колонку middle_name varchar
alter table student add column middle_name varchar(60);

-- Удалить колонку middle_name
alter table student drop column middle_name;

-- Переименовать колонку birthday в birth_date
alter table student rename birthday to birth_date;

-- Изменить тип данных колонки phone на varchar(32)
alter table student alter column phone set data type varchar(32);

-- Вставить три любых записи с автогенерацией идентификатора
insert into student (first_name, last_name, birth_date, phone)
values ('aa', 'bb', '1111-01-01', 'ffff'), ('cc', 'dd', '4111-01-01', 'yyyy'), ('kk', 'ii', '5022-01-01', 'ii');

-- Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
truncate table student restart identity

-- добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
alter table products add constraint ch_unit_price check (unit_price > 0);

-- добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
alter table products add constraint ch_discontinued check (discontinued in (0, 1));

--  Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
select * into products_dis from products where (discontinued = 1);

-- Удалить из products товары, снятые с продажи (discontinued = 1)
alter table order_details DROP CONSTRAINT pk_order_details;
alter table order_details DROP CONSTRAINT fk_order_details_products;
alter table order_details alter COLUMN product_id drop not null;
alter table order_details add CONSTRAINT fk_order_details_products FOREIGN KEY (product_id)
        REFERENCES products (product_id) on delete set null;
DELETE FROM products where discontinued = 1;
