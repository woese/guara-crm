#encoding: utf-8
begin
  admin = User.create!(name: "Adm Sistema",
                      email: "adm@adm.com",
                      password: "admini",
                      password_confirmation: "admini")
  admin.toggle!(:admin)

  SystemAbility.create([{ id:1, name: 'CREATE' }, { id:2, name: 'READ' }, { id:3, name: 'UPDATE' }, { id:4, name: 'DELETE' }])
  SystemModule.create([
                       { name: 'All' },
                       { name: 'User' },
                       { name: 'Customer' },
                       { name: 'Contact' },
                       { name: 'CustomerPj' },
                       { name: 'CustomerPf' },
                       { name: 'BusinessActivity' },
                       { name: 'BusinessSegment' },
                       { name: 'BusinessActivity' },
                       { name: 'Contact' },
                       { name: 'Micropost' },
                       { name: 'State' },
                       { name: 'City' },
                       { name: 'District' },
                       { name: 'Task' },
                    ])
                  
                  
                     
  SystemTaskStatus.create([
                           { name: "OPENED" },
                           { name: "IN_PROGRESS" },
                           { name: "PAUSED" },
                           { name: "CLOSED" },
                         ])
                       
  SystemTaskResolution.create([
                            { name: "RESOLVED" },
                            { name: "CANCELED" },
                            { name: "BLOCKED" },
                            { name: "RESOLVED_WITH_BUSINESS", parent_id: 1 }
                         ])
                    

  ### States

  State.create  ([
                    { acronym: "AC", name: "Acre"},
                    { acronym: 'AL', name: 'Alagoas' },
                    { acronym: 'AM', name: 'Amazonas' },
                    { acronym: 'AP', name: 'Amapá' },
                    { acronym: 'BA', name: 'Bahia' },
                    { acronym: 'CE', name: 'Ceará' },
                    { acronym: 'DF', name: 'Distrito Federal' },
                    { acronym: 'ES', name: 'Espírito Santo' },
                    { acronym: 'GO', name: 'Goiás' },
                    { acronym: 'MA', name: 'Maranhão' },
                    { acronym: 'MG', name: 'Minas Gerais' },
                    { acronym: 'MS', name: 'Mato Grosso do Sul' },
                    { acronym: 'MT', name: 'Mato Grosso' },
                    { acronym: 'PA', name: 'Pará' },
                    { acronym: 'PB', name: 'Paraíba' },
                    { acronym: 'PE', name: 'Pernambuco' },
                    { acronym: 'PI', name: 'Piauí' },
                    { acronym: 'PR', name: 'Paraná' },
                    { acronym: 'RJ', name: 'Rio de Janeiro' },
                    { acronym: 'RN', name: 'Rio Grande do Norte' },
                    { acronym: 'RR', name: 'Roraima' },
                    { acronym: 'RO', name: 'Rondônia' },
                    { acronym: 'RS', name: 'Rio Grande do Sul' },
                    { acronym: 'SC', name: 'Santa Catarina' },
                    { acronym: 'SE', name: 'Sergipe' },
                    { acronym: 'SP', name: 'São Paulo' },
                    { acronym: 'TO', name: 'Tocantins' },
                ])


  ### City
  City.create( name: 'Fortaleza', state: State.find_by_acronym('CE') )

  #segmento
  BusinessSegment.create(name:'Segmento Padrão')

  #atividade
  BusinessActivity.create(name:'Atividade Padrão')

  #Administração
  BusinessDepartment.create([
                      { name: "Administração" },
                      { name: "RH" }
                    ])
rescue Exception => exception
  logger =  Logger.new(STDOUT)
  logger.error("Error running task db:seed - #{exception.message} #{exception.class} #{exception.record.to_yaml}\n#{exception.record.errors.to_yaml}\n\n")
  logger.info exception.backtrace.to_yaml
end