-- Populate the user account table --
INSERT INTO ffx_fire_ops.user_account (username, email, first_name, last_name, created_by, updated_by, is_account_locked) VALUES 
  ('ldrotos1', 'louis.drotos.1@fairfaxfire.gov', 'Louis', 'Drotos', 'ldrotos1', 'ldrotos1', FALSE),
  ('jdoe1', 'john.doe.1@fairfaxfire.gov', 'John', 'Doe', 'ldrotos1', 'ldrotos1', FALSE), 
  ('dwebb1', 'drew.webb.1@fairfaxfire.gov', 'Drew', 'Webb', 'ldrotos1', 'ldrotos1', FALSE),
  ('bdixon1', 'brad.dixon.1@fairfaxfire.gov', 'Brad', 'Dixon', 'ldrotos1', 'ldrotos1', FALSE), 
  ('mcook1', 'marcus.cook.1@fairfaxfire.gov', 'Marcus', 'Cook', 'ldrotos1', 'ldrotos1', FALSE), 
  ('lbaird1', 'liz.baird.1@fairfaxfire.gov', 'Liz', 'Baird', 'ldrotos1', 'ldrotos1', TRUE), 
  ('cmcgee1', 'cory.mcgee.1@fairfaxfire.gov', 'Corey', 'McGee', 'ldrotos1', 'ldrotos1', FALSE), 
  ('cpatrick1', 'constance.patrick.1@fairfaxfire.gov', 'Constance', 'Patrick', 'ldrotos1', 'ldrotos1', FALSE), 
  ('droach1', 'dana.roach.1@fairfaxfire.gov', 'Dana', 'Roach', 'ldrotos1', 'ldrotos1', FALSE), 
  ('wallen1', 'wallace.allen.1@fairfaxfire.gov', 'Wallace', 'Allen', 'ldrotos1', 'ldrotos1', TRUE),
  ('mcook2', 'mike.cook.2@fairfaxfire.gov', 'Mike', 'Cook', 'ldrotos1', 'ldrotos1', FALSE), 
  ('ttaylor1', 'trisha.taylor.1@fairfaxfire.gov', 'Trisha', 'Taylor', 'ldrotos1', 'ldrotos1', FALSE);

INSERT INTO ffx_fire_ops.account_role (role_name, role_description) VALUES 
  ('READER', 'Provides read and view access to the application'),
  ('ADMIN', 'Provides full access to all application features'), 
  ('DISPATCHER', 'Provides access to the dispatching feature'),
  ('USER_ACCOUNT_ADMIN', 'Provides access to the user account management features'), 
  ('OPS_ADMIN', 'Provides access to the operations management features'), 
  ('PERSONNEL_ADMIN', 'Provides access to the personnel management features');

INSERT INTO ffx_fire_ops.user_account_role (username, role_name) VALUES 
  ('ldrotos1', 'ADMIN'),
  ('jdoe1', 'READER'),
  ('dwebb1', 'OPS_ADMIN'),
  ('bdixon1', 'OPS_ADMIN'),
  ('mcook1', 'OPS_ADMIN'), 
  ('dwebb1', 'READER'),
  ('bdixon1', 'READER'),
  ('mcook1', 'READER'),
  ('mcook1', 'PERSONNEL_ADMIN'),
  ('lbaird1', 'PERSONNEL_ADMIN'),
  ('cpatrick1', 'PERSONNEL_ADMIN'),
  ('cpatrick1', 'READER'),
  ('droach1', 'USER_ACCOUNT_ADMIN'),
  ('wallen1', 'USER_ACCOUNT_ADMIN'), 
  ('ttaylor1', 'DISPATCHER'),
  ('mcook2', 'READER'),
  ('ttaylor1', 'READER'),
  ('ttaylor1', 'OPS_ADMIN');