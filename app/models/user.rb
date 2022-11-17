class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :stocks
  has_many :transactions

  if User.count == 0
    enum role: [:trader, :admin]
    after_initialize :set_default_role_admin, :if  => :new_record?
    enum account_status: [:pending, :approved]
    after_initialize :set_account_approved, :if  => :new_record?
  else
    enum role: [:trader, :admin]
    after_initialize :set_default_role_trader, :if  => :new_record?
    enum account_status: [:pending, :approved]
    after_initialize :set_account_pending, :if  => :new_record?
  end

  def set_default_role_trader
    self.role ||= :trader
  end

  def set_default_role_admin
    self.role ||= :admin
  end

  def set_account_pending
    self.account_status ||= :pending
  end

  def set_account_approved
    self.account_status ||= :approved
  end
end
