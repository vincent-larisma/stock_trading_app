class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: [:trader, :admin]
  after_initialize :set_default_role_admin, :if  => :new_record?
  def set_default_role_trader
    self.role ||= :trader
  end

  def set_default_role_admin
    self.role ||= :admin
  end
end
