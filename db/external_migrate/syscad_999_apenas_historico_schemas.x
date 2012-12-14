historico:  
  :type: :SCHEMA
  :from:
    :columns:
      :interested: integer
      :due_time: date
      :type_id: integer
      :assigned: integer
      :ignore1!: :ignore!
      :notes: string
      :finish_time: date
    :format: :XLS
    :url: db/external_migrate/syscad/historicos.xls
  :to:
    :format: :ACTIVE_RECORD
    :url: Task
  :transformer: SyscadHistoricosTransformer