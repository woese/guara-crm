#encoding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    begin    
      Faker::Config.locale = [:en]
      logger =  Logger.new(STDOUT)
    
      User.where(admin:false).each do |u|
        u.destroy_fully()
      end
    
      Micropost.destroy_all()
    
      User.create!(name: "Teste User",
                       email: "teste@teste.com",
                       password: "testes",
                       password_confirmation: "testes")

      8.times do |n|
        name  = "#{Faker::Name.name} Gen #{n} "[0..24]

        logger.info name
        email = "example-#{n+1}@guaracrm.org"
        password  = "password"
        User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password)
      end
    
      users = User.all(limit: 5)
      users[2..4].each do |user|
        26.times do
          content = Faker::Lorem.sentence(5)
          user.microposts.create!(content: content)
        end
      end
    
    
      def make_relationships
        users = User.all
        user  = users.first
        followed_users = users[2..5]
        followers      = users[3..7]
        followed_users.each { |followed| user.follow!(followed) }
        followers.each      { |follower| follower.follow!(user) }
      end
    
      Customer.all.each { |u| u.destroy_fully }
      logger.info "Customers Destroyed"
    
      #Customer APPLE
      apple = Factory(:customer_pj, customer: Factory(:customer, name: "Apple")).customer

      logger.info "Customer Eggs Created"
    
      # Business Department
      business_department_adm = BusinessDepartment.all[0]
      business_department_prd = BusinessDepartment.all[1]
        
      2.times { Factory(:contact, customer: apple, department: business_department_adm) }
      4.times { Factory(:contact, customer: apple, department: business_department_prd) }

      logger.info "Contacts Createds"
    
      #Customer
      5.times { Factory(:customer_pj) }
    
      logger.info "5 Customers created"
   
    rescue Exception => exception
      logger.error("Message for the log file #{exception.message}\n\n")
      logger.info exception.backtrace.to_yaml
    end
  end
end