# == Schema Information
#
# Table name: chefs
#
#  id              :integer          not null, primary key
#  chefname        :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  admin           :boolean          default(FALSE)
#

require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup 
    @chef = Chef.new(chefname: "john", email: "john@example.com")
  end
  
  test "chef should be valid" do 
    assert @chef.valid?  
  end
  
  test "chefname should be present" do 
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do 
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname should not be too shortr" do 
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test "email length should be within bounds" do 
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email should be unique" do 
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid addresses" do 
    valid_addresses = %w[user@example.com R_TDD-DS@eee.hello.org user@eee.com first.last@example.com]
    valid_addresses.each do |address|
      @chef.email = address
      assert @chef.valid?, '#{address.inspect} should be valid'
    end
  end
  
  test "email validation should reject invalid addresses" do 
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example.]
    invalid_addresses.each do |address|
      @chef.email = address
      assert_not @chef.valid?, "#{address.inspect} should be invalid"
    end
  end
end
