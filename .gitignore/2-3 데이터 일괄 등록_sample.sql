--고객 데이터 입력
INSERT INTO CUST(CUST_NO,CUST_NM,ZIPCD,RDNM_ADDR,DTL_ADDR)
    VALUES('2021000001','김서준','13561','경기도 성남시 분당구 불정로 6 (정자동, NAVER그린팩토리)','1-1');

--고객번호 시퀀스 생성
create sequence cust_no_seq
    start with 1
    increment by 1
    maxvalue 999999;

--select cust_no_seq.nextval from dual;
--select cust_no_seq.currval from dual;
select to_char(sysdate, 'YYYY')||lpad(cust_no_seq.nextval, 6, '0') from dual;
select to_char(sysdate, 'YYYY')||lpad(cust_no_seq.currval, 6, '0') from dual;

INSERT INTO CUST(CUST_NO,CUST_NM,ZIPCD,RDNM_ADDR,DTL_ADDR)
    VALUES(to_char(sysdate, 'YYYY')||lpad(cust_no_seq.nextval, 6, '0'),
           '이하준','50570','경상남도 양산시 북정15길 24-1 (북정동, 네이버)','1-2');

--출판사 데이터 입력
INSERT INTO PBCM(PBCM_CD,PBCM_NM,CHPR_NM,CHPR_TELNO)
    VALUES('1001','시공사','김시준','01012345678');

--도서 데이터 입력
INSERT INTO BOOK(BK_NO,BK_NM,BK_UPRC,PBCM_CD)
    VALUES('1001000001','마음에 심는 꽃',13500,'1001');
INSERT INTO BOOK(BK_NO,BK_NM,BK_UPRC,PBCM_CD)
    VALUES('1001000002','더 위험한 과학책',19800,'1001');

--주문번호 시퀀스 객체 생성


--주문마스터 및 주문상세 데이터 입력
INSERT INTO ORD_MST(ORD_NO,CUST_NO,ORD_DT,TOT_CNT,TOT_AMT)
    VALUES(?, '2020000001','20191101',0,0);
INSERT INTO ORD_DTL(ORD_NO,BK_NO,ORD_CNT,ORD_UPRC,ORD_AMT)
    VALUES(?, '1001000001',1,0,0);
INSERT INTO ORD_DTL(ORD_NO,BK_NO,ORD_CNT,ORD_UPRC,ORD_AMT)
    VALUES(?, '1001000002',1,0,0);
