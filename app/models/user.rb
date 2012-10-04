class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username,:email, :password, :password_confirmation, :remember_me

  # validates_presence_of :password, :message=>"Ingresar password"
  validates_presence_of :username, :message=>"no puede estar en blanco"
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :message=>"no puede estar en blanco"
  validates_uniqueness_of :email
  validates_uniqueness_of :username


end