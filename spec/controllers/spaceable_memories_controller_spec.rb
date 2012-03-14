require 'spec_helper'

describe SpaceableMemoriesController do

  describe "POST 'create'" do

    before(:each) do
      @user = User.create(:email => 'asdf@adsf.com', :password => 'password', :password_confirmation => 'password')
      sign_in @user
      @item = Item.create(:name => 'thing', :content => 'stuff')
    end

    it "should create a memory" do
      lambda do
        post :create, :spaceable_memory => { :component_id => @item.id }
        response.should be_redirect
      end.should change(Spaceable::Memory, :count).by(1)
    end

    it "should belong to the right user" do
      post :create, :spaceable_memory => { :component_id => @item.id }
      @user.memories.find_by_component_id(@item.id).should_not be_nil
    end

    it "should create a memory using Ajax" do
      lambda do
        xhr :post, :create, :spaceable_memory => { :component_id => @item.id }
        response.should be_success
      end.should change(Spaceable::Memory, :count).by(1)
    end

  end
end
