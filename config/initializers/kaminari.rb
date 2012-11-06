#if defined?(WillPaginate)
#  module WillPaginate
#    module ActiveRecord
#      module RelationMethods
#       def num_pages() count() / per_page() end
#        def per(value = nil) per_page(value) end
#        def total_count() count end
#      end
#    end
#    module CollectionMethods
#      alias_method :num_pages, :total_pages
#      def num_pages() count() / per_page() end
#      def per(value = nil) per_page(value) end
#      def total_count() count end
#    end
#  end
#end

Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end