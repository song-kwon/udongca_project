--create user id:udongca/pwd:master  ( sqlplus sysdba --
create user udongca identified by master; --유저 생성
grant all privileges to udongca; --모든 권한 주기
		SELECT
				cafeNo cafeNo,
				cafeName cafeName,
				cafeFakeImage cafeFakeImage,
				cafeAddress cafeAddress
		FROM PRboard
		where ceil(rownum) <![CDATA[ < ]]> 10
		ORDER BY (cafeRating/cafereviewcount) DESC
		
		SELECT myInquiryNo,inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId
		FROM(SELECT CEIL(rownum/9) page, myInquiryNo,inquiryNo, inquiryType, inquiryTitle, inquiryContent, inquiryReply, memberId
			     FROM(SELECT ceil(rownum) myInquiryNo,inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId
					     FROM onetoone_inquiry  where memberId = 123123 order by myInquiryNo desc ,  inquiryNo desc
					     )
				 )
		WHERE page = 1
		

		delete from review_board where reviewNo = 6
		
--리뷰 등록시 홍보글 cafeRating 업데이트
update prboard set cafeRating=(select cafeRating from prboard where cafeNo=1)+(select ratingStars from review_board where reviewNo = 9),cafeReviewCount=(select cafeReviewCount from prboard where cafeNo=1)+1 where cafeNo= 1;

--리뷰, 공지 최근 10건
select * from (select * from review_BOARD order by reviewdate desc) where ceil(rownum) <= 10 
select * from (select * from notice_BOARD order by noticedate desc) where ceil(rownum) <= 10

--추천 순 카페 9건
select * from REVIEW_BOARD where 

--내 즐찾 카페 번호 & 이미지
SELECT b.cafeNo , p.cafeFakeImage FROM bookmark b, prboard p WHERE b.memberId = 'scott' and b.cafeNo=p.cafeNo

--내 선호지역 카페
select * from preferlocation where memberId='scott'

select middle.*,major.* ,p.*
from  MAJORCATEGORY major, MIDDLECATEGORY middle, (select * from PREFERLOCATION where memberId='scott') p
where middle.major_categoryNo = major.major_categoryNO 
and p.address1=middle.middle_categoryNo

--notioce new top 10
SELECT noticeNo, noticeTitle, noticeContent, category, noticeDate FROM notice_board    WHERE ceil(rownum)   <  11 order by noticedate

--review new top 10
	select * 
		from review_board
		where ceil(rownum) < 11 order by reviewDate desc;
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

SELECT
			cafeNo cafeNo,
			cafeName cafeName,
			cafeFakeImage cafeFakeImage
		FROM (
			SELECT
				CEIL(rownum/3) page,
				cafeNo,
				cafeName,
				cafeFeature,
				cafeAddress,
				cafeFakeImage
			FROM (
				SELECT
					cafeNo,
					cafeName,
					cafeFeature,
					cafeAddress,
					cafeFakeImage
				FROM PRboard WHere cafeAddress LIKE '%서울시 강남구%'
				ORDER BY cafeNo DESC
				)
			)
		WHERE page = 1 
--  create table --
delete from code where codeType='login_possibility'
create table code(
codeId	varchar2(30)	primary key,
codeName	varchar2(50)	NOT NULL,
codeType	varchar2(50)	NOT NULL
);

insert into code values('notice1', '홍보글', 'notice_type');
insert into code values('notice2', '리뷰', 'notice_type');
insert into code values('notice3', '신고', 'notice_type');
insert into code values('notice4', '댓글', 'notice_type');
insert into code values('notice5', '사업자회원', 'notice_type');
insert into code values('notice6', '일반회원', 'notice_type');
insert into code values('inquiry1', '홍보글', 'inquiry_type');
insert into code values('inquiry2', '리뷰', 'inquiry_type');
insert into code values('inquiry3', '신고', 'inquiry_type');
insert into code values('inquiry4', '댓글', 'inquiry_type');
insert into code values('inquiry5', '사업자회원', 'inquiry_type');
insert into code values('inquiry6', '일반회원', 'inquiry_type');
insert into code values('cafeTheme1', '디저트', 'cafe_theme');
insert into code values('cafeTheme2', '북', 'cafe_theme');
insert into code values('cafeTheme3', '강아지', 'cafe_theme');
insert into code values('cafeTheme4', '고양이', 'cafe_theme');
insert into code values('cafeTheme5', '키즈', 'cafe_theme');
insert into code values('cafeTheme6', '기타', 'cafe_theme');
insert into code values('cafeMenu1', 'Coffee', 'cafe_menu');
insert into code values('cafeMenu2', 'Beverage', 'cafe_menu');
insert into code values('cafeMenu3', 'Frappuccino', 'cafe_menu');
insert into code values('cafeMenu4', 'Dessert', 'cafe_menu');
insert into code values('cafeMenu5', 'Bakery', 'cafe_menu');
insert into code values('cafeMenu6', 'etc.', 'cafe_menu');
insert into code values('possible','로그인허용','login_possibility');
insert into code values('impossible','로그인불가','login_possibility');
insert into code values('all','all','reportBoard');
insert into code values('review','review','reportBoard');
insert into code values('prboard','prboard','reportBoard');
SELECT inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId
		FROM(SELECT CEIL(rownum/100) page, inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId
			     FROM(SELECT inquiryNo, inquiryTitle, inquiryType, inquiryContent, inquiryReply, memberId
					     FROM onetoone_inquiry WHERE inquiryReply is null order by inquiryNo desc
					     )
				 )
		WHERE page = 1


create table notice_board(
noticeNo	NUMBER	primary key,
noticeTitle	varchar2(150)	NOT NULL,
noticeContent	CLOB	NOT NULL,
category varchar2(50) NOT NULL,
noticeDate	DATE	NOT NULL
);
update member set memberPenalty=1, loginpossibility='false' where memberId='cust1'

insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST1','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST2','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST3','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST4','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST5','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST6','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST7','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST8','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST9','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST10','내용없어요','notice1',sysdate);
insert into notice_board values(notice_board_noticeNo_seq.nextval,'TEST11','내용없어요','notice1',sysdate);



create table member(
memberId	varchar2(50)	primary key,
memberName	varchar2(50)	NOT NULL,
memberPassword	varchar2(50)	NOT NULL,
memberEmail	varchar2(100) not null,
memberPenalty	NUMBER	,
loginpossibility	varchar2(50)	NOT NULL,
memberType	varchar2(50)	NOT NULL
);

insert into member values('udongca','udongca','master','master@udongca.com','0','possible','master');
insert into member values('scott','scott','tiger','osung212@naver.com','0','possible','generalMember');
insert into member values('test1','test1','test1','a@a.com','0','possible','licenseeMember');
insert into member values('test2','test2','test2','b@b.com','0','possible','licenseeMember');
insert into member values('test3','test3','test3','c@c.com','0','possible','licenseeMember');
insert into member values('test4','test4','test4','d@d.com','0','possible','licenseeMember');
insert into member values('test5','test5','test5','e@d.com','0','possible','licenseeMember');
insert into member values('test6','test6','test6','f@d.com','0','possible','licenseeMember');
insert into member values('test7','test7','test7','g@d.com','0','possible','licenseeMember');



create table onetoone_inquiry(
inquiryNo	NUMBER	primary key,
inquiryTitle	varchar2(150)	NOT NULL,
inquiryType	varchar2(50)	NOT NULL,
inquiryContent	CLOB	NOT NULL,
inquiryReply	CLOB,	
memberId	varchar2(50)	NOT NULL,
constraint onetoone_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade
);


insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST1','TEST1','TEST1','TEST1','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST2','TEST2','TEST2','TEST2','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST3','TEST3','TEST3','TEST3','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST4','TEST4','TEST4','TEST4','test2');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST5','TEST5','TEST5','TEST5','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST6','TEST6','TEST6','TEST6','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST7','TEST7','TEST7','TEST7','scott');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST8','TEST8','TEST8','TEST8','test1');
insert into onetoone_inquiry values(onetoone_inquiry_inquiryNo_seq.nextval,'TEST9','TEST9','TEST9','TEST9','scott');

drop table PRboard
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
cafeRating number null,
cafeRealImage	CLOB	NULL,
cafeFakeImage	CLOB	NULL,
cafeReviewCount number,
RegistrationDate date not null,
memberId	varchar2(50)	NOT NULL,
constraint prboard_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade
);
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1','TEST1',0,0,sysdate,'test1');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2','TEST2',0,0,sysdate,'test2');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3','TEST3',0,0,sysdate,'test3');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4','TEST4',0,0,sysdate,'test4');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST5','TEST5','TEST5','TEST5','TEST5','TEST5','TEST5','TEST5','TEST5','TEST5','TEST5',0,0,sysdate,'test5');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST6','TEST6','TEST6','TEST6','TEST6','TEST6','TEST6','TEST6','TEST6','TEST6','TEST6',0,0,sysdate,'test6');
insert into PRboard values(PRboard_cafeNo_seq.nextval,'TEST7','TEST7','TEST7','TEST7','TEST7','TEST7','TEST7','TEST7','TEST7','TEST7','TEST7',0,0,sysdate,'test7');


create table review_board(
reviewNo 	NUMBER	primary key,
reviewTitle	varchar2(50)	NOT NULL,
reviewDate	DATE	NOT NULL,
reviewContent	CLOB	NOT NULL,
reviewRealImage CLOB,
reviewfakeImage CLOB,
ratingStars number,
memberId	varchar2(50)	NOT NULL,
cafeNo	NUMBER	NOT NULL,
constraint review_board_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade,
constraint review_cafeNo_fk
foreign key (cafeNo)
references PRboard(cafeNo) on delete cascade
);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST1',sysdate,'TEST1',1,'TEST1','TEST1',1,'scott',2);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST2',sysdate,'TEST2',1,'TEST2','TEST2',1,'scott',3);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST3',sysdate,'TEST3',1,'TEST3','TEST3',1,'test1',4);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST4',sysdate,'TEST4',1,'TEST4','TEST4',1,'scott',5);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST5',sysdate,'TEST5',1,'TEST1','TEST5',1,'test3',6);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST6',sysdate,'TEST6',1,'TEST2','TEST6',1,'scott',7);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST7',sysdate,'TEST7',1,'TEST3','TEST7',1,'scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST8',sysdate,'TEST8',1,'TEST4','TEST8',1,'test2',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST1',sysdate,'TEST1','TEST1','TEST1',1,'scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST2',sysdate,'TEST2','TEST2','TEST2',1,'scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST3',sysdate,'TEST3','TEST3','TEST3',1,'test1',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST4',sysdate,'TEST4','TEST4','TEST4',1,'scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST5',sysdate,'TEST5','TEST1','TEST5',1,'test3',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST6',sysdate,'TEST6','TEST2','TEST6',1,'scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST7',sysdate,'TEST7','TEST3','TEST7',1,'scott',1);
insert into review_board values(review_board_reviewNo_seq.nextval,'TEST8',sysdate,'TEST8','TEST4','TEST8',1,'test2',1);



create table report_board(
reportboardNo	NUMBER	primary key,
reportMemberId	varchar2(50)	NOT NULL,
reportReason	varchar2(100)	NOT NULL,
reportContent	CLOB	NULL,
reportResult	CLOB	NULL,
reportCancelReason	CLOB	NULL,
reportType	VARCHAR2(50)	NOT NULL,
reportNO 	NUMBER	NOT NULL,
memberId	varchar2(50)	NOT NULL,
constraint report_memberId_fk
foreign key (memberId)
references member(memberId) on delete cascade
);

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


insert into menu values(menu_menuNo_seq.nextval,1,'drink','아메리카노','/udongca_project/udongca-image/book-stack.png','fake');
insert into menu values(menu_menuNo_seq.nextval,1,'drink','아메리카노','/udongca_project/udongca-image/book-stack.png','fake');
insert into menu values(menu_menuNo_seq.nextval,1,'drink','아메리카노','/udongca_project/udongca-image/book-stack.png','fake');
insert into menu values(menu_menuNo_seq.nextval,1,'drink','아메리카노','/udongca_project/udongca-image/book-stack.png','fake');	
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
delete from PRboard where cafeNo=2
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
replyGroup NUMBER not null,
parentReply	NUMBER	NULL,
targetName	varchar2(50)	NULL,
reviewNO	NUMBER not null,
constraint review_reply_reviewNo_fk
foreign key (reviewNo)
references review_board(reviewNo) on delete cascade
);

insert into review_reply values(review_reply_replyNo_seq.nextval,'scott','test1',sysdate,1,0,'',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'udongca','test2',sysdate,2,0,'',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'udongca','test3',sysdate,3,0,'',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'scott','test4',sysdate,1,1,'scott',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'udongca','test5',sysdate,1,4,'scott',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'scott','test6',sysdate,1,4,'scott',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'scott','test7',sysdate,3,3,'udongca',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'scott','test8',sysdate,3,7,'scott',1);
insert into review_reply values(review_reply_replyNo_seq.nextval,'scott','test9',sysdate,2,2,'udongca',1);



create table bookmark(
memberId	varchar2(50) not null,
cafeNo	NUMBER,
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

