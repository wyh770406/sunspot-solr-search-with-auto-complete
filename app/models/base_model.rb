# coding: utf-8
module BaseModel
  extend ActiveSupport::Concern

  module ClassMethods
    # Redis 搜索存储索引
    def redis_search_index(options = {})
      title_field = options[:title_field] || :title
      ext_fields = options[:ext_fields] || []
      class_eval %(
        def redis_search_ext_fields(ext_fields)
          exts = {}
          ext_fields.each do |f|
            exts[f] = instance_eval(f.to_s)
          end
          exts
        end

        after_create :create_search_index
        def create_search_index
          s = Search.new(:title => self.#{title_field}, :id => self.id,
                          :exts => self.redis_search_ext_fields(#{ext_fields}),
                          :type => self.class.to_s)
          s.save
        end

        before_destroy :remove_search_index
        def remove_search_index
          Search.remove(:title => self.#{title_field}, :type => self.class.to_s)
        end

        before_update :update_search_index
        def update_search_index
          index_fields_changed = false
          #{ext_fields}.each do |f|
            next if f.to_s == "id"
            if instance_eval(f.to_s + "_changed?")
              index_fields_changed = true
            end
          end
          begin
            if(self.#{title_field}_changed?)
              index_fields_changed = true
            end
          rescue
          end
          if index_fields_changed
            Rails.logger.debug { "-- update_search_index --" }
            Search.remove(:title => self.#{title_field}_was, :type => self.class.to_s)
            self.create_search_index
          end
        end
      )
    end
  end
end
