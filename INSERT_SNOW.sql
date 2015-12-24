--SNOWFLAKE

DROP SEQUENCE s2;
CREATE SEQUENCE s2 START WITH 1;

INSERT INTO HR.TOWN_DIM_SF
  SELECT
    s2.nextval,
    id,
    name
  FROM hr.Town;

INSERT INTO hr.customer_dim_sf
  SELECT
    s2.nextval,
    c.id,
    round((sysdate - c.dob) / 365) AS "age",
    td.town_id
  FROM hr.customer c
    INNER JOIN hr.town t
      ON c.town_id = t.id
    INNER JOIN hr.town_dim_sf td
      ON c.town_id = td.TID;

INSERT INTO hr.time_dim_sf
  SELECT
    s2.nextval,
    to_char(orderdate, 'dd'),
    to_char(orderdate, 'mm'),
    to_char(orderdate, 'yyyy')
  FROM (
    SELECT DISTINCT orderdate
    FROM hr.ordert);

INSERT INTO hr.BRAND_DIM_SF
  SELECT
    s2.nextval,
    id,
    name
  FROM hr.brand;

INSERT INTO hr.CATEGORY_DIM_SF
  SELECT
    s2.nextval,
    id,
    name
  FROM hr.category;

INSERT INTO hr.product_dim_sf
  SELECT
    s2.nextval,
    p.id,
    c.category_id,
    b.BRAND_ID
  FROM hr.product p
    INNER JOIN hr.brand_dim_sf b
      ON p.brand_id = b.bid
    INNER JOIN hr.category_dim_sf c
      ON p.category_id = c.cid;

INSERT INTO hr.sales_fact_sf
  SELECT
    pd.product_id,
    cd.customer_id,
    t.time_id,
    oi.quantity,
    p.price
  FROM hr.orderitem oi
    INNER JOIN hr.ordert o
      ON oi.ordert_id = o.id
    INNER JOIN hr.product p
      ON oi.product_id = p.id
    INNER JOIN hr.time_dim_sf t
      ON (t.year = to_char(orderdate, 'yyyy')
          AND t.month = to_char(orderdate, 'mm')
          AND t.day = to_char(orderdate, 'dd'))
    INNER JOIN hr.product_dim_sf pd
      ON oi.product_id = pd.pid
    INNER JOIN hr.customer_dim_sf cd
      ON o.customer_id = cd.cid;
