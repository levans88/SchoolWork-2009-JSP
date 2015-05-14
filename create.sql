create table customer(customer_id int(5) not null primary key, first_name char(50) not null, last_name char(50) not null, age int(5), sales_amount decimal(6,2));         
insert into customer values (101, 'John', 'Smith', 35, 100.0);
insert into customer values (102, 'Judy', 'Miller', 30, 150.0);
insert into customer values (103, 'Mike', 'Taylor', 29, 224.8);
insert into customer values (104, 'Neil', 'Armstrong', 25, 200.0);
insert into customer values (105, 'Jennifer', 'Summers', 25, 50.0);


create table address(customer_id int(5) not null primary key, street char(50) not null, city char(25) not null, state char(2) not null, zip int(5));          
insert into address values (101, '1234 Main St', 'Atlanta', 'GA', 10000);
insert into address values (102, '2000 Miller Ave', 'Boston', 'MA', 20000);
insert into address values (103, '5000 North Dr', 'Chicago', 'IL', 30000);


create table user (user_id int(5) not null, customer_id int(5) not null, username char(20) not null, password char(20) not null, primary key (user_id));
insert into user (user_id, customer_id, username, password) values (1, 101, 'jsmith', 'bluesky');
insert into user (user_id, customer_id, username, password) values (2, 102, 'jmiller', 'clearwater');
insert into user (user_id, customer_id, username, password) values (3, 103, 'mtaylor', 'greentree');


create table order_submitted (order_id int(5) not null, user_id int(5) not null, submit_date datetime not null, primary key (order_id));


create table order_detail (order_detail_id int(5) not null, order_id int(5) not null, item_id int(5) not null, item_qty int(5) not null, primary key (order_detail_id));


create table item (item_id int(5) not null, item_name char(20) not null, item_price decimal(6,2) not null, primary key (item_id));
insert into item (item_id, item_name, item_price) values (101, 'Pen', 2.00);
insert into item (item_id, item_name, item_price) values (102, 'Pencil', 1.00);
insert into item (item_id, item_name, item_price) values (103, 'Eraser', 0.50);