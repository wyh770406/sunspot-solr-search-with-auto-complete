  class School
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    include Mongoid::Timestamps::Updated

    field :name, :type => String
    field :desc, :type => String   

    has_many :products

  end