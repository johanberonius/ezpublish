UPDATE ezsite_data SET value='3.5.0alpha1' WHERE name='ezpublish-version';
UPDATE ezsite_data SET value='1' WHERE name='ezpublish-release';

-- We allow users from the "Editors" group 
-- access only to "Root Folder" and "Media" trees.
DELETE FROM ezuser_role WHERE id=30 AND role_id=3;  
INSERT INTO ezuser_role
       (role_id, contentobject_id, limit_identifier,limit_value)
       VALUES (3,13,'Subtree','/1/2/');
INSERT INTO ezuser_role
       (role_id, contentobject_id, limit_identifier,limit_value)
       VALUES (3,13,'Subtree','/1/43/');

-- the support of redirect payment gateways
-- create table for eZPaymentObjects
CREATE TABLE ezpaymentobject(
    id int not null primary key auto_increment,
    workflowprocess_id int not null,
    order_id int not null default '0',
    payment_string varchar(255),
    status int not null default '0'
    ) TYPE=MyISAM;

ALTER TABLE ezbasket ADD COLUMN order_id integer NOT NULL default 0;
