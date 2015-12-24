-- STAR

DROP SEQUENCE s1;
CREATE SEQUENCE s1 START WITH 1;

-- customer dim

INSERT INTO hr.customer_dim
  SELECT
    s1.nextval,
    c.id,
    round((sysdate - c.dob) / 365) AS "age",
    t.name
  FROM hr.customer c
    INNER JOIN hr.town t
      ON c.town_id = t.id;

-- product dim
INSERT INTO hr.product_dim
  SELECT
    s1.nextval,
    p.id,
    b.name,
    c.name
  FROM hr.product p
    INNER JOIN hr.brand b
      ON p.brand_id = b.ID
    INNER JOIN hr.category c
      ON p.category_id = c.id;

--time dim
INSERT INTO hr.time_dim
  SELECT
    s1.nextval,
    to_char(orderdate, 'dd'),
    to_char(orderdate, 'mm'),
    to_char(orderdate, 'yyyy')
  FROM (
    SELECT DISTINCT orderdate
    FROM hr.ordert);

--sales fact
INSERT INTO hr.sales_fact
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
    INNER JOIN hr.time_dim t
      ON (t.year = to_char(orderdate, 'yyyy')
          AND t.month = to_char(orderdate, 'mm')
          AND t.day = to_char(orderdate, 'dd'))
    INNER JOIN hr.product_dim pd
      ON oi.product_id = pd.pid
    INNER JOIN hr.customer_dim cd
      ON o.customer_id = cd.cid;
