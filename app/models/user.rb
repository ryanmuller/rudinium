class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  acts_as_learner

  def learn(item)
    Spaceable::Memory.create(:component_id => item.id, :learner_id => self.id)
  end

  def studying?(item)
    self.memories.find_by_component_id(item.id)
  end
end
