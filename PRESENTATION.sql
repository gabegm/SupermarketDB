SELECT p.ID "Product ID", c.NAME "Category", TO_CHAR(o.ORDERDATE, 'fmdd') "Day", TO_CHAR(o.ORDERDATE, 'fmmm') "Month", TO_CHAR(o.ORDERDATE, 'yyyy') "Year", SUM(p.PRICE * oi.QUANTITY) "Total"
FROM HR.product p
  JOIN HR.category c
    ON (p.CATEGORY_ID = c.ID)
  JOIN HR.orderitem oi
    ON (oi.PRODUCT_ID = p.ID)
  JOIN HR.ordert o
    ON (oi.ORDERt_ID = o.ID)
GROUP BY p.ID, c.NAME, o.ORDERDATE
ORDER BY 3, 4, 5, 2 ,1;

SELECT pd.product_id "Product id", pd.category "Category", TO_CHAR(td.day, 'fm99') "Day", to_char(td.month, 'fm99') "Month", td.year "Year", SUM(sf.QUANTITY*sf.price) "Total Sales"
FROM HR.PRODUCT_DIM pd
      JOIN HR.SALES_FACT sf
      ON(sf.PRODUCT_ID = pd.PRODUCT_ID)
      JOIN HR.TIME_DIM td
      ON(sf.TIME_ID = td.TIME_ID)
GROUP BY pd.product_id, pd.category , td.day, td.month, td.year
ORDER BY 3, 4, 5, 2 ,1;

SELECT pd.PID "Product Id", cd.name "Category", TO_CHAR(td.DAY, 'fm99') "Day", to_char(td.MONTH, 'fm99') "Month", td.YEAR "Year",
  SUM(sf.QUANTITY * sf.PRICE) "Total Sales"
FROM HR.SALES_FACT_SF sf
  JOIN HR.PRODUCT_DIM_SF pd
    ON sf.PRODUCT_ID = pd.PRODUCT_ID
  JOIN HR.CATEGORY_DIM_SF cd
    ON pd.CATEGORY_ID = cd.CATEGORY_ID
  JOIN HR.TIME_DIM_SF td
    ON sf.TIME_ID = td.TIME_ID
GROUP BY pd.PID, cd.NAME, td.DAY, td.MONTH, td.YEAR
ORDER BY 3, 4, 5, 2, 1;
