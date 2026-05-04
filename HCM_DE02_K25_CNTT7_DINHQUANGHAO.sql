create database librarymanagement;
use librarymanagement;

create table book (
    book_id varchar(10) primary key,
    title varchar(255),
    author varchar(100),
    year_publish int,
    quantity int
);

create table reader (
    reader_id varchar(10) primary key,
    name varchar(100),
    email varchar(100) unique,
    phone varchar(20),
    dob date
);

create table borrow_card (
    card_id varchar(10) primary key,
    borrow_date date,
    return_date date,
    reader_id varchar(10),
    foreign key (reader_id) references reader(reader_id)
);

create table borrow_detail (
    card_id varchar(10),
    book_id varchar(10),
    status varchar(10),
    fee decimal(10,2),
    primary key (card_id, book_id),
    foreign key (card_id) references borrow_card(card_id),
    foreign key (book_id) references book(book_id)
);

alter table reader
add address varchar(255);

alter table book
change year_publish nam_phat_hanh int;

drop table borrow_detail;
drop table borrow_card;

insert into book values
('b001', 'lập trình sql căn bản', 'nguyễn văn a', 2020, 10),
('b002', 'dế mèn phiêu lưu ký', 'tô hoài', 2018, 5),
('b003', 'mắt biếc', 'nguyễn nhật ánh', 2019, 7),
('b004', 'tuổi thơ dữ dội', 'phùng quán', 2015, 6),
('b005', 'tiếng gọi nơi hoang dã', 'jack london', 2017, 4);

insert into reader (reader_id, name, email, phone, dob, address) values
('r001', 'nguyễn văn hùng', 'hung@gmail.com', '0123', '2000-01-01', 'đắk lắk'),
('r002', 'trần thị mai', 'mai@gmail.com', '0456', '2001-02-02', 'hà nội'),
('r003', 'lê văn nam', null, '0789', '1999-03-03', 'hcm'),
('r004', 'phạm thị lan', 'lan@gmail.com', '0111', '2002-04-04', 'đà nẵng'),
('r005', 'hoàng anh', 'anh@gmail.com', '0222', '2003-05-05', 'huế');

insert into borrow_card values
('pm001', '2026-04-01', '2026-04-10', 'r001'),
('pm002', '2026-04-05', '2026-04-15', 'r002'),
('pm003', '2026-03-10', '2026-03-20', 'r001'),
('pm004', '2026-04-12', '2026-04-22', 'r004'),
('pm005', '2026-02-01', '2026-02-10', 'r005');

insert into borrow_detail values
('pm001', 'b001', 'mới', 5000),
('pm001', 'b005', 'cũ', 3000),
('pm002', 'b003', 'mới', 4000),
('pm003', 'b002', 'cũ', 2000),
('pm004', 'b005', 'mới', 6000);

update book
set quantity = quantity + 5
where author = 'nguyễn nhật ánh';

delete from reader
where email is null;

select *
from book
where nam_phat_hanh between 2015 and 2023;

select r.name, bc.card_id
from reader r
join borrow_card bc on r.reader_id = bc.reader_id
where month(bc.borrow_date) = 4
and year(bc.borrow_date) = 2026;

select b.title
from book b
join borrow_detail bd on b.book_id = bd.book_id
where bd.card_id = 'pm001';

select r.name, r.phone
from reader r
join borrow_card bc on r.reader_id = bc.reader_id
join borrow_detail bd on bc.card_id = bd.card_id
join book b on bd.book_id = b.book_id
where b.title = 'lập trình sql căn bản';

select bc.card_id, b.title, bd.status
from borrow_card bc
join borrow_detail bd on bc.card_id = bd.card_id
join book b on bd.book_id = b.book_id
where b.author = 'jack london';

