#TODO: pegar parametros do rake
namespace :db do
  task add_user_privilegie: :environment do
    User.where("email like ?", '%test%')[0].abilities.build(:module => SystemModule.CUSTOMER, :ability => SystemAbility.UPDATE).save
  end
end