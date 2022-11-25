class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :stocks, dependent: :delete_all
  has_many :transactions, dependent: :delete_all

  enum role: [:trader, :admin]
  enum account_status: [:pending, :approved, :null]
  after_initialize :set_default_role_and_account_status, :if  => :new_record?

  
  scope :trader, -> { where(role: :trader) }
  scope :pendings, -> { where(account_status: :pending) }

  validates :role, :account_status, presence: true

  private
  def set_default_role_and_account_status
    self.role = :trader
    self.account_status = :pending
  end
end
