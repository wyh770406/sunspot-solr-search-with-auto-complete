  class Product
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    include Mongoid::Timestamps::Updated
    include Sunspot::Mongoid

    scope :from_kind, ->(kind){where(:kind => kind)}


    field :title, :type => String
    field :ctype, :type => String
    field :kind, :type  => String
    field :course, :type => String
    field :file_ext, :type => String    
    field :grade, :type  => String
    field :publisher, :type => String

    field :download_url, :type => String

    field :downloaded, :type => Boolean, :default => false
    belongs_to :product_url

    # belongs_to :course
    # belongs_to :school
    # belongs_to :grade
    # belongs_to :semester

    # belongs_to :ctype
    # belongs_to :publisher

    index({ kind: 1, title: 1 }, { unique: true })
    index({ product_url_id: 1 }, { unique: true, background: true })    
# =begin
#     index(
#       [
#         [ :kind, Mongo::ASCENDING ],
#         [ :title, Mongo::ASCENDING ]
#       ],
#       unique: true
#     )=end


    searchable do
      text :title, :stored => true
      text :ctype,:course,:publisher,:grade
      time    :created_at
    end

  end