--Testing
SELECT c.name "Name", c.surname "Surname", to_char(o.ORDERDATE, 'fmddth "of" Month YYYY') "Order Date"
FROM HR.CUSTOMER c
JOIN HR.ORDERt o
  ON(c.id = o.customer_id)
JOIN HR.TOWN t
  ON(t.id = c.town_id)
WHERE t.name = 'Ta Xbiex' AND o.ORDERDATE > TO_DATE('2013-03-10', 'YYYY-mm-dd');

SELECT o.ordert_id "Order Number", to_char(sum(p.price*o.quantity), '$9,999.99') "Total"
FROM HR.ORDERITEM o
JOIN HR.PRODUCT p
  ON(o.product_id = p.id)
GROUP BY o.ORDERT_ID
ORDER BY 2 DESC;

SELECT b.name "Brand name", p.name "Product Name"
FROM HR.BRAND b
LEFT OUTER JOIN HR.PRODUCT p
  ON(b.id = p.brand_id)
ORDER BY 2 DESC;

INSERT INTO HR.TOWN VALUES(55, null);
INSERT INTO HR.TOWN VALUES(1, 'Mosta');
INSERT INTO hr.customer VALUES (50,'Carrol','Kunimitsu',to_date('12-8-1989','dd-mm-yyyy'),'carrol_kunimitsu@yahoo.com','Female',217,'Lower Street',55);
