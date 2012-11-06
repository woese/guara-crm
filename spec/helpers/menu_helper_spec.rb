require 'spec_helper'

require Rails.root.join("config/guara/menus.rb")
include 

describe MenuHelper do
  
  subject { MenuHelper }

  describe "maintence menu" do
    before { menu = build_menu_maintence() }
    
    it { menu.should be_a(String) }
    
  end
  
  describe "administration menu" do
    before { menu = build_menu_admin() }
    
    it { menu.should include( link_to(user_path(), I18n.t("users.link") ) ) }
    
  end
  
  
end