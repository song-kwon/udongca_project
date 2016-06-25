--create user id:udongca/pwd:master  ( sqlplus sysdba --
create user udongca identified by master; --유저 생성
grant all privileges to udongca; --모든 권한 주기

		SELECT ceil(rownum) no, memberId, cafeNo , cafeName
		FROM (SELECT CEIL(rownum/#{itemPerPage}) page, ceil(rownum) no, memberId,cafeNo,cafeName
			FROM(SELECT ceil(rownum) no, b.memberId, b.cafeNo, p.cafeName
				FROM bookmark b , prboard p where b.memberId =  #{memberId} and p.cafeNo = b.cafeNo order by no asc
					)
				) 
		WHERE page =  1
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
insert into code values('possible','로그인허용','login_possibility');
insert into code values('impossible','로그인불가','login_possibility')
delete from code where codeType='login_possibility'
create table code(
codeId	varchar2(30)	primary key,
codeName	varchar2(50)	NOT NULL,
codeType	varchar2(50)	NOT NULL
);

insert into code values('notice1', '홍보글', 'noticeType');
insert into code values('notice2', '리뷰', 'noticeType');
insert into code values('notice3', '신고', 'noticeType');
insert into code values('notice4', '댓글', 'noticeType');
insert into code values('notice5', '사업자회원', 'noticeType');
insert into code values('notice6', '일반회원', 'noticeType');
insert into code values('inquiry1', '홍보글', 'inquiryType');
insert into code values('inquiry2', '리뷰', 'inquiryType');
insert into code values('inquiry3', '신고', 'inquiryType');
insert into code values('inquiry4', '댓글', 'inquiryType');
insert into code values('inquiry5', '사업자회원', 'inquiryType');
insert into code values('inquiry6', '일반회원', 'inquiryType');
insert into code values('cafeTheme1', '디저트', 'cafeTheme');
insert into code values('cafeTheme2', '북', 'cafeTheme');
insert into code values('cafeTheme3', '강아지', 'cafeTheme');
insert into code values('cafeTheme4', '고양이', 'cafeTheme');
insert into code values('cafeTheme5', '키즈', 'cafeTheme');
insert into code values('cafeTheme6', '기타', 'cafeTheme');
insert into code values('cafeMenu1', 'Coffee', 'cafeMenu');
insert into code values('cafeMenu2', 'Beverage', 'cafeMenu');
insert into code values('cafeMenu3', 'Frappuccino', 'cafeMenu');
insert into code values('cafeMenu4', 'Dessert', 'cafeMenu');
insert into code values('cafeMenu5', 'Bakery', 'cafeMenu');
insert into code values('cafeMenu6', 'etc.', 'cafeMenu');
insert into code values('loginP', 'loginP', 'login');
insert into code values('loginIP', 'loginIP', 'login');






create table notice_board(
noticeNo	NUMBER	primary key,
noticeTitle	varchar2(50)	NOT NULL,
noticeContent	CLOB	NOT NULL,
category varchar2(50) NOT NULL,
noticeDate	DATE	NOT NULL
);
update member set memberPenalty=1, loginpossibility='false' where memberId='cust1'

insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST1','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST2','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST3','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST4','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST5','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST6','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST7','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST8','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST9','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST10','내용없어요',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST11','내용없어요',sysdate);


>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git
insert into member values('cust1','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust2','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust3','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust4','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust5','asdf','cust1','sjung7674','0','true','cust')
insert into member values('cust6','asdf','cust1','sjung7674','0','true','cust')
<<<<<<< HEAD
insert into member values('cust7','asdf','cust1','sjung7674','0','false','cust')
=======
>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git

>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git
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

insert into member values('udongca','udongca','master','master@udongca.com','0','possible','master');
insert into member values('scott','scott','tiger','osung212@naver.com','0','possible','generalmember');
insert into member values('test1','test1','test1','a@a.com','0','possible','licenseemember');
insert into member values('test2','test2','test2','b@b.com','0','possible','generalmember');
insert into member values('test3','test3','test3','c@c.com','0','possible','generalmember');
insert into member values('test4','test4','test4','d@d.com','0','possible','generalmember');
insert into member values('test5','test5','test5','e@d.com','0','possible','licenseemember');
insert into member values('test6','test6','test6','f@d.com','0','possible','licenseemember');
insert into member values('test7','test7','test7','g@d.com','0','possible','licenseemember');



>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git
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
<<<<<<< HEAD
insert into PRBOARD values(1,'text','text','text','text','text','text','text','text','text','text','text','cust11')
SELECT inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId from onetoone_inquiry
=======
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST1','TEST1','TEST1','TEST1','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST2','TEST2','TEST2','TEST2','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST3','TEST3','TEST3','TEST3','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST4','TEST4','TEST4','TEST4','test2');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST5','TEST5','TEST5','TEST5','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST6','TEST6','TEST6','TEST6','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST7','TEST7','TEST7','TEST7','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST8','TEST8','TEST8','TEST8','test1');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST9','TEST9','TEST9','TEST9','scott');

SELECT inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId from onetoone_inquiry;


>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git
create table PRboard(
cafeNo	NUMBER	primary key,
cafeName	varchar2(50)	NOT NULL,
cafeIntro	CLOB	NOT NULL,
cafeTel	varchar2(50)	NOT NULL,
cafeFeature	varchar2(50),
cafeAddress	varchar2(50)	NOT NULL,
coporateNumber	varchar2(50)	NOT NULL,
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
<<<<<<< HEAD
insert into REVIEW_BOARD values(1,'text','2010-03-09','text',5,'text','text','cust12',1)
=======
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','test1');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','test5');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','test6');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','test7');

>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git
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
<<<<<<< HEAD
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust11','reason','content','result','cancelre','prboard',1,'cust12')
insert into report_board values()
=======
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST1',sysdate,'TEST1',1,'TEST1','TEST1','scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST2',sysdate,'TEST2',1,'TEST2','TEST2','scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST3',sysdate,'TEST3',1,'TEST3','TEST3','test1',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST4',sysdate,'TEST4',1,'TEST4','TEST4','scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST5',sysdate,'TEST5',1,'TEST1','TEST5','test3',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST6',sysdate,'TEST6',1,'TEST2','TEST6','scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST7',sysdate,'TEST7',1,'TEST3','TEST7','scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST8',sysdate,'TEST8',1,'TEST4','TEST8','test2',1);



>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git
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
<<<<<<< HEAD
DELETE FROM review_board1 WHERE reviewNo = 1
=======

insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'test1');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'test2');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'test4');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');
insert into REPORT_BOARD values(report_board_reportboardNo_seq.nextval,'cust','reason','content','result','cancelre','prboard',1,'scott');



>>>>>>> branch 'master' of https://github.com/song-kwon/udongca_project.git
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

create table bookmark(
memberId	varchar2(50) not null,
cafeNo	NUMBER not null,
constraint bookmark_fk_memberId
foreign key (memberId)
references member(memberId) on delete set null,
constraint bookmark_fk_PRboard
foreign key (cafeNo)
references prboard(cafeNo) on delete set null
);

insert into bookmark values('scott',1);
insert into bookmark values('scott',2);
insert into bookmark values('scott',3);
insert into bookmark values('scott',4);
insert into bookmark values('test1',1);
insert into bookmark values('test1',2);
insert into bookmark values('test1',3);
insert into bookmark values('test1',4);


-- drop table --
drop table bookmark;
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
drop sequence PRboard_cafeNo_seq;
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

