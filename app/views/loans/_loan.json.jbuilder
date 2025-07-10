json.extract! loan, :id, :equipment_id, :collaborator_id, :action, :loan_date, :return_date, :return_reason,
              :discard_date, :discard_reason, :created_at, :updated_at
json.url loan_url(loan, format: :json)
