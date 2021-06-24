--출판사별 주문 현황
select p.pbcm_nm, b.bk_nm, sum(d.ord_cnt) tcnt, sum(d.ord_amt) tamt
from pbcm p, book b, ord_dtl d
where p.pbcm_cd = b.pbcm_cd
and b.bk_no = d.bk_no
group by p.pbcm_nm, b.bk_nm
order by 1, 3 desc;

--'19년 도서 주문순위 현황
select bk_no, bk_nm, tcnt
from (select b.bk_no, b.bk_nm, sum(d.ord_cnt) tcnt
      from book b, ord_dtl d, ord_mst m
      where b.bk_no = d.bk_no
      and d.ord_no = m.ord_no
      and substr(ord_dt,1,4) = '2019'
      group by b.bk_no, b.bk_nm
      order by tcnt desc)
where rownum <= 5;

--'19년 하반기 고객별 월별주문현황
select cust_nm, sum(m07) "07월", sum(m08) "08월", sum(m09) "09월",
       sum(m10) "10월", sum(m11) "11월", sum(m12) "12월",
       sum(m07+m08+m09+m10+m11+m12) "TOT"
from (select c.cust_nm, 
      	decode(substr(m.ord_dt,5,2),'07', tot_cnt, 0) m07,
       	decode(substr(m.ord_dt,5,2),'08', tot_cnt, 0) m08,
       	decode(substr(m.ord_dt,5,2),'09', tot_cnt, 0) m09,
       	decode(substr(m.ord_dt,5,2),'10', tot_cnt, 0) m10,
       	decode(substr(m.ord_dt,5,2),'11', tot_cnt, 0) m11,
       	decode(substr(m.ord_dt,5,2),'12', tot_cnt, 0) m12      
      from cust c, ord_mst m
      where c.cust_no = m.cust_no
      and substr(m.ord_dt,1,6) between '201907' and '201912')
group by cust_nm
order by 8 desc;

--'19년 하반기 고객별 월별주문현황
select *
from (select cust_nm, tot_cnt, substr(ord_dt,5,2) as month
      from cust, ord_mst
      where cust.cust_no = ord_mst.cust_no)
pivot(
      sum(tot_cnt)
      for month in ('07','08','09','10','11','12')
      );

--'19년 하반기 출판사별 월별주문현황
select pbcm_nm, bk_nm, sum(m07) "07월", sum(m08) "08월", sum(m09) "09월",
       sum(m10) "10월", sum(m11) "11월", sum(m12) "12월",
       sum(m07+m08+m09+m10+m11+m12) "TOT"
from (
    select p.pbcm_nm, b.bk_nm, 
       	decode(substr(m.ord_dt,5,2),'07', d.ord_cnt, 0) m07,
       	decode(substr(m.ord_dt,5,2),'08', d.ord_cnt, 0) m08,
       	decode(substr(m.ord_dt,5,2),'09', d.ord_cnt, 0) m09,
       	decode(substr(m.ord_dt,5,2),'10', d.ord_cnt, 0) m10,
       	decode(substr(m.ord_dt,5,2),'11', d.ord_cnt, 0) m11,
       	decode(substr(m.ord_dt,5,2),'12', d.ord_cnt, 0) m12
    from pbcm p, book b, ord_dtl d, ord_mst m
    where p.pbcm_cd = b.pbcm_cd
    and b.bk_no = d.bk_no
    and d.ord_no = m.ord_no
    and substr(m.ord_dt,1,6) between '201907' and '201912')
group by pbcm_nm, bk_nm
order by 1, 2;