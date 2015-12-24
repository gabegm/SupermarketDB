--Schema Objects
CREATE OR REPLACE VIEW ITEMDETAILS(id, name, weight, expiry_date, price, category_name) AS
  SELECT p.id, p.name, p.weight, p.expiry_date, p.price, c.name
  FROM HR.PRODUCT p
  JOIN HR.CATEGORY c
    ON(p.category_id = c.id)
  WHERE c.name = 'Frozen'
  WITH CHECK OPTION CONSTRAINT product_view;

CREATE OR REPLACE VIEW CUSTOMERDETAILS(name, surname, dob, gender, town) AS
  SELECT c.name, c.surname, c.dob, c.gender, t.name
  FROM HR.CUSTOMER c
  JOIN HR.TOWN t
    ON(c.town_id = t.id)
  WITH READ ONLY;
