class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :stocks
  has_many :transactions

  enum role: [:trader, :admin]
  enum account_status: [:pending, :approved, :null]
  after_initialize :set_default_role_and_account_status, :if  => :new_record?


  private
  def set_default_role_and_account_status
    self.role = :trader
    self.account_status = :pending
  end
end
