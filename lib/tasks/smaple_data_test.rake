#encoding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate_test: :environment do 
    
    FileTest.exist? File.dirname(__FILE__) + '/../../spec/factories.rb'
    
    require File.dirname(__FILE__) + '/../../spec/factories.rb'
    5.times { Factory(:customer_pj) }
    
    
  end
end