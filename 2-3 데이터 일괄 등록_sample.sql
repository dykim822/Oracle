--�� ������ �Է�
INSERT INTO CUST(CUST_NO,CUST_NM,ZIPCD,RDNM_ADDR,DTL_ADDR)
    VALUES('2021000001','�輭��','13561','��⵵ ������ �д籸 ������ 6 (���ڵ�, NAVER�׸����丮)','1-1');

--����ȣ ������ ����
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
           '������','50570','��󳲵� ���� ����15�� 24-1 (������, ���̹�)','1-2');

--���ǻ� ������ �Է�
INSERT INTO PBCM(PBCM_CD,PBCM_NM,CHPR_NM,CHPR_TELNO)
    VALUES('1001','�ð���','�����','01012345678');

--���� ������ �Է�
INSERT INTO BOOK(BK_NO,BK_NM,BK_UPRC,PBCM_CD)
    VALUES('1001000001','������ �ɴ� ��',13500,'1001');
INSERT INTO BOOK(BK_NO,BK_NM,BK_UPRC,PBCM_CD)
    VALUES('1001000002','�� ������ ����å',19800,'1001');

--�ֹ���ȣ ������ ��ü ����


--�ֹ������� �� �ֹ��� ������ �Է�
INSERT INTO ORD_MST(ORD_NO,CUST_NO,ORD_DT,TOT_CNT,TOT_AMT)
    VALUES(?, '2020000001','20191101',0,0);
INSERT INTO ORD_DTL(ORD_NO,BK_NO,ORD_CNT,ORD_UPRC,ORD_AMT)
    VALUES(?, '1001000001',1,0,0);
INSERT INTO ORD_DTL(ORD_NO,BK_NO,ORD_CNT,ORD_UPRC,ORD_AMT)
    VALUES(?, '1001000002',1,0,0);
