class Keyword
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  index({ word: 1 }, { unique: true, background: true })
  index({ pinyin: 1 }, {  background: true })
  
  field :word
  field :pinyin
  field :hot, :type => Boolean, :default => false


end