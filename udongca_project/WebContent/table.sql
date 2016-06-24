--create user id:udongca/pwd:master  ( sqlplus sysdba --
create user udongca identified by master; --유저 생성
grant all privileges to udongca; --모든 권한 주기

-- create sequence --
insert into member values ('id','name','pwd','email',0,'possible','generalMember')
delete  from member where memberid='id'

create sequence notice_board_noticeNo_seq nocache;
create sequence onetoone_inquiry_inquiryNo_seq nocache;
create sequence PRboard_cafeNo_seq nocache;
create sequence review_board_reviewNo_seq nocache;
create sequence report_board_reportboardNo_seq nocache;
create sequence menu_menuNo_seq nocache;
create sequence review_reply_replyNo_seq nocache;
create sequence preferLocationNo_seq nocache;

--  create table --
insert into code values('login_true','로그인허용','login_possibility')
insert into code values('login_false','로그인불가','login_possibility')
create table code(
codeId	varchar2(30)	primary key,
codeName	varchar2(50)	NOT NULL,
codeType	varchar2(50)	NOT NULL
);

create table notice_board(
noticeNo	NUMBER	primary key,
noticeTitle	varchar2(50)	NOT NULL,
noticeContent	CLOB	NOT NULL,
noticeDate	DATE	NOT NULL
);
update member set memberPenalty=1, loginpossibility='false' where memberId='cust1'
insert into member values('cust1','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust2','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust3','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust4','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust5','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust6','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust7','asdf','cust1','sjung7674','0','false','cust')
create table member(
memberId	varchar2(50)	primary key,
memberName	varchar2(50)	NOT NULL,
memberPassword	varchar2(50)	NOT NULL,
memberEmail	varchar2(100),
memberPenalty	NUMBER	,
loginpossibility	varchar2(50)	NOT NULL,
memberType	varchar2(50)	NOT NULL
);

insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'테스트','테스트','테스트','테스트','master')
create table onetoone_inquiry(
inquiryNo	NUMBER	primary key,
inquiryTitle	varchar2(50)	NOT NULL,
inquiryType	varchar2(50)	NOT NULL,
inquiryContent	CLOB	NOT NULL,
inquiryReply	CLOB,	
memberId	varchar2(50)	NOT NULL,
constraint onetoone_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade
);
insert into PRBOARD values(1,'text','text','text','text','text','text','text','text','text','text','text','cust11')
SELECT inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId from onetoone_inquiry
create table PRboard(
cafeNo	NUMBER	primary key,
cafeName	varchar2(50)	NOT NULL,
cafeIntro	CLOB	NOT NULL,
cafeTel	varchar2(50)	NOT NULL,
cafeFeature	varchar2(50),
cafeAddress	varchar2(50)	NOT NULL,
coporateNumb	varchar2(50)	NOT NULL,
operationHour	varchar2(50)	NOT NULL,
managerName	varchar2(50)	NOT NULL,
managerTel	varchar2(50)	NOT NULL,
cafeRealImage	CLOB	NULL,
cafeFakeImage	CLOB	NULL,
memberId	varchar2(50)	NOT NULL,
constraint prboard_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade
);
insert into REVIEW_BOARD values(1,'text','2010-03-09','text',5,'text','text','cust12',1)
create table review_board(
reviewNo 	NUMBER	primary key,
reviewTitle	varchar2(50)	NOT NULL,
reviewDate	DATE	NOT NULL,
reviewContent	CLOB	NOT NULL,
reviewGrade	NUMBER	NOT NULL,
reviewRealImage CLOB,
reviewfakeImage CLOB,
memberId	varchar2(50)	NOT NULL,
cafeNo	NUMBER	NOT NULL,
constraint review_board_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade,
constraint review_cafeNo_fk
foreign key (cafeNo)
references PRboard(cafeNo) on delete cascade
);
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust11','reason','content','result','cancelre','prboard',1,'cust12')
insert into report_board values()
create table report_board(
reportboardNo	NUMBER	primary key,
reportMemberId	varchar2(50)	NOT NULL,
reportReason	varchar2(50)	NOT NULL,
reportContent	CLOB	NULL,
reportResult	varchar2(50)	NOT NULL,
reportCancelReason	CLOB	NULL,
reportType	VARCHAR2(50)	NOT NULL,
reportNO 	NUMBER	NOT NULL,
memberId	varchar2(50)	NOT NULL,
constraint report_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade
);
DELETE FROM review_board1 WHERE reviewNo = 1
create table menu(
menuNo	NUMBER	primary key,
cafeNo	NUMBER	NOT NULL,
menuType	varchar2(50)	NOT NULL,
menuName	varchar2(50)	NOT NULL,
menuRealImage	 CLOB	NULL,
menuFakeImage	CLOB	NULL,
constraint menu_cafeNo_fk
foreign key (cafeNo)
references PRboard(cafeNo) on delete cascade
);

create table preferLocation(
preferLocationNo	NUMBER	primary key,
address1	number default 0,
address2	number default 0,
address3	number default 0,
memberId	varchar2(50)	NOT NULL,
constraint preferLocation_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade
);

create table review_reply(
replyNo	NUMBER	primary key,
replyId	varchar2(50)	NOT NULL,
replyContent	CLOB	NOT NULL,
replyDate	DATE	NOT NULL,
parentReply	NUMBER	NULL,
targetName	varchar2(50)	NULL,
reviewNO	NUMBER	NOT NULL,
constraint review_reply_reviewNo_fk
foreign key (reviewNo)
references review_board(reviewNo) on delete set null
);
-- drop table --
drop table review_reply;
drop table preferLocation;
drop table menu;
drop table report_board;
drop table review_board;
drop table code;
drop table notice_board;
drop table onetoone_inquiry;
drop table PRboard;
drop table member;

-- drop sequence--

drop sequence notice_board_noticeNo_seq ;
drop sequence onetoone_inquiry_inquiryNo_seq ;
drop sequence PRboard_cafeNo_seq nocache;
drop sequence review_board_reviewNo_seq ;
drop sequence report_board_reportboardNo_seq ;
drop sequence menu_menuNo_seq ;
drop sequence review_reply_replyNo_seq ;
drop sequence preferLocationNo_seq;

-- address table --
create table majorcategory(
major_CategoryNo number primary key,
address1 varchar(40)
);

create table middlecategory(
middle_CategoryNo number primary key,
address2 varchar(40),
major_CategoryNo number,
constraint middle_No_fk_majorNo
foreign key (major_CategoryNo)
references majorcategory(major_CategoryNo)
);

-- category drop --

drop table middlecategory;
drop table majorcategory;

