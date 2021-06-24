--주문상세 Table에 할인 칼럼 추가
alter table ord_dtl
    add (ord_dc NUMBER(5,2) default 0);
         
--'어린이 정통 삼국지' 20% 할인
update ord_dtl
set ord_dc = 20,
    ord_amt = ord_amt - (ord_amt * 20/100)
where bk_no = (select bk_no
                from book
                where bk_nm = '어린이 정통 삼국지');
commit;

--주문마스트 총금액 수정
select ord_no from ord_dtl where bk_no='1002000002';

update ord_mst
set tot_amt = (select sum(ord_amt) from ord_dtl where ord_no='2020000011')
where ord_no = '2020000011'; --건별 수정

update ord_mst
set tot_amt = (select sum(ord_amt) 
               from ord_dtl 
               where ord_no = ord_mst.ord_no)
where ord_no in (select ord_no from ord_dtl where bk_no='1002000002'); --전체 수정
commit;

--주문마스터 및 주문상세 데이터 정합성 검증
select ord_no, sum(m_cnt) mst_cnt, sum(m_amt) mst_amt, 
       sum(d_cnt) dtl_cnt, sum(d_amt) dtl_cnt,
       sum(m_cnt) - sum(d_cnt) diff_cnt,
       sum(m_amt) - sum(d_amt) diff_amt       
from (select ord_no, tot_cnt m_cnt, tot_amt m_amt, 0 d_cnt, 0 d_amt from ord_mst
      union
      select ord_no, 0, 0, sum(ord_cnt), sum(ord_amt) from ord_dtl group by ord_no)
group by ord_no;

select sum(m_cnt) mst_cnt, sum(m_amt) mst_amt, 
       sum(d_cnt) dtl_cnt, sum(d_amt) dtl_cnt,
       sum(m_cnt) - sum(d_cnt) diff_cnt,
       sum(m_amt) - sum(d_amt) diff_amt       
from (select ord_no, tot_cnt m_cnt, tot_amt m_amt, 0 d_cnt, 0 d_amt from ord_mst
      union
      select ord_no, 0, 0, sum(ord_cnt), sum(ord_amt) from ord_dtl group by ord_no);
