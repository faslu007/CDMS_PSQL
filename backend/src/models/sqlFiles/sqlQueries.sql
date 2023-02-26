-- Get all accounts a user has access to from joint table
SELECT json_object_agg(a.id, json_build_object( 'account_id', a.id, 'name', a.account_name, 'type', a.account_type)) 
FROM user_account ua
JOIN account a ON ua.account_id = a.id
WHERE ua.user_id = 1;




SELECT json_build_object(
         'account_id', a.id,
         'account_name', a.account_name,
         'account_type', a.account_type,
         'is_account_active', a.is_account_active,
         'hide_tables', a.hide_tables,
         'created_by', a.created_by,
         'updated_by', a.updated_by,
         'secretkey', a.secretkey,
         'providers', json_agg(
                          json_build_object(
                              'provider_id', p.id,
                              'providername', p.providername,
                              'isprovideractive', p.isprovideractive,
                              'hidetables', p.hidetables,
                              'provider_created_by', p.provider_created_by,
                              'provider_updated_by', p.provider_updated_by
                          )
                      )
       )
FROM "public".account a
JOIN "public".provider p ON a.id = p.accountid
WHERE a.id = 2
GROUP BY a.id;



INSERT INTO "public".in_network (payer, status, assigned_user, account_id, provider_id, tracking_id, due_date, active, description, document_upload_ids, created_by, updated_by, manual_sort_index)
VALUES (1, 'Active', 2, 3, 4, 'TRK001', '2023-03-01', true, 'Test in-network data', ARRAY[1, 2, 3], 1, 2, 3)
RETURNING to_json("public".in_network.*);



WITH inserted_provider AS (
  INSERT INTO "public".provider (providername, isprovideractive, hidetables, accountid, provider_created_by, provider_updated_by)
  VALUES ('James 2', true, '{"edi": false, "oon": true}', 1, 2, 3)
  RETURNING *
)
SELECT json_build_object(
  'provider_id', ip.id,
  'providername', ip.providername,
  'isprovideractive', ip.isprovideractive,
  'hidetables', ip.hidetables,
  'accountid', ip.accountid,
  'provider_created_by', ip.provider_created_by,
  'provider_updated_by', ip.provider_updated_by
) AS inserted_provider
FROM inserted_provider ip;



SELECT e.enumlabel
  FROM pg_enum e
  JOIN pg_type t ON e.enumtypid = t.oid
  WHERE t.typname = 'account_type'





DELETE FROM user_account;

INSERT INTO user_account (user_id, account_id)
SELECT id, 1 FROM "user";



