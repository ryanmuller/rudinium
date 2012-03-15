class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  acts_as_learner

  def learn!(item)
    memories.create!(:component_id => item.id, :component_type => item.class.to_s)
  end

  def studying?(item)
    self.memories.find_by_component_id(item.id)
  end

  def due_memories
    self.memories.due_before(Time.now.utc)
  end

end
